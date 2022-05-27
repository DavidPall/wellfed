//
//  FoodService.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import Foundation
import SwiftUI
import CoreLocation

final class FoodService: ObservableObject {
    @Published private var storedList: [Food] = []
    @Published var reservedFood: Food?
    
    init() {
        generateFood()
    }
    
    private func generateFood() {
        storedList = [
            Food(name: "Milk",
                 expirationDate: Date.now.addingTimeInterval(100000),
                 type: .Dairy,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.767688, longitude: 23.589570),
                 timePosted: Date.now.addingTimeInterval(-1000),
                 status: .Available,
                 image: UIImage(named: "placeholder") ?? UIImage())
        ]
    }
    
    var foodList: [Food] {
        return storedList
    }
}
