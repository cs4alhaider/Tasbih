//
//  CounterDetails.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import CounterKit
import Combine

struct CounterDetails: View {
    var counter: Counter
    
    var body: some View {
        VStack {
            if counter.desc.isNotEmpty {
                Text(counter.desc)
                    .padding()
            }
            TabView {
                ForEach(counter.sessions ?? []) { session in
                    VStack {
                        Text("\(session.hits.count)")
                            .font(.title)
                            .monospacedDigit()
                            .bold()
                        HitView(progressPercentage: session.progressPercentage ?? 100, color: counter.color.toColor()) { newHit in
                            session.addHit()
                        }
                    }
                    .padding()
                    .tag(session.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always)) // Set the TabView to page style
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(counter.name)
    }
}
