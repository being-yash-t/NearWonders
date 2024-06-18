//
//  FeedCard.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct FeedCard: View {
    let locationSummary: LocationSummary
    @State var saved = false
    
    var body: some View {
        NavigationLink(destination: { LocationDetailsScreen(for: locationSummary)}) {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(locationSummary.images.sorted(), id: \.self) { ImagePreview(imageUrl: $0) }
                    }.padding(.horizontal)
                }
                .allowsHitTesting(true)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(locationSummary.title).font(.title3)
                        Text(locationSummary.date.formatted(date: .long, time: .omitted)).font(.footnote)
                    }
                    Spacer()
                    Text((locationSummary.bookmarks + (saved ? 1 : 0)).formatted())
                        .font(.footnote)
                        .onTapGesture { saved.toggle() }
                        .foregroundColor(saved ? .blue : .primary)
                    Image(systemName: saved ? "bookmark.fill": "bookmark")
                        .padding(.bottom, 2)
                        .onTapGesture { saved.toggle() }
                        .foregroundColor(saved ? .blue : .primary)
                }.padding(.horizontal).padding(.top, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(locationSummary.activities.sorted(by: {$0.name < $1.name})) {
                            Tag(title: $0.name, iconUrl: $0.iconData.rawValue, color: Color(rgb: $0.rgbColor))
                        }
                    }.padding([.horizontal])
                }
            }
            .padding(.bottom)
            //        .shadow(color: .black.opacity(0.1), radius: 20)
            //        .padding(.horizontal)
            //        .padding(.vertical, 8)
        }
        .buttonStyle(FlatButtonStyle())
    }
}

#Preview {
    FeedCard(locationSummary: mockLocationSummary3)
}


