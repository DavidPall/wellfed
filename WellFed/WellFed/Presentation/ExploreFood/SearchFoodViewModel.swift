//
//  ExploreViewModel.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import Foundation

enum FoodLocatorViewOption: String, CaseIterable {
    case Map
    case List
}

final class SearchFoodViewModel: ObservableObject {
    
    @Published var showDetailedView: Bool = false
    @Published var viewOption: FoodLocatorViewOption = .Map
    
    var selectedPoint: FoodPoint? = nil {
        didSet {
            if let _ = selectedPoint {
                showDetailedView = true
            }
        }
    }
    
}
