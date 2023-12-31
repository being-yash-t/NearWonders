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
    @State var userActivities: [Activity] = []
    @State var location: Location?
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Location").font(.headline).padding([.horizontal, .top])
                    NavigationLink(destination: NewLocationScreen(
                        name: location?.title ?? "",
                        description: location?.description ?? "",
                        location: location?.locationCoordinates.coordinates,
                        onComplete: { location = $0 }
                    )) {
                        Map(interactionModes: [.pitch, .zoom]) {
                            if location != nil {
                                if images.isEmpty {
                                    Marker(location!.title, coordinate: location!.locationCoordinates.coordinates)
                                } else {
                                    Annotation(location!.title, coordinate: location!.locationCoordinates.coordinates) {
                                        MapImagePreview(images.first!)
                                    }
                                }
                            }
                        }
                        .mapStyle(.imagery)
                        .frame(height: 150)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding([.bottom, .horizontal])
                    }
                    
                    Text("Pictures").font(.headline).padding([.horizontal])
                    ImageUploader(images: $images)
                        .padding(.bottom)
                    
                    Text("What activities did you perform?").font(.headline).padding([.horizontal])
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { ForEach(mockActivities) { item in
                            SelectableTag(
                                imageUrl: item.icon,
                                title: item.name,
                                color: Color(rgb: item.rgbColor),
                                selected: Binding(get: {
                                    userActivities.contains(item)
                                }, set: { value in
                                    if value {
                                        userActivities.append(item)
                                    } else {
                                        userActivities.remove(at: userActivities.firstIndex(of: item)!)
                                    }
                                })
                            )
                        } }.padding([.bottom, .horizontal])
                    }
                    
                    Text("What are your thoughts?").font(.subheadline).padding([.horizontal])
                    TextField("What was that you enjoyed the most?" +
                              "\nAnything that you didn't expect?",
                              text: $description,
                              axis: .vertical
                    )
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
                    images.insert(mockLocationSummary1.images.sorted()[images.count])
                }) }
            }.padding(.horizontal)
        }.frame(height: previewImageSize)
    }
}

#Preview { NewUserActivityScreen() }
