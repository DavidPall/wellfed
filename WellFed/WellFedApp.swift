//
//  WellFedApp.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

@main
struct WellFedApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            languagePicker
                        }
                    }
            }
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
