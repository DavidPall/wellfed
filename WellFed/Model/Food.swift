//
//  Food.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import Foundation
import MapKit

enum FoodType: String {
    case Fruit
    case Vegetable
    case Dairy
    case Bread
    case Meat
    case ReadyMeal
    case Sweets
    case Snacks
}

enum FoodStatus {
    case Available
    case Delivered
    case Active
}

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let expirationDate: Date
    let type: FoodType
    let owner: Donator
    var location: PointOfInterest
    var timePosted: Date
    var status: FoodStatus
    var image: UIImage
}

struct Donator: Identifiable {
    let id = UUID()
    let name: String
    var rating: Double
}

struct FoodPoint: Identifiable {
    let id = UUID()
    let food: Food
    var distance: Double?
}

struct PointOfInterest: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

