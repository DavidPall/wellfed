//
//  Food.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import Foundation
import MapKit
import SwiftUI

enum FoodType: String, CaseIterable {
    case Dairy = "Dairy & Eggs"
    case Fruit
    case Vegetable
    case Bread
    case Meat
    case ReadyMeal
    case Sweets
    case Snacks
    
    var icon: some View {
        var imageName: String = ""
        var color: Color = .yellow
        
        switch self {
        case .Fruit:
            imageName = "fruitIcon"
            color = .green
        case .Vegetable:
            imageName = "vegetableIcon"
            color = .green
        case .Dairy:
            imageName = "diaryIcon"
            color = .yellow
        case .Bread:
            imageName = "breadIcon"
            color = .brown
        case .Meat:
            imageName = "meatIcon"
            color = .red
        case .ReadyMeal:
            imageName = "readyMealIcon"
            color = .red
        case .Sweets:
            imageName = "sweetsIcon"
            color = .pink
        case .Snacks:
            imageName = "snacksIcon"
            color = .pink
        }
        
        return Image(uiImage: UIImage(named: imageName) ?? UIImage())
            .resizable()
            .foregroundColor(.white)
            .padding(8)
            .background {
                Circle().foregroundColor(color)
            }
    }
}

enum FoodStatus {
    case Available
    case Delivered
    case Active
}

struct RequestedFood: Identifiable {
    let id = UUID()
    let name: String
    let type: FoodType
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
    var description: String?
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

