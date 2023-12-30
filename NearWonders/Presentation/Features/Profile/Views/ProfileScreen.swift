//
//  ProfileScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 30/12/23.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                        .foregroundColor(.blue)
                        .padding(.vertical)
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading) {
                        Text("User Name").font(.headline)
                        Text("User since May 2019").font(.subheadline).foregroundStyle(.primary.opacity(0.6))
                    }
                }
                
                Section("My Data") {
                    NavigationLink("My Uploads", destination: { EmptyView() })
                }
                
                Section("Manage Account") {
                    Button("Delete Account") {
                        print("Delete Account")
                        dismiss()
                    }.foregroundColor(.red)
                    Button("Logout") {
                        print("Logout")
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview { ProfileScreen() }
