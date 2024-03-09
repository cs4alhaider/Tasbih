//
//  CounterSessionProgress.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 10/03/2024.
//

import SwiftUI

struct CounterSessionProgress: View {
    @Binding var progressPercentage: Double
    @Binding var color: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background layer with orange color and alpha of 0.3
                Rectangle()
                    .fill(color.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)

                // Foreground layer representing the progress
                Rectangle()
                    .fill(color.opacity(0.7))
                    .frame(width: CGFloat(progressPercentage) / 100.0 * geometry.size.width, height: geometry.size.height)
                    .animation(.linear(duration: 0.5), value: progressPercentage)
            }
        }
        .edgesIgnoringSafeArea(.all) // Extend the view to the edges of the screen
    }
}
