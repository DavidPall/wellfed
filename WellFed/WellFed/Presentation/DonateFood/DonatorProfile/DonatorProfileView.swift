//
//  DonatorProfileView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct DonatorProfileView: View {
    
    @Binding var homeState: HomeViewState
    
    var body: some View {
        NavigationView {
            Text("Profile")
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            homeState = .Home
                        } label: {
                            Image(systemName: "house.fill")
                        }
                    }
                }
        }
    }
}
