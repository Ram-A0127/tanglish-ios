import Foundation

final class TanglishAPIService {
    struct SuggestionResult {
        let std: String
        let tamil: String
        let alt: String
        let source: String
    }

    static let shared = TanglishAPIService()

    private let instantPredictions: [String: [String]] = [
        "vanakkam da": ["eppadi irukka?", "nalam thaane?", "seekiram sollu"],
        "nalla iruku": ["santhosam da", "neenga eppadi?", "sollu da"],
        "seri da": ["aama paakalam", "purinjikko da", "aprom pesalam"],
        "romba nalla": ["iruku da", "vishayam da!", "santhosama iruku"],
        "miss pannuren": ["seekiram paakanum da", "romba nalam paakala", "unnai pathi yosikren"],
        "pasikuthu da": ["enna saapidalam?", "biryani va?", "hotel pouvom da"],
        "romba stress": ["deadline iruku da", "mudiyala da", "help venum da"],
        "dei romba": ["kashtama iruku da", "kovama iruku", "yosikren da"],
        "paravaillai da": ["nalla aagum", "trust pannu", "seekiram paakalam"],
        "seekiram vaa": ["wait pannuren da", "romba neram aachu", "miss pannuren"],
    ]

    private let supabaseURL = "https://uiwmcmutiywduqbeapnj.supabase.co"
    private let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpd21jbXV0aXl3ZHVxYmVhcG5qIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY0OTg5ODksImV4cCI6MjA5MjA3NDk4OX0.SGfj-hiBrTTt9hzjheXun_NawDUXFsOttcU9vMF1YZ4"

    private var cache: [String: SuggestionResult] = [:]
    private let cacheQueue = DispatchQueue(label: "TanglishAPIService.CacheQueue")
    private let session: URLSession

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        session = URLSession(configuration: configuration)
    }

    func standardise(word: String, isEnglish: Bool = false, completion: @escaping (SuggestionResult?) -> Void) {
        let trimmedWord = word.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedWord.isEmpty else {
            DispatchQueue.main.async { completion(nil) }
            return
        }

        let cacheKey = Self.standardiseCacheKey(word: trimmedWord, isEnglish: isEnglish)

        if let cached = cachedResult(for: cacheKey) {
            DispatchQueue.main.async { completion(cached) }
            return
        }

        guard let url = URL(string: "https://tanglish-ime.vercel.app/api/chat") else {
            DispatchQueue.main.async { completion(nil) }
            return
        }

        var request = URLRequest(url: url, timeoutInterval: 10)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = [
            "word": trimmedWord,
            "isEnglish": isEnglish,
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            DispatchQueue.main.async { completion(nil) }
            return
        }

        session.dataTask(with: request) { [weak self] data, _, error in
            guard error == nil, let data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            let parsed = Self.parseSuggestionResult(from: data)
            if let parsed, let self {
                self.storeCache(parsed, for: cacheKey)
            }

            DispatchQueue.main.async {
                completion(parsed)
            }
        }.resume()
    }

    func predict(sentence: String, completion: @escaping ([String]) -> Void) {
        let trimmed = sentence.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        for (key, predictions) in instantPredictions {
            if trimmed.hasSuffix(key) || trimmed == key {
                DispatchQueue.main.async {
                    completion(predictions)
                }
                return
            }
        }

        let trimmedSentence = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "https://tanglish-ime.vercel.app/api/predict") else {
            DispatchQueue.main.async { completion([]) }
            return
        }

        var request = URLRequest(url: url, timeoutInterval: 10)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = [
            "sentence": trimmedSentence,
            "generation": "millennial"
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            DispatchQueue.main.async { completion([]) }
            return
        }

        let task = session.dataTask(with: request) { data, _, error in
            guard error == nil, let data else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            let predictions = Self.parsePredictions(from: data)
            DispatchQueue.main.async {
                if predictions.isEmpty {
                    completion(["seri da", "paakalam", "aprom pesalam"])
                    return
                }
                completion(predictions)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            task.cancel()
        }
        task.resume()
    }

    func logAcceptedSuggestion(raw: String, std: String) {
        guard !raw.isEmpty, !std.isEmpty, raw != std else { return }
        guard let url = URL(string: "\(supabaseURL)/rest/v1/word_events") else { return }

        var request = URLRequest(url: url, timeoutInterval: 5)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "Authorization")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        let payload: [String: Any] = [
            "word_hash": hashWord(raw),
            "standard_form": std,
            "accepted": true,
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            return
        }

        URLSession.shared.dataTask(with: request) { _, _, _ in }.resume()
    }

    func logRejectedSuggestion(raw: String, suggested: String) {
        guard !raw.isEmpty, !suggested.isEmpty else { return }
        guard let url = URL(string: "\(supabaseURL)/rest/v1/word_events") else { return }

        var request = URLRequest(url: url, timeoutInterval: 5)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "Authorization")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        let payload: [String: Any] = [
            "word_hash": hashWord(raw),
            "standard_form": suggested,
            "accepted": false,
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            return
        }

        URLSession.shared.dataTask(with: request) { _, _, _ in }.resume()
    }

    private static func standardiseCacheKey(word: String, isEnglish: Bool) -> String {
        "\(word.lowercased())|en:\(isEnglish)"
    }

    private func cachedResult(for key: String) -> SuggestionResult? {
        cacheQueue.sync {
            cache[key]
        }
    }

    private func storeCache(_ result: SuggestionResult, for key: String) {
        cacheQueue.async {
            self.cache[key] = result
        }
    }

    private func hashWord(_ word: String) -> String {
        let lower = word.lowercased().trimmingCharacters(in: .whitespaces)
        var hash = 0
        for char in lower.unicodeScalars {
            hash = hash &* 31 &+ Int(char.value)
        }
        return String(format: "%08x", abs(hash))
    }

    private static func parseSuggestionResult(from data: Data) -> SuggestionResult? {
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return nil }

        if let root = object as? [String: Any] {
            if let direct = makeSuggestionResult(from: root) {
                return direct
            }

            if let nested = root["result"] as? [String: Any], let result = makeSuggestionResult(from: nested) {
                return result
            }

            if let nested = root["data"] as? [String: Any], let result = makeSuggestionResult(from: nested) {
                return result
            }
        }

        return nil
    }

    private static func makeSuggestionResult(from dictionary: [String: Any]) -> SuggestionResult? {
        guard let std = dictionary["std"] as? String else { return nil }
        let tamil = dictionary["tamil"] as? String ?? ""
        let alt = dictionary["alt"] as? String ?? ""
        let source = dictionary["source"] as? String ?? ""
        return SuggestionResult(std: std, tamil: tamil, alt: alt, source: source)
    }

    private static func parsePredictions(from data: Data) -> [String] {
        guard let object = try? JSONSerialization.jsonObject(with: data),
              let root = object as? [String: Any]
        else {
            return []
        }

        if let left = root["left"] as? String,
           let centre = root["centre"] as? String ?? root["center"] as? String,
           let right = root["right"] as? String {
            return [left, centre, right]
        }

        if let dataNode = root["data"] as? [String: Any],
           let left = dataNode["left"] as? String,
           let centre = dataNode["centre"] as? String ?? dataNode["center"] as? String,
           let right = dataNode["right"] as? String {
            return [left, centre, right]
        }

        return []
    }
}
