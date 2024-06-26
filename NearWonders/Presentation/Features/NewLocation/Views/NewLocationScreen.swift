//
//  NewLocation.swift
//  NearWonders
//
//  Created by Jay Thakur on 20/12/23.
//

import SwiftUI
import MapKit

struct NewLocationScreen: View {
    @State var name: String = ""
    @State var description: String = ""
    @State var location: CLLocationCoordinate2D?
    
    @State private var bottomVisible = false
    @State private var activities: [Activity] = []
    @State private var seasons: [Season] = []
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @Environment(\.dismiss) var dismiss
    
    var onComplete: (_: LocationDetails) -> Void
    
    var seasonsAsStrings: [String] { seasons.map { $0.rawValue } }
    var activitesAsStrings: [String] { activities.map { $0.rawValue } }
    
    var validateFrom: Bool {
        !name.isEmpty && !activities.isEmpty && !seasons.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapReader { reader in
                Map(position: $cameraPosition, interactionModes: .all) {
                    if location != nil {
                        Marker(name.isEmpty ? "You Spot :)" : name, coordinate: location!)
                    }
                }
                .onTapGesture { screenCoord in
                    if let pinLocation = reader.convert(screenCoord, from: .local) {
                        withAnimation {
                            location = pinLocation
                            cameraPosition = .region(.init(center: pinLocation, latitudinalMeters: 1000, longitudinalMeters: 1000))
                            bottomVisible = true
                        }
                    } else {
                        debugPrint("Unknown error while converting point")
                    }
                }
            }
            .mapStyle(.hybrid)
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(bottomVisible ? "Done" : "Next") {
                        if bottomVisible {
                            Task { await createLocation() }
                        } else {
                            withAnimation {
                                bottomVisible.toggle()
                            }
                        }
                    }
                    .disabled(bottomVisible ? !validateFrom : location == nil)
                }
            }
            .overlay(
                VStack {
                    Spacer()
                    BottomView(
                        activities: $activities,
                        seasons: $seasons,
                        showSheet: $bottomVisible,
                        name: $name,
                        description: $description
                    )
                    .offset(y: bottomVisible ? 0 : 500)
                    .animation(.easeInOut(duration: 0.3), value: bottomVisible)
                }
            )
            
        }
    }
    
    func createLocation() async {
//        let newLocation = LocationDetails(
//            name: name,
//            seasons: seasonsAsStrings,
//            available_activity_types: activitesAsStrings,
//            lat_long: [Double(location!.latitude), Double(location!.longitude)]
//        )
//        do {
//            let result = try await Amplify.API.mutate(request: .create(newLocation))
//            switch result {
//            case .success(let location):
//                onComplete(location)
//                dismiss()
//            case .failure(let graphQLError):
//                print("Failed to create, graphql \(graphQLError)")
//            }
//        } catch let error as APIError {
//            print("Failed to create: ", error)
//        } catch {
//            print("Unexpected error: \(error)")
//        }
    }
}

private struct BottomView: View {
    @Binding var activities: [Activity]
    @Binding var seasons: [Season]
    @Binding var showSheet: Bool
    @Binding var name: String
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Activities available").font(.headline)
                Spacer()
                Button {
                        showSheet.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }.padding([.horizontal, .top])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack { ForEach(Activity.allCases) { item in
                    SelectableTag(
                        imageUrl: item.iconData.rawValue,
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
                            systemImage: item.icon.rawValue,
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
            
            Text("Name").font(.subheadline).padding([.horizontal])
            TextField("Name of the Spot", text: $name, axis: .vertical)
                .lineLimit(1...2)
                .textFieldStyle(.roundedBorder)
                .padding([.bottom, .horizontal])
            
            Text("Description").font(.subheadline).padding([.horizontal])
            TextField("What is this place about?" +
                      "\nWhat's nearby?", text: $description, axis: .vertical)
                .lineLimit(2...10)
                .textFieldStyle(.roundedBorder)
                .padding([.bottom, .horizontal])
        }
//        .safeAreaPadding(.bottom)
        .background(.ultraThickMaterial)
    }
}

#Preview {
    NavigationView {
        NewLocationScreen(location: nil,onComplete: { _ in })
    }
}
