//
//  ButtonStyles.swift
//  NearWonders
//
//  Created by Jay Thakur on 29/12/23.
//

import SwiftUI

struct FlatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

#Preview {
    Button("Title") {
        print("Tapped")
    }
        .buttonStyle(FlatButtonStyle())
}
