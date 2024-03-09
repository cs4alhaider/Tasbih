//
//  CounterCard.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import Helper4Swift
import CounterKit

struct CounterCard: View {
    let counter: Counter
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(counter.name)
                    .font(.title.bold())
                    .foregroundStyle(counter.color.toColor().isDarkColor() ? .white : .black)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Session count is \(counter.sessions?.count ?? 0)")
                        Spacer()
                        Image(systemName: "arrow.forward")
                            .bold()
                    }
                }
                .foregroundStyle(counter.color.toColor().isDarkColor() ? .white.opacity(0.8) : .black.opacity(0.8))
                .padding(10)
                .background(.gray.gradient.opacity(0.2))
                .clipShape(.rect(cornerRadius: 8))
                .font(.callout.monospaced())
                .padding(.bottom, 7)
                
                
                Text("Created \(counter.createdAt.relativeTime())")
                    .foregroundStyle(counter.color.toColor().isDarkColor() ? .white.opacity(0.6) : .black.opacity(0.6))
                    .font(.caption2.monospaced())
                    .padding(.horizontal, 10)
            }
            .padding()
        }
        .background(counter.color.toColor().gradient)
        .clipShape(.rect(cornerRadius: 8))
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
        .shadow(radius: 15)
    }
}
