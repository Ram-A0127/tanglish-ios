import UIKit

final class KeyboardViewController: UIInputViewController {
    private let instantPredictions: [String: [String]] = [
        "vanakkam da": ["nalam thaane?", "eppadi irukka?", "seekiram sollu"],
        "vanakkam": ["eppadi irukka?", "nalam thaane?", "seekiram sollu"],
        "romba nalla": ["iruku da", "vishayam da!", "santhosama iruku"],
        "seri da": ["aama paakalam", "purinjikko da", "aprom pesalam"],
        "nalla iruku": ["neenga eppadi?", "santhosam da", "nalam thaane?"],
        "miss pannuren": ["seekiram paakanum da", "romba nalam paakala", "unnai pathi yosikren"],
        "romba neram": ["aachu da", "paakala yen?", "en aagire?"],
        "paravaillai": ["nalla aagum da", "yosikadha", "trust pannu"],
        "seekiram vaaren": ["wait pannu da", "seri pa", "romba late aaguthu"],
        "pasikuthu": ["enna saapidalam?", "biryani va?", "hotel pouvom da"],
        "poiren": ["seri da", "seekiram vaa", "wait pannuren"],
        "kaadhalikkiren": ["unnai matum da", "romba neram aachu paakama", "seekiram paakanum"],
        "thoonganum": ["seri thoong da", "nalla thoong", "seekiram pa"],
        "busy da": ["ippo time illa da", "konjam busy da", "aprom pesalam"],
        "aama da": ["correct", "nalla solninga", "seekiram pannom"],
        "unnai romba miss pannuren": ["seekiram paakanum da", "romba neram aachu", "unnai pathi yosikren"],
        "eppo varuva": ["seekiram vaa da", "wait pannuren", "naalekki varuviya?"],
        "naalekki vaaren wait pannu": ["seri da", "romba neram aachu", "seekiram vaa"],
        "seekiram vaa da": ["wait pannuren da", "romba neram aachu", "miss pannuren unnai"],
        "aama da promise": ["samba pannurom!", "naan wait pannuren", "seekiram vaa da"],
        "dei romba kovama iruku": ["romba kashtapadutha da", "mudiyala da", "en pannuva avan?"],
        "avan romba kashtapadutha": ["mudiyala da", "paakavey vendam", "romba kovama iruku"],
        "paravaillai namma paakalam": ["seri eppo?", "aama seekiram paakalam", "confirm pannu da"],
        "nalla aagum trust pannu": ["aama nambikkai iruku", "seekiram solve aagum", "nandri da"],
        "da romba dukhamaaa iruku": ["romba kashtama iruku da", "theriyala enna pannurathu", "yosikren da"],
        "romba kashtama iruku": ["theriyala enna pannurathu", "enna pannonom", "yaarum puriyala da"],
        "theriyala eppo nalla aagum": ["yosikren da", "konjam neram venum", "nambikkai illama iruku"],
        "naalekki va da": ["romba santhosama iruku", "wait pannuren da", "seekiram vaa please"],
        "romba santhosama iruku": ["unnai paakum pothu", "nee irukka seri da", "seekiram paakalam"],
        "da weekend enna plan": ["movie paakalam va?", "beach pouvom da", "enna pannalam sollu"],
        "movie paakalam va": ["semma idea da!", "entha movie?", "eppo pouvom?"],
        "saturday evening ok va": ["aama da perfect!", "seri confirm pannuren", "entha time exactly?"],
        "da semma news sollaren": ["romba nalla vishayam da!", "seekiram ketteengala?", "adhirchi aaguveenga!"],
        "job offer vandhuchu": ["romba santhosama iruku da!", "nambavey mudiyala!", "seekiram celebrate pannalam"],
        "dei thoongala": ["illai da enna aaichu?", "romba neram aachu thoonga", "yosikren da"],
        "romba yosikren": ["thoonga mudiyala da", "romba kashtama iruku", "enna pannurathu theriyala"],
        "naalaikki exam iruku": ["padikanum da", "romba nervous da", "help pannuva?"],
        "da office romba stress": ["deadline iruku da", "mudiyala romba", "help venum da"],
        "deadline irukku mudiyala": ["romba kashtama iruku da", "help pannuga da", "eppo mudiyum theriyala"],
        "i miss": ["unnai miss pannuren", "romba nalam paakala", "seekiram vaa da"],
        "i love": ["unnai kaadhalikkiren", "romba pidikkuthu machi", "seekiram paakanum"],
        "good morning": ["kalai vanakkam", "eppadi irukka?", "nalam thaane?"],
        "good night": ["nalla thoong da", "sweet dreams", "seekiram pa"],
        // Greetings
        "hai": ["eppadi irukka?", "nalam thaane?", "vanakkam da"],
        "hello": ["vanakkam da", "eppadi irukka?", "nalam thaane?"],
        "hey": ["enna da", "eppadi irukka?", "vanakkam"],
        // Responses
        "nalla irukken": ["neenga eppadi irukeenga?", "santhosam da", "nalam thaane?"],
        "seri": ["paakalam da", "purinjikko", "aprom pesalam"],
        "ok da": ["seri paakalam", "confirm pannu", "aprom pesalam"],
        "ok": ["seri da", "paakalam", "noted da"],
        "aama": ["correct da", "purinjikko", "seekiram pannom"],
        "illa": ["seri da paravaillai", "en da?", "enna aaichu?"],
        // Common expressions
        "romba": ["nalla iruku da", "kashtama iruku", "miss pannuren"],
        "konjam": ["neram venum da", "busy da", "help pannuva?"],
        "seekiram": ["vaa da", "pannuven da", "mudichu sollu"],
        "nandri": ["romba nandri da", "unga support ku", "illana mudiyathu"],
        "sorry": ["paravaillai da", "mannichukkonga", "nalla aagum"],
        // Questions
        "enna": ["pannure da?", "aaichu?", "vishayam?"],
        "eppo": ["varuva?", "pouve?", "paakalam?"],
        "eppadi": ["irukka?", "pannurathu?", "porathu?"],
        "yaar": ["solnanga?", "vandhaanga?", "pannanga?"],
        "enge": ["irukka?", "poure?", "vandhaanga?"],
        // Feelings
        "tired": ["romba tired da", "rest edukanum", "kashtama iruku"],
        "happy": ["romba santhosam da", "nalla vishayam", "seekiram sollu"],
        "sad": ["enna aaichu da?", "paravaillai nalla aagum", "sollu da"],
        "miss": ["pannuren da", "romba nalam paakala", "seekiram paakalam"],
        // Food
        "coffee": ["kudikalam va?", "venum da", "saapittiya?"],
        "tea": ["kudikalam va?", "venum da", "saapittiya?"],
        "lunch": ["saapittiya?", "saapidalam va?", "enna saapida?"],
        "dinner": ["saapittiya?", "saapidalam va?", "enna saapida?"],
        // Planning
        "tomorrow": ["paakalam da", "time iruka?", "confirm pannu"],
        "weekend": ["enna plan?", "paakalam va?", "free irukiya?"],
        "today": ["enna plan?", "time iruka?", "paakalam va?"],
        "naalekki": ["paakalam da", "time iruka?", "confirm pannu"],
        "innikki": ["enna plan?", "time iruka?", "paakalam va?"],
        // Work
        "meeting": ["iruku da", "mudinjuchu", "eppo?"],
        "office": ["romba busy da", "stress da", "seekiram mudiyum"],
        "work": ["panren da", "romba busy", "seekiram mudiyum"],
        "deadline": ["iruku da", "romba tight", "help venum"],
        "i am tired": ["romba tired aaguthu da", "kashtama iruku", "rest edukanum"],
    ]

