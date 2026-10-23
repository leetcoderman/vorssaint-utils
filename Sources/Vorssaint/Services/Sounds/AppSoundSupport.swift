// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// A moment the app can mark with a sound. Each has its own switch, sound,
/// loudness and repeat count, so a moment worth looking up for can ring out
/// while a routine one only ticks.
///
/// Adding a moment: a case here, its group, feature, symbol and defaults
/// below, and its title and caption in its group's strings. Its preference
/// keys follow from the case name.
enum AppSound: String, CaseIterable, Identifiable {
    /// An agent's turn ends: the work is done and waits for you.
    case agentFinished
    /// An agent's turn opens.
    case agentStarted
    /// The island's timer reaches zero; its alarm repeats until dismissed.
    case timerFinished
    /// A window the island watches finishes or stalls.
    case watchFinished
    /// The Mac locks or unlocks: the padlock closing, then opening.
    case screenLock
    /// A typed trigger expands into its snippet.
    case snippetExpanded

    var id: String { rawValue }

    var group: AppSoundGroup {
        switch self {
        case .agentFinished, .agentStarted: return .agents
        case .timerFinished, .watchFinished, .screenLock: return .alerts
        case .snippetExpanded: return .typing
        }
    }

    /// The feature whose events play it; it is offered only while installed.
    var feature: AppFeature {
        switch self {
        case .agentFinished, .agentStarted: return .notchAgents
        case .timerFinished: return .notchTimer
        case .watchFinished: return .notchWatch
        case .screenLock: return .notch
        case .snippetExpanded: return .textSnippets
        }
    }

    var symbol: String {
        switch self {
        case .agentFinished: return "checkmark.circle"
        case .agentStarted: return "play.circle"
        case .timerFinished: return "timer"
        case .watchFinished: return "eye"
        case .screenLock: return "lock"
        case .snippetExpanded: return "text.append"
        }
    }

    /// A choice from `AppSoundLibrary`: a full chime for work that is done,
    /// a lighter one for work beginning. The sounds the app made before the
    /// Sounds page keep playing as they did.
    var defaultChoice: String {
        switch self {
        case .agentFinished: return "tone:Modern/Chord"
        case .agentStarted: return "tone:Modern/Aurora"
        case .timerFinished, .watchFinished: return "system:Glass"
        case .screenLock: return AppSoundChoice.padlockClosing.id
        // Stored bare, as the snippets page always has.
        case .snippetExpanded: return Defaults.defaultSnippetSoundName
        }
    }

    var defaultVolume: Double {
        switch self {
        case .agentFinished: return 1.5
        case .agentStarted, .timerFinished, .watchFinished, .screenLock, .snippetExpanded: return 1
        }
    }

    var defaultRepeats: Int { 1 }

    /// Whether it plays before anyone switches it on, as the alarm and the
    /// watch always have.
    var defaultEnabled: Bool {
        switch self {
        case .timerFinished, .watchFinished: return true
        case .agentFinished, .agentStarted, .screenLock, .snippetExpanded: return false
        }
    }

    /// Played by the sound server like the Mac's own alerts, on the sound
    /// effects output at the alert volume, while it is set as it came: the
    /// padlock and the snippet sound always played that way.
    var playsAsAlert: Bool {
        switch self {
        case .screenLock, .snippetExpanded: return true
        case .agentFinished, .agentStarted, .timerFinished, .watchFinished: return false
        }
    }

    /// How soon it may sound again. Snippets typed in a row each tick, and
    /// the alarm rings on its own beat.
    var minimumGap: TimeInterval {
        switch self {
        case .agentFinished, .agentStarted: return AppSoundSupport.minimumGap
        case .timerFinished, .watchFinished, .screenLock, .snippetExpanded: return 0
        }
    }

    // MARK: Keys

    /// The switch and sound a moment had on its own page before the Sounds
    /// page, still read and written so both pages agree and nobody's
    /// choice is lost. Their defaults stay registered with their pages.
    var legacyEnabledKey: String? {
        switch self {
        case .timerFinished: return DefaultsKey.notchTimerSoundEnabled
        case .watchFinished: return DefaultsKey.notchWatchSound
        case .screenLock: return DefaultsKey.notchLockSounds
        case .snippetExpanded: return DefaultsKey.snippetSoundEnabled
        case .agentFinished, .agentStarted: return nil
        }
    }

    var legacyNameKey: String? {
        self == .snippetExpanded ? DefaultsKey.snippetSoundName : nil
    }

