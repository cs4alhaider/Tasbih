//
//  HitView.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 10/03/2024.
//

import SwiftUI

struct HitView: View {
    @State private var volumeObserver = VolumeObserver()
    let progressPercentage: Double
    let color: Color
    let newHit: ((Date) -> Void)
    
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
                    .animation(.smooth, value: progressPercentage)
            }
            .clipShape(.rect(cornerRadius: 12))
        }
        .edgesIgnoringSafeArea(.all) // Extend the view to the edges of the screen
        .padding(.bottom, 50)
        .onTapGesture {
            newHit(.now)
            volumeObserver.triggerHapticFeedback()
        }
        .onChange(of: volumeObserver.hit) { oldValue, newValue in
            newHit(newValue)
        }
    }
}

