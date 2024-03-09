//
//  CreateCounterSession.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import CounterKit
import Helper4Swift

struct CreateCounterSession: View {
    @Binding var session: CounterSession
    @State private var isOpenTarget: Bool = false
    @State private var lastTargetValue: Int = 100

    var body: some View {
        Section {
            TextField("Title (optional)", text: $session.title)
            Toggle(isOn: $isOpenTarget.animation()) {
                Text("Open Target")
            }

            if !isOpenTarget {
                Stepper("Target: \(session.target ?? 100)", value: $session.target ?? 100, in: 0...999_999_999)
            }
        }
        .onChange(of: isOpenTarget) { _, newValue in
            if newValue { // If toggled to open target
                lastTargetValue = session.target ?? 100 // Save the last target value
                session.target = nil // Remove specific target
            } else {
                session.target = lastTargetValue // Restore the last target value
            }
        }
    }
}

