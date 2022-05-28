//
//  DonationView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

struct DonationView: View {
    
    @Binding var homeState: HomeViewState
    @EnvironmentObject var donationViewModel: DonationViewModel
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        if donationViewModel.loggedIn {
            TabView {
                DonationsView(homeState: $homeState)
                    .tabItem {
                        Label("Donate", systemImage: "suit.heart.fill")
                    }
                DonatorProfileView(homeState: $homeState)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        } else {
            LoginView(loggedIn: $donationViewModel.loggedIn)
        }
    }
}
