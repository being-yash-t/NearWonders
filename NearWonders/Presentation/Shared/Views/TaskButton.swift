//
//  ButtonWithLoader.swift
//  NearWonders
//
//  Created by Jay Thakur on 08/01/24.
//

import SwiftUI

struct TaskButton<Content: View>: View {
    
    @State var loading: Bool = false
    let action: () async -> Void
    @ViewBuilder let content: () -> Content
    
    init(action: @escaping () async -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }
    
    var body: some View {
        Button(action: onPressButton) {
            if loading {
                ProgressView()
            } else {
                content()
            }
        }.disabled(loading)
    }
    
    func onPressButton() {
        Task {
            withAnimation { loading = true }
            await action()
            withAnimation { loading = false }
        }
    }
    
}

#Preview {
    TaskButton(action: {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }) { Text("Hola").frame(maxWidth: .infinity) }
        .buttonStyle(.borderedProminent) 
        .padding()
}
