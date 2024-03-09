//
//  TypewriterTextView.swift
//  ViewsKit
//
//  Created by Abdullah Alhaider on 30/01/2024.
//

import SwiftUI
import Combine
import CoreHaptics

/// A SwiftUI view that displays text letter by letter with haptic feedback.
public struct TypewriterTextView: View {
    
    /// The text to be displayed.
    private let text: String
    
    /// Timer for controlling the display of each letter.
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>

    /// State variable for the text currently being displayed.
    @State private var displayedText: String = ""

    /// State variable for the current index in the text.
    @State private var index: Int = 0

    /// State variable for the haptic engine used for feedback.
    @State private var hapticEngine: CHHapticEngine?

    
    public init(text: String, speed interval: TimeInterval = 0.08) {
        self.text = text
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }

    /// The body of the view.
    public var body: some View {
        Text(displayedText) // Append "_" if still typing
            .onAppear {
                /// Prepare the haptic engine when the view appears.
                prepareHaptics()
            }
            .onReceive(timer) { _ in
                /// Add a letter each time the timer fires.
                addLetter()
            }
    }

    /// Adds the next letter in the text to the displayed text.
    private func addLetter() {
        guard index < text.count else {
            /// Cancel the timer and indicate typing has finished.
            timer.upstream.connect().cancel()
            return
        }

        /// Calculate the index of the next letter to be added.
        let letterIndex: String.Index = text.index(text.startIndex, offsetBy: index)
        /// Extract the letter from the text.
        let letter: Character = text[letterIndex]
        /// Append the letter to the displayed text.
        displayedText += "\(letter)"
        /// Increment the index to point to the next letter.
        index += 1

        /// Trigger haptic feedback if the letter is not a whitespace character.
        if letter != " " && letter != "\n" && letter != "\t" {
            triggerHaptic()
        }
    }

    /// Prepares the haptic engine for use.
    private func prepareHaptics() {
        /// Check if the device supports haptics.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            /// Create and start the haptic engine.
            self.hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            /// Print an error message if there's an issue creating the haptic engine.
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }

    /// Triggers a haptic feedback event.
    private func triggerHaptic() {
        guard let engine = hapticEngine else { return }

        /// Define the intensity and sharpness of the haptic feedback.
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        /// Create a haptic event of type transient (short and sharp).
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)

        do {
            /// Create a haptic pattern with the event and a player to play it.
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            /// Start the haptic player immediately.
            try player.start(atTime: 0)
        } catch {
            /// Print an error message if there's an issue playing the haptic.
            print("Failed to play haptic: \(error)")
        }
    }
}
