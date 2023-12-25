//
//  NewLocation.swift
//  NearWonders
//
//  Created by Jay Thakur on 20/12/23.
//

import SwiftUI
import MapKit

struct NewLocationScreen: View {
    @State var location: Location?
    @State var bottomVisible = false
    
    @State var activities: [Activity] = []
    @State var seasons: [Season] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(interactionModes: .all) {
                if location != nil {
                    Marker(location!.title ?? "You Spot :)", coordinate: location!.coordinates)
                }
            }
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Next") {
                        if bottomVisible {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            withAnimation {
                                    bottomVisible.toggle()
                            }
                        }
                    }
                    .disabled(bottomVisible ? false : location == nil)
                }
            }
            
            if bottomVisible {
                BottomView(activities: $activities, seasons: $seasons)
            }
        }
    }
}

private struct BottomView: View {
    @Binding var activities: [Activity]
    @Binding var seasons: [Season]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Activities").font(.headline).padding([.horizontal, .top])
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
            
            Text("Best Seasons to Visit").font(.headline).padding([.horizontal])
            ScrollView(.horizontal, showsIndicators: false) {
                HStack { 
                    ForEach(Season.allCases) { item in
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
        }.background(.ultraThickMaterial)
    }
}

#Preview {
    NavigationView {
        NewLocationScreen(location: nil)
    }
}
