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
        case .Explore:
            ExploreView(homeState: $homeState)
        }
    }
    
    private var homeView: some View {
        VStack {
            Button {
                homeState = .Donate
            } label: {
                ZStack {
                    Image(uiImage: UIImage(named: "DonateImage") ?? UIImage())
                        .resizable()
                        .overlay(Color.black.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(height: 200)
                        .foregroundColor(.gray)
                        .padding()
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .shadow(radius: 2)
                        Text("Donate")
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                            .padding()
                    }
                }

            }
            Button {
                homeState = .Explore
            } label: {
                ZStack {
                    Image(uiImage: UIImage(named: "ExploreImage") ?? UIImage())
                        .resizable()
                        .overlay(Color.black.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(height: 200)
                        .foregroundColor(.gray)
                        .padding()
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .shadow(radius: 2)
                        Text("Explore")
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                            .padding()
                    }
                }
            }
        }
        
    }
}

