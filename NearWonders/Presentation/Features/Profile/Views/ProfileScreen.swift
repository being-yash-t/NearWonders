//
//  ProfileScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 30/12/23.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
                        Text(authViewModel.user?.name ?? "-")
                            .font(.headline)
                        Text(authViewModel.user?.email ?? "-")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
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
                        Task {
                            await authViewModel.signOut()
                            dismiss()
                        }
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
