//
//  ExploreView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var foodService: FoodService
    
    @Binding var homeState: HomeViewState
    
    var body: some View {
        TabView {
            SearchFoodView(homeState: $homeState, foodList: foodPointList)
                .tabItem {
                    Label("Find", systemImage: "magnifyingglass")
                }
            RequestFoodView(homeState: $homeState)
                .tabItem {
                    Label("Request", systemImage: "person.fill.questionmark")
                }
        }
    }
}

extension ExploreView {
    var foodPointList: [FoodPoint] {
        var filteredPointList: [FoodPoint] = []
        for food in foodService.foodList.filter({$0.status != .Delivered}) {
            filteredPointList.append(FoodPoint(food: food, distance: locationManager.getDistanceFrom(point: food.location)))
        }
        return filteredPointList.sorted(by: {
            guard let point1 = $0.distance, let point2 = $1.distance else { return false }
            return point1 < point2
        })
    }
}
