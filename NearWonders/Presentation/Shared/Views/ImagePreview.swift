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
    
    init(imageUrl: String, size: CGFloat = 200) {
        self.imageUrl = imageUrl
        self.size = size
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
        .clipShape(.rect(cornerRadius: 16))
    }
}


#Preview {
    ImagePreview(imageUrl: "https://via.placeholder.com/200", size: 400)
}