    /// `soundAgentFinished`, and the same with `Name`, `Volume` and `Repeats`.
    var enabledKey: String { legacyEnabledKey ?? baseKey }
    var nameKey: String { legacyNameKey ?? baseKey + "Name" }
    var volumeKey: String { baseKey + "Volume" }
    var repeatsKey: String { baseKey + "Repeats" }

    private var baseKey: String { "sound" + rawValue.prefix(1).uppercased() + rawValue.dropFirst() }

    /// Every moment starts as it was, with its own sound, loudness and
    /// repeats. A key an older page registers is left to it.
    static var registeredDefaults: [String: Any] {
        var values: [String: Any] = [:]
        for sound in allCases {
            if sound.legacyEnabledKey == nil { values[sound.enabledKey] = sound.defaultEnabled }
            if sound.legacyNameKey == nil { values[sound.nameKey] = sound.defaultChoice }
            values[sound.volumeKey] = sound.defaultVolume
            values[sound.repeatsKey] = sound.defaultRepeats
        }
        return values
    }
}

/// A section of the Sounds page, in page order.
enum AppSoundGroup: String, CaseIterable, Identifiable {
    case agents
    /// The island's alarm, watch and padlock.
    case alerts
    /// Text snippets.
    case typing

    var id: String { rawValue }

    var sounds: [AppSound] { AppSound.allCases.filter { $0.group == self } }

    /// Whether the section's note shows: its sounds wait on a setting
    /// elsewhere.
    var noteApplies: Bool {
        switch self {
        case .agents: return !NotchAgentSupport.isEnabled()
        case .alerts: return !NotchSupport.isEnabled()
        case .typing: return !UserDefaults.standard.bool(forKey: DefaultsKey.textSnippetsEnabled)
        }
    }

    /// Its section title and each moment's words.
    func strings(_ language: AppLanguage) -> SoundGroupStrings {
        switch self {
        case .agents: return FeatureStrings.agentSounds(language)
        case .alerts: return FeatureStrings.alertSounds(language)
        case .typing: return FeatureStrings.typingSounds(language)
        }
    }
}

enum AppSoundSupport {
    /// The quietest a sound may be set: quieter reads as broken, and the
    /// switch is there to silence it.
    static let minimumVolume = 0.05
    /// Above full, the sound is boosted and held under the output's ceiling.
    static let maximumVolume = 2.0
    static let repeatChoices = [1, 2, 3]
    /// Several agents starting or finishing together are heard once.
    static let minimumGap: TimeInterval = 1.5

    static func isOn(_ sound: AppSound, in defaults: UserDefaults = .standard,
                     isAvailable: (AppFeature) -> Bool = { $0.isAvailable }) -> Bool {
        isAvailable(sound.feature)
            && defaults.object(forKey: DefaultsKey.soundsEnabled) as? Bool ?? true
            && defaults.object(forKey: sound.enabledKey) as? Bool ?? sound.defaultEnabled
    }

    /// Whether a moment plays as an alert now: an alert sound or the
    /// padlock, at full and once, so it sounds as it always did.
    static func playsAsAlert(_ sound: AppSound, choice: AppSoundChoice, in defaults: UserDefaults = .standard) -> Bool {
        sound.playsAsAlert && (choice.source == .system || choice.source == .builtIn)
            && volume(sound, in: defaults) == 1 && repeats(sound, in: defaults) == 1
    }

    /// The stored choice, or this moment's own when the stored one is not
    /// on this Mac, as when settings came from another.
    static func choice(_ sound: AppSound, in defaults: UserDefaults = .standard,
                       library: AppSoundLibrary = .shared) -> AppSoundChoice? {
        if let stored = defaults.string(forKey: sound.nameKey).flatMap(AppSoundChoice.init(id:)),
           library.url(for: stored) != nil {
            return stored
        }
        if let own = AppSoundChoice(id: sound.defaultChoice), library.url(for: own) != nil { return own }
        return library.choices.first
    }

    static func volume(_ sound: AppSound, in defaults: UserDefaults = .standard) -> Double {
        let value = defaults.object(forKey: sound.volumeKey) as? Double ?? sound.defaultVolume
        return value.isFinite ? min(maximumVolume, max(minimumVolume, value)) : sound.defaultVolume
    }

    static func repeats(_ sound: AppSound, in defaults: UserDefaults = .standard) -> Int {
        let value = defaults.object(forKey: sound.repeatsKey) as? Int ?? sound.defaultRepeats
        return min(repeatChoices.last ?? 1, max(1, value))
    }

    static func isDue(after last: Date?, now: Date, gap: TimeInterval = minimumGap) -> Bool {
        guard let last else { return true }
        return now.timeIntervalSince(last) >= gap || now < last
    }
}
