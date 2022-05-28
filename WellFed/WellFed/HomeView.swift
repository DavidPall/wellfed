//
//  HomeView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

enum HomeViewState {
    case Home
    case Donate
    case Explore
}

struct HomeView: View {
    
    @State private var homeState: HomeViewState = .Home
    @StateObject private var donationViewModel: DonationViewModel = DonationViewModel()
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        switch homeState {
        case .Home:
            homeView
        case .Donate:
            DonationView(homeState: $homeState)
                .environmentObject(donationViewModel)
        case .Explore:
            ExploreView(homeState: $homeState)
        }
    }
    private var homeView: some View {
        VStack {
            Spacer()
            Image(uiImage: UIImage(named: "brandIcon") ?? UIImage())
                .resizable()
                .scaledToFit()
                .padding()
                .padding()
            Spacer()
            Group {
                Button {
                    homeState = .Donate
                } label: {
                    HStack {
                        Text("Donate")
                            .foregroundStyle(
                                LinearGradient(colors: [Color(hex: 0x4365d1), Color(hex: 0xd08775)], startPoint: .leading, endPoint: .trailing)
                            )
                        Spacer()
                        Image(systemName: "suit.heart")
                            .font(.title)
                            .foregroundColor(Color(hex: 0x4365d1))
                    }.padding()
                        .background {
                            RoundedRectangle(cornerRadius: 18)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                        }
                }.padding()
                Button {
                    homeState = .Explore
                } label: {
                    HStack {
                        Text("Explore")
                            .foregroundStyle(
                                LinearGradient(colors: [Color(hex: 0x4365d1), Color(hex: 0xd08775)], startPoint: .leading, endPoint: .trailing)
                            )
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(Color(hex: 0x4365d1))
                    }.padding()
                        .background {
                            RoundedRectangle(cornerRadius: 18)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                        }
                        .padding()
                }
            }.padding(.horizontal)
            Spacer()
        }
    }
}

