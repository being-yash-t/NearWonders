//
//  ActivityTag.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import SwiftUI

struct ActivityTag: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            if activity.icon != nil {
                AsyncImage(url: URL(string: activity.icon!)) { image in
                    if (image.image == nil && image.error == nil) {
                        Color.black.opacity(0.1).clipShape(.rect(cornerRadius: 8))
                    } else if (image.error != nil) {
                        Image(systemName: "xmark.circle").foregroundColor(.yellow)
                    } else {
                        Color(rgb: activity.rgbColor).mask { image.image!.resizable().scaledToFit() }
                    }
                }
                .frame(width: 24, height: 24)
            }
            Text(activity.name).font(.footnote)
        }
        .foregroundColor(Color(rgb: activity.rgbColor))
//        .shadow(color: Color(rgb: activity.rgbColor).opacity(0.2), radius: 20, y: -8)
    }
}

#Preview {
    ActivityTag(activity: exampleActivity1)
}