    private let localCorrections: [String: (std: String, tamil: String)] = [
        "vanakam": ("vanakkam", "வணக்கம்"),
        "vanagam": ("vanakkam", "வணக்கம்"),
        "vannakam": ("vanakkam", "வணக்கம்"),
        "nandree": ("nandri", "நன்றி"),
        "nandru": ("nandri", "நன்றி"),
        "ramba": ("romba", "ரொம்ப"),
        "rumba": ("romba", "ரொம்ப"),
        "rombe": ("romba", "ரொம்ப"),
        "eppidi": ("eppadi", "எப்படி"),
        "eppudi": ("eppadi", "எப்படி"),
        "yeppadi": ("eppadi", "எப்படி"),
        "epadi": ("eppadi", "எப்படி"),
        "therila": ("theriyala", "தெரியல"),
        "purila": ("puriyala", "புரியல"),
        "mudila": ("mudiyala", "முடியல"),
        "solren": ("sollaren", "சொல்லரேன்"),
        "sollren": ("sollaren", "சொல்லரேன்"),
        "sikram": ("seekiram", "சீக்கிரம்"),
        "konjum": ("konjam", "கொஞ்சம்"),
        "kadhal": ("kaadhal", "காதல்"),
        "nala": ("nalla", "நல்ல"),
        "romba": ("romba", "ரொம்ப"),
        "vanakkam": ("vanakkam", "வணக்கம்"),
    ]

    /// Minimum length of the current word before calling the standardise API (local corrections can still apply at this length).
    private let minimumWordLengthForStandardise = 4

