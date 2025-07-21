//
//  SoundManager.swift
//  MillionerGame
//
//  Created by Иван Семенов on 21.07.2025.
//

import AVFoundation

enum SoundType: String {
    case accepted = "otvetPrinyat"
    case clock = "zvukChasov"
    case correct = "otvetVernyi"
    case alarm = "budilnik"
    case betterQuality = "boleeKachestvennyi"
    case wrong = "zvukNepravilnogo"
    
    var fileName: String { rawValue }
}

final class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    private init() {}

    func playSound(_ sound: SoundType, withExtension fileExtension: String = "mp3") {
        guard let url = Bundle.main.url(forResource: sound.fileName, withExtension: fileExtension) else {
            print("Sound file not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    func stopSound() {
        player?.stop()
    }
}
