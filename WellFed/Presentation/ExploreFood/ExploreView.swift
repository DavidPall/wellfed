//
//  ExploreView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        TabView {
            SearchFoodView()
                .tabItem {
                    Label("Find", systemImage: "magnifyingglass")
                }
            RequestFoodView()
                .tabItem {
                    Label("Request", systemImage: "person.fill.questionmark")
                }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
