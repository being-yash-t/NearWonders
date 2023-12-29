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


#Preview {
    ImagePreview(imageUrl: "https://via.placeholder.com/200", size: 400)
}
