//
//  ActivityTag.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import SwiftUI

// TODO: move icon to Icons enum
struct Tag: View {
    let title: String
    let iconUrl: String?
    let systemImage: String?
    let color: Color
    
    init(title: String, systemImage: String?, color: Color) {
        self.title = title
        self.iconUrl = nil
        self.systemImage = systemImage
        self.color = color
    }
    
    init(title: String, iconUrl: String?, color: Color) {
        self.title = title
        self.iconUrl = iconUrl
        self.systemImage = nil
        self.color = color
    }
    
    var body: some View {
        HStack {
            if iconUrl != nil {
                AsyncImage(url: URL(string: iconUrl!)) { image in
                    if (image.image == nil && image.error == nil) {
                        Color.black.opacity(0.1).clipShape(.rect(cornerRadius: 8))
                    } else if (image.error != nil) {
                        Image(systemName: "xmark.circle").foregroundColor(.yellow)
                    } else {
                        color.mask { image.image!.resizable().scaledToFit() }
                    }
                }
                .frame(width: 24, height: 24)
            } else if systemImage != nil {
                color.mask { Image(systemName: systemImage!) }.frame(width: 24, height: 24)
            }
            Text(title).font(.footnote)
        }
        .foregroundColor(color)
//        .shadow(color: Color(rgb: activity.rgbColor).opacity(0.2), radius: 20, y: -8)
    }
}

#Preview {
    VStack {
        Tag(title: Activity.Trek.name, iconUrl: Activity.Trek.iconData.rawValue, color: Color(rgb: Activity.Trek.rgbColor)).padding()
        Tag(title: Season.Winter.name, systemImage: Season.Winter.icon.rawValue, color: Color(rgb: Season.Winter.rgbColor))
    }
}