    private let englishWords: Set<String> = [
        "i", "im", "dont",
        "want", "love", "miss", "hate", "need", "have",
        "like", "come", "go", "see", "know", "think",
        "feel", "sorry", "thanks", "okay", "yes", "no",
        "what", "why", "how", "when", "where", "who",
        "my", "your", "we", "they", "good", "bad", "nice",
        "happy", "sad", "angry", "help", "wait", "stop",
        "please", "sure", "maybe", "already", "still",
    ]

    private let keyHeight: CGFloat = 42
    private let spaceKeyHeight: CGFloat = 46
    private let keyGap: CGFloat = 6
    private let keyboardHeight: CGFloat = 260

    private var isShiftEnabled = false
    private var capsLockEnabled = false
    private var debounceWorkItem: DispatchWorkItem?
    private var shiftSingleTapWorkItem: DispatchWorkItem?
    private var lastShiftTapTime: TimeInterval = 0
    private let shiftDoubleTapInterval: TimeInterval = 0.3
    private var currentSuggestion: TanglishAPIService.SuggestionResult?
    private var lastShownSuggestion: (raw: String, std: String)? = nil
    private var lastAcceptedSuggestion: String? = nil
    private var lastAcceptedRaw: String? = nil
    private var charCountAfterAcceptance: Int = 0
    private var isNumbersMode = false
    private var isEmojiPanelVisible = false
    private var buttonsWithWidthConstraint = Set<ObjectIdentifier>()
    /// Letter keys only (QWERTY rows); empty when in numbers mode.
    private var keyButtons: [[UIButton]] = []

