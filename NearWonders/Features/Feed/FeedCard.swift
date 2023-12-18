//
//  FeedCard.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct FeedCard: View {
    let activity: FeedActivity
    @State var saved = false
    
    var body: some View {
        let imageCarousel = HStack(spacing: 16) {
            ForEach(activity.images.sorted(), id: \.self) { item in
                AsyncImage(url: URL(string: item)) { image in
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
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: 16))
            }
        }
        
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                imageCarousel.padding([.horizontal, .top])
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(activity.title).font(.title3)
                    Text(activity.date.formatted(date: .long, time: .omitted)).font(.footnote)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Image(systemName: saved ? "bookmark.fill": "bookmark").padding(.bottom, 2)
                    Text((activity.bookmarks + (saved ? 1 : 0)).formatted()).font(.footnote)
                }.onTapGesture { saved.toggle() }
            }.padding(.horizontal).padding(.top, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(activity.activities.sorted(by: {$0.name < $1.name})) {
                        ActivityTag(activity: $0)
                    }
                }.padding([.horizontal])
            }.padding([.bottom])
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 16))
//        .shadow(color: .black.opacity(0.1), radius: 20)
//        .padding(.horizontal)
//        .padding(.vertical, 8)
    }
}

#Preview {
    FeedCard(activity: exampleFeedActivity)
}

