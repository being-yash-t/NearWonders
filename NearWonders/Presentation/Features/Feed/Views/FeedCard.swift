//
//  FeedCard.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct FeedCard: View {
    let activity: LocationActivity
    @State var saved = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(activity.images.sorted(), id: \.self) { ImagePreview(imageUrl: $0) }
                }.padding(.horizontal)
            }
            .allowsHitTesting(true)
            
            NavigationLink(destination: { LocationDetailsScreen(for: activity.location)}) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(activity.title).font(.title3)
                        Text(activity.date.formatted(date: .long, time: .omitted)).font(.footnote)
                    }
                    Spacer()
                    Text((activity.bookmarks + (saved ? 1 : 0)).formatted())
                        .font(.footnote)
                        .onTapGesture { saved.toggle() }
                        .foregroundColor(saved ? .blue : .black)
                    Image(systemName: saved ? "bookmark.fill": "bookmark")
                        .padding(.bottom, 2)
                        .onTapGesture { saved.toggle() }
                        .foregroundColor(saved ? .blue : .black)
                }.padding(.horizontal).padding(.top, 8)
            }.buttonStyle(FlatButtonStyle())
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(activity.activities.sorted(by: {$0.name < $1.name})) {
                        Tag(title: $0.name, iconUrl: $0.icon, color: Color(rgb: $0.rgbColor))
                    }
                }.padding([.horizontal])
            }
        }
        .padding(.bottom)
        //        .shadow(color: .black.opacity(0.1), radius: 20)
        //        .padding(.horizontal)
        //        .padding(.vertical, 8)
    }
}

#Preview {
    FeedCard(activity: mockLocationActivity3)
}


