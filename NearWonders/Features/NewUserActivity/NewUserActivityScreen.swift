//
//  NewUActivityScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import SwiftUI
import MapKit

private let previewImageSize: CGFloat = 150

struct NewUserActivityScreen: View {
    @State var images: Set<String> = []
    @State var description: String = ""
    @State var activities: [Activity] = []
    @State var seasons: [Season] = []
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Location").font(.headline).padding([.horizontal, .top])
                    Map(interactionModes: [.pitch, .zoom])
                        .frame(height: 150)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding([.bottom, .horizontal])
                    
                    Text("Pictures").font(.headline).padding([.horizontal])
                    ImageUploader(images: $images)
                        .padding(.bottom)
                    
                    Text("Activities").font(.headline).padding([.horizontal])
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { ForEach(mockActivities) { item in
                            SelectableTag(
                                imageUrl: item.icon,
                                title: item.name,
                                color: Color(rgb: item.rgbColor),
                                selected: Binding(get: {
                                    activities.contains(item)
                                }, set: { value in
                                    if value {
                                        activities.append(item)
                                    } else {
                                        activities.remove(at: activities.firstIndex(of: item)!)
                                    }
                                })
                                
                            )
                        } }.padding([.bottom, .horizontal])
                    }
                    
                    Text("Best Seasons to Visit").font(.subheadline).padding([.horizontal])
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { ForEach(allSeasons, id: \.self) { item in
                            SelectableTag(
                                systemImage: item.icon,
                                title: item.name,
                                color: Color(rgb: item.rgbColor),
                                selected: Binding(get: {
                                    seasons.contains(item)
                                }, set: { value in
                                    if value {
                                        seasons.append(item)
                                    } else {
                                        seasons.remove(at: seasons.firstIndex(of: item)!)
                                    }
                                })
                                
                            )
                        }
                        }.padding([.horizontal, .bottom])
                    }
                    
                    Text("Description").font(.subheadline).padding([.horizontal])
                    TextField("What is this place about?", text: $description, axis: .vertical)
                        .lineLimit(3...10)
                        .textFieldStyle(.roundedBorder)
                        .padding([.bottom, .horizontal])
                }
            }
            .navigationTitle("New Activity")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: { Text("Done") })
                        .disabled(true)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }, label: { Text("Cancel") })
                }
            }
        }
    }
}

struct AddImageButton: View {
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Image(systemName: "photo.badge.plus")
                .imageScale(.large)
                .frame(width: previewImageSize, height: previewImageSize)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 16))
                .foregroundColor(.blue)
        }
    }
}

struct ImageUploader: View {
    @Binding var images: Set<String>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(images.sorted(), id: \.self) { imageUrl in
                    ZStack(alignment: .topTrailing) {
                        ImagePreview(imageUrl: imageUrl, size: previewImageSize)
                        Button(action: { images.remove(imageUrl) }) {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }.padding(8)
                    }
                }
                if (images.count < 3) { AddImageButton(onTap: {
                    images.insert(mockLocationActivity1.images.sorted()[images.count])
                }) }
            }.padding(.horizontal)
        }.frame(height: previewImageSize)
    }
}

#Preview { NewUserActivityScreen() }
