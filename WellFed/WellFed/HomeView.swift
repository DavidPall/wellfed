//
//  HomeView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: DonationView()) {
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
            NavigationLink(destination: ExploreView()) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .padding()
                    .overlay {
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text("Explore")
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
            }
        }
        .navigationTitle("Select your activity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
