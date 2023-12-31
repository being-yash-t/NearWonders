//
//  ImagePreview.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import SwiftUI

struct ImagePreview: View {
    let imageUrl: String
    let size: CGFloat
    let cornerRadius: CGFloat
    
    init(imageUrl: String, size: CGFloat = 200, cornerRadius: CGFloat = 16) {
        self.imageUrl = imageUrl
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            if (image.image == nil && image.error  == nil) {
                ZStack {
                    Color.black.opacity(0.1)
                    Text("Loading")
                }
            } else if (image.error != nil) {
                Image(systemName: "xmark.circle").foregroundColor(.yellow)
            }
            else { image.image!.resizable().scaledToFill() }
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: cornerRadius))
    }
}

struct MapImagePreview: View {
    let url: String
    let onTap: (() -> Void)?
    let size: CGFloat
    
    init(_ url: String, onTap: @escaping () -> Void, size: CGFloat = 50) {
        self.url = url
        self.onTap = onTap
        self.size = size
    }
    
    init(_ url: String, size: CGFloat = 50) {
        self.url = url
        self.onTap = nil
        self.size = size
    }
    
    var body: some View {
        return AsyncImage(url: URL(string: url)) { image in
            if (image.image != nil) {
                image.image!.resizable()
            } else {
                Color.black.opacity(0.2)
            }
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: 8))
        .shadow(radius: 10)
        .onTapGesture { onTap?() }
    }
}

#Preview {
    VStack {
        ImagePreview(imageUrl: "https://via.placeholder.com/200", size: kPreviewSize)
        MapImagePreview("https://via.placeholder.com/200")
    }
}
