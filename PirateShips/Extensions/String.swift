//
//  String.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 27/12/2020.
//

import AVFoundation

extension String {
     /// Speech the string with English-GB voice
     func speech() {
        let utterance = AVSpeechUtterance(string: self)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