    private lazy var keyboardContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = keyGap
        return stack
    }()

    private lazy var modeToggleButton: UIButton = makeKeyButton(title: "123", action: #selector(handleNumberMode))
    private lazy var emojiPanelButton: UIButton = makeKeyButton(title: "😊", action: #selector(handleEmojiPanel))

    private lazy var leftSuggestionButton: UIButton = makeSuggestionButton(
        title: "—",
        textColor: UIColor(hex: "#6B7280"),
        font: .systemFont(ofSize: 13, weight: .regular)
    )

    private lazy var centerSuggestionButton: UIButton = makeSuggestionButton(
        title: "",
        textColor: UIColor(hex: "#D97706"),
        font: .systemFont(ofSize: 15, weight: .bold)
    )

    private lazy var rightSuggestionButton: UIButton = makeSuggestionButton(
        title: "—",
        textColor: UIColor(hex: "#6B7280"),
        font: .systemFont(ofSize: 13, weight: .regular)
    )

    private lazy var shiftButton: UIButton = makeKeyButton(title: "⇧", action: #selector(handleShift))
    private lazy var backspaceButton: UIButton = makeKeyButton(title: "⌫", action: #selector(handleBackspace))
    private lazy var globeButton: UIButton = makeKeyButton(title: "🌐", action: #selector(handleNextKeyboard))
    private lazy var spaceButton: UIButton = makeSpaceBarButton()
    private lazy var returnButton: UIButton = makeReturnKeyButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size.height = keyboardHeight
        setupKeyboardUI()
        updateShiftAppearance()
        warmUpCache()
    }

    private func warmUpCache() {
        let commonSentences = [
            "vanakkam da",
            "nalla iruku",
            "seri da",
            "romba nalla",
            "seekiram vaa",
        ]
        for sentence in commonSentences {
            TanglishAPIService.shared.predict(sentence: sentence) { _ in }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isShiftEnabled = true
        updateShiftAppearance()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        globeButton.isHidden = !needsInputModeSwitchKey
    }

    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)

        let context = textDocumentProxy.documentContextBeforeInput ?? ""
        let trimmed = context.trimmingCharacters(in: .whitespaces)
        let shouldCapitalise = trimmed.isEmpty ||
            trimmed.hasSuffix(". ") ||
            trimmed.hasSuffix("? ") ||
            trimmed.hasSuffix("! ")

        if shouldCapitalise, !isShiftEnabled, !capsLockEnabled {
            isShiftEnabled = true
            updateShiftAppearance()
        } else if !shouldCapitalise, isShiftEnabled, !capsLockEnabled {
            if !trimmed.isEmpty, let last = trimmed.last, !last.isWhitespace {
                isShiftEnabled = false
                updateShiftAppearance()
            }
        }

        scheduleSuggestionFetch()
    }

    private func setupKeyboardUI() {
        view.backgroundColor = UIColor(hex: "#F0F0F0")

        let rootStack = UIStackView()
        rootStack.axis = .vertical
        rootStack.spacing = keyGap
        rootStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(rootStack)

        NSLayoutConstraint.activate([
            rootStack.topAnchor.constraint(equalTo: view.topAnchor, constant: keyGap),
            rootStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: keyGap),
            rootStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -keyGap),
            rootStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyGap),
        ])

        let suggestionBar = UIStackView(arrangedSubviews: [
            leftSuggestionButton,
            centerSuggestionButton,
            rightSuggestionButton,
        ])
        suggestionBar.axis = .horizontal
        suggestionBar.distribution = .fillEqually
        suggestionBar.spacing = keyGap
        suggestionBar.translatesAutoresizingMaskIntoConstraints = false

        let suggestionBarContainer = UIView()
        suggestionBarContainer.translatesAutoresizingMaskIntoConstraints = false
        suggestionBarContainer.addSubview(suggestionBar)

        let suggestionBorder = UIView()
        suggestionBorder.backgroundColor = UIColor(hex: "#E5E7EB")
        suggestionBorder.translatesAutoresizingMaskIntoConstraints = false
        suggestionBarContainer.addSubview(suggestionBorder)

        NSLayoutConstraint.activate([
            suggestionBar.topAnchor.constraint(equalTo: suggestionBarContainer.topAnchor),
            suggestionBar.leadingAnchor.constraint(equalTo: suggestionBarContainer.leadingAnchor),
            suggestionBar.trailingAnchor.constraint(equalTo: suggestionBarContainer.trailingAnchor),
            suggestionBar.heightAnchor.constraint(equalToConstant: 44),

            suggestionBorder.topAnchor.constraint(equalTo: suggestionBar.bottomAnchor),
            suggestionBorder.leadingAnchor.constraint(equalTo: suggestionBarContainer.leadingAnchor),
            suggestionBorder.trailingAnchor.constraint(equalTo: suggestionBarContainer.trailingAnchor),
            suggestionBorder.bottomAnchor.constraint(equalTo: suggestionBarContainer.bottomAnchor),
            suggestionBorder.heightAnchor.constraint(equalToConstant: 0.5),

            suggestionBarContainer.heightAnchor.constraint(equalToConstant: 44.5),
        ])

        leftSuggestionButton.tag = 0
        centerSuggestionButton.tag = 1
        rightSuggestionButton.tag = 2
        attachSuggestionBarHighlightHandlers(to: leftSuggestionButton)
        attachSuggestionBarHighlightHandlers(to: centerSuggestionButton)
        attachSuggestionBarHighlightHandlers(to: rightSuggestionButton)

        rootStack.addArrangedSubview(suggestionBarContainer)

        rootStack.addArrangedSubview(keyboardContentStack)
        rebuildKeyboardRows()
    }

    private func setFixedWidthIfNeeded(_ button: UIButton, _ width: CGFloat) {
        let id = ObjectIdentifier(button)
        guard !buttonsWithWidthConstraint.contains(id) else { return }
        buttonsWithWidthConstraint.insert(id)
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    private func setMinimumWidthIfNeeded(_ button: UIButton, _ width: CGFloat) {
        let id = ObjectIdentifier(button)
        guard !buttonsWithWidthConstraint.contains(id) else { return }
        buttonsWithWidthConstraint.insert(id)
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
    }

    private func rebuildKeyboardRows() {
        keyboardContentStack.arrangedSubviews.forEach { row in
            keyboardContentStack.removeArrangedSubview(row)
            row.removeFromSuperview()
        }
        if isEmojiPanelVisible {
            keyButtons = []
            keyboardContentStack.addArrangedSubview(makeEmojiPanelContainer())
            return
        }
        if isNumbersMode {
            keyButtons = []
            modeToggleButton.setTitle("ABC", for: .normal)
            keyboardContentStack.addArrangedSubview(makeAlphaRow(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]))
            keyboardContentStack.addArrangedSubview(makeNumericRow2())
            keyboardContentStack.addArrangedSubview(makeNumericRow3())
            keyboardContentStack.addArrangedSubview(makeNumericBottomRow())
        } else {
            modeToggleButton.setTitle("123", for: .normal)
            let (row1, buttons1) = makeLetterKeyRow(["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"])
            let (row2, buttons2) = makeLetterKeyRow(["a", "s", "d", "f", "g", "h", "j", "k", "l"])
            let (row3, buttons3) = makeThirdRow()
            keyboardContentStack.addArrangedSubview(row1)
            keyboardContentStack.addArrangedSubview(row2)
            keyboardContentStack.addArrangedSubview(row3)
            keyboardContentStack.addArrangedSubview(makeQwertyBottomRow())
            keyButtons = [buttons1, buttons2, buttons3]
            updateKeyTitles()
        }
    }

    private func makeLetterKeyRow(_ letters: [String]) -> (UIStackView, [UIButton]) {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.spacing = keyGap
        var buttons: [UIButton] = []
        for letter in letters {
            let button = makeKeyButton(title: letter, action: #selector(handleKeyPress(_:)))
            row.addArrangedSubview(button)
            buttons.append(button)
        }
        return (row, buttons)
    }

    private func makeAlphaRow(_ letters: [String]) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.spacing = keyGap

        for letter in letters {
            row.addArrangedSubview(makeKeyButton(title: letter, action: #selector(handleKeyPress(_:))))
        }
        return row
    }

    private func makeThirdRow() -> (UIStackView, [UIButton]) {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fill
        row.spacing = keyGap

        setFixedWidthIfNeeded(shiftButton, 56)
        setFixedWidthIfNeeded(backspaceButton, 56)

        row.addArrangedSubview(shiftButton)
        var letterButtons: [UIButton] = []
        for letter in ["z", "x", "c", "v", "b", "n", "m"] {
            let button = makeKeyButton(title: letter, action: #selector(handleKeyPress(_:)))
            row.addArrangedSubview(button)
            letterButtons.append(button)
        }
        row.addArrangedSubview(backspaceButton)
        return (row, letterButtons)
    }

    private func makeNumericRow2() -> UIStackView {
        let symbols = ["-", "/", ":", ";", "(", ")", "£", "&", "@", "\""]
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.spacing = keyGap
        for s in symbols {
            row.addArrangedSubview(makeKeyButton(title: s, action: #selector(handleKeyPress(_:))))
        }
        return row
    }

    private func makeNumericRow3() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fill
        row.spacing = keyGap

        let hashEq = makeKeyButton(title: "#=", action: #selector(handleMultiCharKeyPress(_:)))
        setFixedWidthIfNeeded(hashEq, 56)
        setFixedWidthIfNeeded(backspaceButton, 56)

        row.addArrangedSubview(hashEq)
        for s in [".", ",", "?", "!", "'"] {
            row.addArrangedSubview(makeKeyButton(title: s, action: #selector(handleKeyPress(_:))))
        }
        row.addArrangedSubview(backspaceButton)
        return row
    }

    private func makeQwertyBottomRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fill
        row.spacing = keyGap

        setFixedWidthIfNeeded(modeToggleButton, 56)
        setFixedWidthIfNeeded(emojiPanelButton, 56)
        setFixedWidthIfNeeded(globeButton, 56)
        setFixedWidthIfNeeded(returnButton, 72)
        setMinimumWidthIfNeeded(spaceButton, 140)

        row.addArrangedSubview(modeToggleButton)
        row.addArrangedSubview(emojiPanelButton)
        row.addArrangedSubview(globeButton)
        row.addArrangedSubview(spaceButton)
        row.addArrangedSubview(returnButton)
        return row
    }

    private func makeNumericBottomRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fill
        row.spacing = keyGap

        setFixedWidthIfNeeded(modeToggleButton, 56)
        setFixedWidthIfNeeded(returnButton, 72)
        setMinimumWidthIfNeeded(spaceButton, 140)

        row.addArrangedSubview(modeToggleButton)
        row.addArrangedSubview(spaceButton)
        row.addArrangedSubview(returnButton)
        return row
    }

    private func makeEmojiPanelContainer() -> UIView {
        let outer = UIView()
        outer.translatesAutoresizingMaskIntoConstraints = false
        outer.backgroundColor = UIColor(hex: "#F0F0F0")
        outer.heightAnchor.constraint(equalToConstant: 216).isActive = true

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(hex: "#F0F0F0")
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true

        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = keyGap
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let emojiRows: [[String]] = [
            ["😂", "😭", "🥹", "😍", "🥰"],
            ["❤️", "🧡", "💛", "💚", "💙"],
            ["🙏", "👍", "🤝", "💪", "🫶"],
            ["🔥", "✨", "💯", "🎉", "😎"],
            ["🌺", "🪔", "🎊", "🫂", "😤"],
            ["🍛", "🍚", "🫓", "☕", "🧆"],
            ["😅", "🤣", "😬", "🙈", "😴"],
        ]

        for symbols in emojiRows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = keyGap
            for symbol in symbols {
                rowStack.addArrangedSubview(makeEmojiKeyButton(symbol))
            }
            rowStack.heightAnchor.constraint(equalToConstant: 44).isActive = true
            contentStack.addArrangedSubview(rowStack)
        }

        let backButton = makeEmojiBackButton()
        contentStack.addArrangedSubview(backButton)

        outer.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: outer.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: outer.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: outer.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: outer.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])

        return outer
    }

    private func makeEmojiKeyButton(_ emoji: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(emoji, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleEmojiInsert(_:)), for: .touchUpInside)
        return button
    }

    private func makeEmojiBackButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ABC", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor(hex: "#111827"), for: .normal)
        button.backgroundColor = UIColor(hex: "#FFFFFF")
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        button.heightAnchor.constraint(equalToConstant: keyHeight).isActive = true
        button.addTarget(self, action: #selector(handleDismissEmojiPanel), for: .touchUpInside)
        return button
    }

    private func makeKeyButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(hex: "#111827"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(hex: "#FFFFFF")
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        button.heightAnchor.constraint(equalToConstant: keyHeight).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    private func makeSuggestionButton(title: String, textColor: UIColor, font: UIFont) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        button.addTarget(self, action: #selector(suggestionTapped(_:)), for: .touchUpInside)
        return button
    }

    private func attachSuggestionBarHighlightHandlers(to button: UIButton) {
        button.addTarget(self, action: #selector(suggestionTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(suggestionTouchUp(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(suggestionTouchUp(_:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(suggestionTouchUp(_:)), for: .touchCancel)
    }

    @objc private func suggestionTouchDown(_ sender: UIButton) {
        let flash: UIColor = sender.tag == 1
            ? UIColor(hex: "#FEF3C7")
            : UIColor(hex: "#F3F4F6")
        sender.backgroundColor = flash
    }

    @objc private func suggestionTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.12) {
            sender.backgroundColor = .white
        }
    }

    private func makeSpaceBarButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("space", for: .normal)
        button.setTitleColor(UIColor(hex: "#6B7280"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(hex: "#FFFFFF")
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        button.heightAnchor.constraint(equalToConstant: spaceKeyHeight).isActive = true
        button.addTarget(self, action: #selector(handleSpace), for: .touchUpInside)
        return button
    }

    private func makeReturnKeyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("return", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(hex: "#ADB5BD")
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        button.heightAnchor.constraint(equalToConstant: keyHeight).isActive = true
        button.addTarget(self, action: #selector(handleReturn), for: .touchUpInside)
        return button
    }

    @objc private func handleKeyPress(_ sender: UIButton) {
        guard let title = sender.currentTitle, title.count == 1 else { return }
        if let rejected = lastShownSuggestion {
            TanglishAPIService.shared.logRejectedSuggestion(
                raw: rejected.raw,
                suggested: rejected.std
            )
            lastShownSuggestion = nil
        }
        let output = isShiftEnabled ? title.uppercased() : title.lowercased()

        if title == "." || title == "?" || title == "!" {
            textDocumentProxy.insertText(output)
            handlePostAcceptanceKeyInserted()
            if !capsLockEnabled {
                isShiftEnabled = false
            }
            updateShiftAppearance()
            scheduleSuggestionFetch()
            return
        }

        textDocumentProxy.insertText(output)
        handlePostAcceptanceKeyInserted()

        if isShiftEnabled, !capsLockEnabled, output.first?.isLetter == true {
            isShiftEnabled = false
            updateShiftAppearance()
        }

        scheduleSuggestionFetch()
    }

    private func handlePostAcceptanceKeyInserted() {
        guard lastAcceptedSuggestion != nil else { return }
        charCountAfterAcceptance += 1

        if charCountAfterAcceptance <= 4 {
            let context = textDocumentProxy.documentContextBeforeInput ?? ""
            let words = context.components(separatedBy: " ")
            if let compoundWord = words.dropLast().last,
               compoundWord.count > 2 {
                TanglishAPIService.shared.logAcceptedSuggestion(
                    raw: compoundWord,
                    std: compoundWord
                )
            }
        } else {
            lastAcceptedSuggestion = nil
            lastAcceptedRaw = nil
            charCountAfterAcceptance = 0
        }
    }

    @objc private func handleMultiCharKeyPress(_ sender: UIButton) {
        guard let title = sender.currentTitle, !title.isEmpty else { return }
        textDocumentProxy.insertText(title)
    }

    @objc private func handleBackspace() {
        textDocumentProxy.deleteBackward()
    }

    @objc private func handleSpace() {
        if let rejected = lastShownSuggestion {
            TanglishAPIService.shared.logRejectedSuggestion(
                raw: rejected.raw,
                suggested: rejected.std
            )
            lastShownSuggestion = nil
        }
        textDocumentProxy.insertText(" ")
        lastAcceptedSuggestion = nil
        lastAcceptedRaw = nil
        charCountAfterAcceptance = 0

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
            guard let self else { return }
            let context = self.textDocumentProxy.documentContextBeforeInput ?? ""
            let shouldCap = context.hasSuffix(". ") ||
                context.hasSuffix("? ") ||
                context.hasSuffix("! ") ||
                context.trimmingCharacters(in: .whitespaces).isEmpty
            if shouldCap, !self.capsLockEnabled {
                self.isShiftEnabled = true
                self.updateShiftAppearance()
            }
            self.scheduleSuggestionFetch()
        }
    }

    @objc private func handleReturn() {
        textDocumentProxy.insertText("\n")
    }

    @objc private func handleShift() {
        let now = ProcessInfo.processInfo.systemUptime

        if now - lastShiftTapTime < shiftDoubleTapInterval {
            shiftSingleTapWorkItem?.cancel()
            shiftSingleTapWorkItem = nil
            lastShiftTapTime = 0

            if capsLockEnabled {
                capsLockEnabled = false
                isShiftEnabled = false
            } else {
                capsLockEnabled = true
                isShiftEnabled = true
            }
            updateShiftAppearance()
            return
        }

        lastShiftTapTime = now
        shiftSingleTapWorkItem?.cancel()

        if capsLockEnabled {
            capsLockEnabled = false
            isShiftEnabled = false
            updateShiftAppearance()
            let work = DispatchWorkItem { [weak self] in self?.lastShiftTapTime = 0 }
            shiftSingleTapWorkItem = work
            DispatchQueue.main.asyncAfter(deadline: .now() + shiftDoubleTapInterval, execute: work)
            return
        }

        if isShiftEnabled {
            isShiftEnabled = false
            updateShiftAppearance()
            let work = DispatchWorkItem { [weak self] in self?.lastShiftTapTime = 0 }
            shiftSingleTapWorkItem = work
            DispatchQueue.main.asyncAfter(deadline: .now() + shiftDoubleTapInterval, execute: work)
            return
        }

        isShiftEnabled = true
        updateShiftAppearance()

        let work = DispatchWorkItem { [weak self] in self?.lastShiftTapTime = 0 }
        shiftSingleTapWorkItem = work
        DispatchQueue.main.asyncAfter(deadline: .now() + shiftDoubleTapInterval, execute: work)
    }

    private func updateShiftAppearance() {
        let arrowColor = UIColor(hex: "#111827")
        shiftButton.setTitleColor(arrowColor, for: .normal)

        if capsLockEnabled {
            shiftButton.setTitle("⇪", for: .normal)
            shiftButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            shiftButton.backgroundColor = UIColor(hex: "#6B7280")
        } else if isShiftEnabled {
            shiftButton.setTitle("⇧", for: .normal)
            shiftButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            shiftButton.backgroundColor = UIColor(hex: "#D1D5DB")
        } else {
            shiftButton.setTitle("⇧", for: .normal)
            shiftButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            shiftButton.backgroundColor = UIColor(hex: "#FFFFFF")
        }

        updateKeyTitles()
    }

    private func updateKeyTitles() {
        for row in keyButtons {
            for button in row {
                guard let title = button.currentTitle,
                      title.count == 1 else { continue }
                let newTitle = (isShiftEnabled || capsLockEnabled)
                    ? title.uppercased()
                    : title.lowercased()
                button.setTitle(newTitle, for: .normal)
            }
        }
    }

    @objc private func handleNextKeyboard() {
        advanceToNextInputMode()
    }

    @objc private func handleNumberMode() {
        isEmojiPanelVisible = false
        isNumbersMode.toggle()
        rebuildKeyboardRows()
    }

    @objc private func handleEmojiPanel() {
        isEmojiPanelVisible = true
        isNumbersMode = false
        rebuildKeyboardRows()
    }

    @objc private func handleDismissEmojiPanel() {
        isEmojiPanelVisible = false
        rebuildKeyboardRows()
    }

    @objc private func handleEmojiInsert(_ sender: UIButton) {
        guard let emoji = sender.title(for: .normal), !emoji.isEmpty else { return }
        textDocumentProxy.insertText(emoji)
        scheduleSuggestionFetch()
    }

    @objc private func suggestionTapped(_ sender: UIButton) {
        let suggestionText = sender.title(for: .normal) ?? sender.titleLabel?.text
        guard let suggestion = suggestionText?.trimmingCharacters(in: .whitespacesAndNewlines),
              !suggestion.isEmpty,
              suggestion != "—"
        else { return }

        lastShownSuggestion = nil

        guard let word = currentWordAfterLastSpace(), !word.isEmpty else {
            textDocumentProxy.insertText(suggestion + " ")
            updateSuggestionBar(left: "", centre: "", right: "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.scheduleSuggestionFetch()
            }
            return
        }

        for _ in word {
            textDocumentProxy.deleteBackward()
        }

        let shouldCapitalise = word.first?.isUppercase == true
        let finalSuggestion = shouldCapitalise
            ? String(suggestion.prefix(1).uppercased() + suggestion.dropFirst())
            : suggestion
        textDocumentProxy.insertText(finalSuggestion + " ")
        lastAcceptedSuggestion = finalSuggestion
        lastAcceptedRaw = word
        charCountAfterAcceptance = 0
        TanglishAPIService.shared.logAcceptedSuggestion(
            raw: word,
            std: finalSuggestion
        )
        updateSuggestionBar(left: "", centre: "", right: "")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.scheduleSuggestionFetch()
        }
    }

    private func scheduleSuggestionFetch() {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.fetchSuggestionForCurrentWord()
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: workItem)
    }

    private func fetchSuggestionForCurrentWord() {
        guard let before = textDocumentProxy.documentContextBeforeInput else {
            updateSuggestionBar(left: "", centre: "", right: "")
            return
        }

        let sentence = before.trimmingCharacters(in: .whitespacesAndNewlines)

        let word = currentWordAfterLastSpace() ?? ""

        if !word.isEmpty {
            let wordLower = word.lowercased()

            if let correction = localCorrections[wordLower] {
                updateSuggestionBar(left: word, centre: correction.std, right: correction.tamil)
                return
            }

            if englishWords.contains(wordLower) {
                TanglishAPIService.shared.standardise(word: word, isEnglish: true) { [weak self] result in
                    guard let self else { return }
                    self.updateSuggestionBar(
                        left: word,
                        centre: result?.std ?? "",
                        right: result?.tamil ?? ""
                    )
                }
                return
            }

            if word.count >= minimumWordLengthForStandardise {
                TanglishAPIService.shared.standardise(word: word, isEnglish: false) { [weak self] result in
                    guard let self else { return }
                    self.updateSuggestionBar(
                        left: word,
                        centre: result?.std ?? "",
                        right: result?.tamil ?? ""
                    )
                }
            } else {
                updateSuggestionBar(left: "", centre: "", right: "")
            }
            return
        }

        if let instant = lookupInstantPredictions(for: sentence) {
            updateSuggestionBar(left: instant[0], centre: instant[1], right: instant[2])
            return
        }

        TanglishAPIService.shared.predict(sentence: sentence) { [weak self] predictions in
            guard let self else { return }
            self.updateSuggestionBar(
                left: predictions.count > 0 ? predictions[0] : "",
                centre: predictions.count > 1 ? predictions[1] : "",
                right: predictions.count > 2 ? predictions[2] : ""
            )
        }
    }

    private func updateSuggestionBar(left: String, centre: String, right: String) {
        leftSuggestionButton.setTitle(left, for: .normal)
        centerSuggestionButton.setTitle(centre, for: .normal)
        rightSuggestionButton.setTitle(right, for: .normal)

        if !centre.isEmpty, !left.isEmpty, left != centre {
            lastShownSuggestion = (raw: left, std: centre)
        } else {
            lastShownSuggestion = nil
        }
    }

    /// Characters after the last whitespace boundary (current word being typed).
    /// Returns nil when the cursor is immediately after whitespace (sentence-level prediction path).
    private func currentWordAfterLastSpace() -> String? {
        guard let before = textDocumentProxy.documentContextBeforeInput, !before.isEmpty else {
            return nil
        }
        if before.last?.isWhitespace == true {
            return nil
        }
        if let lastWhitespace = before.lastIndex(where: { $0.isWhitespace }) {
            return String(before[before.index(after: lastWhitespace)...])
        }
        return before
    }

    private func lookupInstantPredictions(for rawSentence: String) -> [String]? {
        let sentence = rawSentence.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if sentence.isEmpty { return nil }

        if let direct = instantPredictions[sentence] {
            return direct
        }

        let keysByLength = instantPredictions.keys.sorted { $0.count > $1.count }
        for key in keysByLength {
            let keyLower = key.lowercased()
            guard sentence.hasSuffix(keyLower) else { continue }
            if sentence.count == keyLower.count {
                return instantPredictions[key]
            }
            let prefixEnd = sentence.index(sentence.endIndex, offsetBy: -keyLower.count)
            let prefix = sentence[..<prefixEnd]
            if prefix.isEmpty || prefix.last == " " {
                return instantPredictions[key]
            }
        }
        return nil
    }
}

private extension UIColor {
    convenience init(hex: String) {
        let cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&int)
        let r = CGFloat((int >> 16) & 0xFF) / 255.0
        let g = CGFloat((int >> 8) & 0xFF) / 255.0
        let b = CGFloat(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
