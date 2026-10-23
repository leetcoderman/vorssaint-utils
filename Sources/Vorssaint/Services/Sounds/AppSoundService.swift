// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit

/// Plays the app's sounds, each at its own loudness, on the main thread.
final class AppSoundService {
    static let shared = AppSoundService()

    private var lastPlayed: [AppSound: Date] = [:]
    /// The sound each moment last played, held until it is replaced so
    /// playback is never cut short.
    private var playing: [AppSound: NSSound] = [:]

    private init() {}

    /// Plays the sound for a moment when it is switched on.
    func play(_ sound: AppSound, now: Date = Date()) {
        guard AppSoundSupport.isOn(sound), AppSoundSupport.isDue(after: lastPlayed[sound], now: now) else { return }
        lastPlayed[sound] = now
        preview(sound)
    }

    /// Plays the chosen sound at its loudness, switched on or not.
    func preview(_ sound: AppSound) {
        guard let name = AppSoundSupport.name(sound),
              let tone = NSSound(contentsOf: TextSnippetSupport.soundFileURL(for: name), byReference: true) else { return }
        tone.volume = Float(AppSoundSupport.volume(sound))
        playing[sound]?.stop()
        playing[sound] = tone
        tone.play()
    }
}
