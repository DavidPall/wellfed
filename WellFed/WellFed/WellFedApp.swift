//
//  WellFedApp.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

@main
struct WellFedApp: App {
    
    @StateObject private var foodService: FoodService = FoodService()
    @StateObject private var locationManager: LocationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(Color.projectBlue)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        languagePicker
                    }
                }
                .onAppear {
                    UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
                }
                .environmentObject(foodService)
                .environmentObject(locationManager)
        }
    }
    
    private var languagePicker: some View {
        HStack {
            Spacer()
            Text(FlagService.shared.countryFlag(countryCode: "US"))
                .font(.largeTitle)
                .contextMenu {
                    Text("Romanian \(FlagService.shared.countryFlag(countryCode: "RO"))")
                    Text("Magyar \(FlagService.shared.countryFlag(countryCode: "HU"))")
                    Text("Ukrainian \(FlagService.shared.countryFlag(countryCode: "UA"))")
                }
        }
        .padding()
    }
    
}
