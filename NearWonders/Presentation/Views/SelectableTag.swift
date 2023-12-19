//
//  SelectableTag.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import SwiftUI

struct SelectableTag: View {
    let imageUrl: String?
    let systemImage: String?
    let title: String
    let color: Color
    @Binding var selected: Bool
    
    init(title: String, color: Color, selected: Binding<Bool>) {
        self.systemImage = nil
        self.imageUrl = nil
        self.title = title
        self.color = color
        self._selected = selected
    }
    
    init(imageUrl: String?, title: String, color: Color, selected: Binding<Bool>) {
        self.systemImage = nil
        self.imageUrl = imageUrl
        self.title = title
        self.color = color
        self._selected = selected
    }
    
    init(systemImage: String?, title: String, color: Color, selected: Binding<Bool>) {
        self.systemImage = systemImage
        self.imageUrl = nil
        self.title = title
        self.color = color
        self._selected = selected
    }
    
    
    
    var body: some View {
        HStack {
            if imageUrl != nil {
                AsyncImage(url: URL(string: imageUrl!)) { image in
                    if (image.image == nil && image.error == nil) {
                        Color.black.opacity(0.1).clipShape(.rect(cornerRadius: 8))
                    } else if (image.error != nil) {
                        Image(systemName: "xmark.circle").foregroundColor(.yellow)
                    } else {
                        color.mask { image.image!.resizable().scaledToFit() }
                    }
                }.frame(width: 24, height: 24)
            } else if systemImage != nil {
                Image(systemName: systemImage!).frame(width: 24, height: 24)
            }
            Text(title).font(.footnote)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundColor(color)
        .if(selected) {
            $0
                .shadow(color: color.opacity(0.6), radius: 10)
                .background(color.opacity(0.05))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(color))
                .clipShape(.rect(cornerRadius: 8))
        }
        .onTapGesture { selected.toggle() }
    }
}

//#Preview {
//    SelectableTag()
//}
