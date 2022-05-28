//
//  WellFedApp.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI
import UserNotifications

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
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
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
