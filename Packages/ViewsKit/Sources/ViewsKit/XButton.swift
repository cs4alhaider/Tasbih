//
//  XButton.swift
//  ViewsKit
//
//  Created by Abdullah Alhaider on 09/02/2023.
//

import SwiftUI

public struct XButton: View {
    public let action: (() -> Void)
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                Color.gray.opacity(0.3)
                    .opacity(0.8)
                    .frame(width: 35, height: 35)
                Image(systemName: "xmark")
                    .resizable()
                    .font(.body.bold())
                    .frame(width: 15, height: 15)
            }
            .clipShape(Circle())
        }
    }
}

public struct DismissXButton: ViewModifier {
    public let placement: ToolbarItemPlacement
    
    init(placement: ToolbarItemPlacement) {
        self.placement = placement
    }
    
    @Environment(\.dismiss) private var dismiss
    
    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    XButton {
                        dismiss()
                    }
                }
            }
    }
}

public extension View {
    @ViewBuilder
    public func dismissButton(placement: ToolbarItemPlacement = .topBarTrailing) -> some View {
        modifier(DismissXButton(placement: placement))
    }
}
