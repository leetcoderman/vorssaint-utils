// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

enum AppSoundTests {
    static func run(_ suite: TestSuite) {
        strings(suite)
        preferences(suite)
        spacing(suite)
        starts(suite)
    }

    private static func strings(_ suite: TestSuite) {
        let english = Mirror(reflecting: FeatureStrings.sounds(.enUS)).children.count
        for language in AppLanguage.allCases {
            let text = Mirror(reflecting: FeatureStrings.sounds(language)).children.compactMap { $0.value as? String }
            suite.expect(text.count == english && text.allSatisfy { !$0.trimmingCharacters(in: .whitespaces).isEmpty },
                         "every Sounds string is written in \(language.rawValue)")
        }
    }

    private static func preferences(_ suite: TestSuite) {
        let name = "vorss.tests.app-sound.\(UUID().uuidString)"
        guard let defaults = UserDefaults(suiteName: name) else { return }
        defer { defaults.removePersistentDomain(forName: name) }
        let installed: (AppFeature) -> Bool = { _ in true }

        for sound in AppSound.allCases {
            suite.expect(Defaults.registeredDefaults[sound.enabledKey] as? Bool == false
                            && Defaults.registeredDefaults[sound.nameKey] as? String == sound.defaultName
                            && Defaults.registeredDefaults[sound.volumeKey] as? Double == sound.defaultVolume,
                         "\(sound.rawValue) is registered off, with its own sound and loudness, so backups carry it")
        }
        suite.expect(AppSound.agentFinished.defaultVolume > AppSound.agentStarted.defaultVolume,
                     "a finished agent rings louder than a starting one")

        suite.expect(!AppSoundSupport.isOn(.agentFinished, in: defaults, isAvailable: installed),
                     "a sound stays quiet until it is switched on")
        defaults.set(true, forKey: AppSound.agentFinished.enabledKey)
        suite.expect(AppSoundSupport.isOn(.agentFinished, in: defaults, isAvailable: installed),
                     "a sound switched on plays")
        suite.expect(!AppSoundSupport.isOn(.agentFinished, in: defaults, isAvailable: { _ in false }),
                     "a sound whose feature is uninstalled never plays")
        defaults.set(false, forKey: DefaultsKey.soundsEnabled)
        suite.expect(!AppSoundSupport.isOn(.agentFinished, in: defaults, isAvailable: installed),
                     "the page's switch silences every sound")

        let available = ["Glass", "Hero", "Tink"]
        suite.expect(AppSoundSupport.name(.agentStarted, in: defaults, available: available) == "Tink",
                     "an unset sound is the moment's own")
        defaults.set("Glass", forKey: AppSound.agentStarted.nameKey)
        suite.expect(AppSoundSupport.name(.agentStarted, in: defaults, available: available) == "Glass",
                     "a chosen sound plays")
        defaults.set("Gone", forKey: AppSound.agentStarted.nameKey)
        suite.expect(AppSoundSupport.name(.agentStarted, in: defaults, available: available) == "Tink",
                     "a sound this Mac lacks falls back to the moment's own")

        suite.expect(AppSoundSupport.volume(.agentStarted, in: defaults) == AppSound.agentStarted.defaultVolume,
                     "an unset loudness is the moment's own")
        defaults.set(0.0, forKey: AppSound.agentStarted.volumeKey)
        suite.expect(AppSoundSupport.volume(.agentStarted, in: defaults) == AppSoundSupport.minimumVolume,
                     "a sound switched on is never silent")
        defaults.set(4.0, forKey: AppSound.agentStarted.volumeKey)
        suite.expect(AppSoundSupport.volume(.agentStarted, in: defaults) == 1, "loudness tops out at full")
        defaults.set(Double.nan, forKey: AppSound.agentStarted.volumeKey)
        suite.expect(AppSoundSupport.volume(.agentStarted, in: defaults) == AppSound.agentStarted.defaultVolume,
                     "a broken loudness reads as the moment's own")
    }

    private static func spacing(_ suite: TestSuite) {
        let now = Date(timeIntervalSince1970: 1_000_000)
        suite.expect(AppSoundSupport.isDue(after: nil, now: now), "the first sound plays")
        suite.expect(!AppSoundSupport.isDue(after: now.addingTimeInterval(-0.5), now: now),
                     "agents starting together are heard once")
        suite.expect(AppSoundSupport.isDue(after: now.addingTimeInterval(-AppSoundSupport.minimumGap), now: now),
                     "a later moment is heard again")
        suite.expect(AppSoundSupport.isDue(after: now.addingTimeInterval(60), now: now),
                     "a clock set back does not silence sounds")
    }

    private static func starts(_ suite: TestSuite) {
        let now = Date(timeIntervalSince1970: 2_000_000)
        let store = AgentUsageStore()
        var heard: [AgentProvider] = []
        store.turnStarted = { heard.append($0) }

        store.apply([.turnBegan(now)], file: "early", provider: .codex, tracksTurns: true, modified: now, now: now)
        suite.expect(heard.isEmpty, "turns read before transitions are reported, at launch, are history")

        store.reportsTransitions = true
        store.apply([.turnBegan(now)], file: "a", provider: .codex, tracksTurns: true, modified: now, now: now)
        suite.expect(heard == [.codex], "a turn opening is heard")
        store.apply([.turnBegan(now)], file: "a", provider: .codex, tracksTurns: true, modified: now, now: now)
        suite.expect(heard == [.codex], "a log read again from its start opens no second turn")
        store.apply([.turnActive(now)], file: "a", provider: .codex, tracksTurns: true, modified: now, now: now)
        suite.expect(heard == [.codex], "work going on in an open turn is not a start")

        store.apply([.turnActive(now)], file: "b", provider: .claude, tracksTurns: true, modified: now, now: now)
        suite.expect(heard == [.codex, .claude], "work seen before its turn's opening starts it all the same")

        let old = now.addingTimeInterval(-AgentUsageStore.lateEnd - 1)
        store.apply([.turnBegan(old)], file: "c", provider: .codex, tracksTurns: true, modified: now, now: now)
        suite.expect(heard.count == 2, "a turn found late, long after it opened, is not news")

        store.apply([.turnBegan(now)], file: "d", provider: .opencode, tracksTurns: false, modified: now, now: now)
        suite.expect(heard.count == 2, "a subagent's work belongs to its parent's turn")

        store.closeIdleTurns(now: now.addingTimeInterval(NotchAgentSupport.idleTurn), after: NotchAgentSupport.idleTurn)
        store.apply([.turnActive(now.addingTimeInterval(NotchAgentSupport.idleTurn + 1))], file: "a", provider: .codex,
                    tracksTurns: true, modified: now, now: now.addingTimeInterval(NotchAgentSupport.idleTurn + 1))
        suite.expect(heard.count == 2, "work resuming after an approval is the same turn, not a new start")
    }
}
