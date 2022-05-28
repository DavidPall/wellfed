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
    @Published var reservedFoodPoint: FoodPoint?
    @Published var requestedFoodList: [RequestedFood] = []
    
    init() {
        generateFood()
    }
    
    var foodList: [Food] {
        return storedList
    }
    
    func getDonatorList(name: String) -> [Food] {
        return storedList.filter({ $0.owner.name == name })
    }
    
    var receivedFoodItems: [RequestedFood] = [
        RequestedFood(name: "Whole wheat Bread", type: .Bread),
        RequestedFood(name: "Milk 3,2%", type: .Dairy),
        RequestedFood(name: "Lasagne", type: .ReadyMeal)
    ]
}

// MARK: - View helpers
extension FoodService {
    func reserve(foodPoint: FoodPoint) {
        if let index = storedList.firstIndex(where: {$0.id == foodPoint.food.id}) {
            storedList[index].status = .Active
            reservedFoodPoint = foodPoint
        }
    }
    
    func cancel(foodPoint: FoodPoint) {
        if let index = storedList.firstIndex(where: {$0.id == foodPoint.food.id}) {
            storedList[index].status = .Available
            reservedFoodPoint = nil
        }
    }
    
    func cancelByDonator(food: Food) {
        if let index = storedList.firstIndex(where: {$0.id == food.id}) {
            storedList[index].status = .Available
            if let point = reservedFoodPoint {
                if point.food.id == food.id {
                    reservedFoodPoint = nil
                }
            }
        }
    }
    
    func delete(food: Food) {
        if let index = storedList.firstIndex(where: {$0.id == food.id}) {
            storedList.remove(at: index)
        }
    }
    
    func delivered(food: Food) {
        if let index = storedList.firstIndex(where: {$0.id == food.id}) {
            storedList[index].status = .Delivered
            if let point = reservedFoodPoint {
                if point.food.id == food.id {
                    reservedFoodPoint = nil
                }
            }
        }
    }
}

// MARK: - Data Source
extension FoodService {
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
                 image: UIImage(named: "milkImage") ?? UIImage(),
                 description: "Amúgy a témát már be kellett küldeni nem? Csak mert itt mindneki adja az ötleteket, az előadók, hogy mit csináljanakba csapatok és nem értem miért, ha már mindneki választott témát"),
            Food(name: "Eggs",
                 expirationDate: Date.now.addingTimeInterval(120000),
                 type: .Dairy,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.7826701876647, longitude: 23.620124396235546),
                 timePosted: Date.now.addingTimeInterval(-1200),
                 status: .Delivered,
                 image: UIImage(named: "eggsImage") ?? UIImage()),
            Food(name: "Chips",
                 expirationDate: Date.now.addingTimeInterval(90000),
                 type: .Snacks,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.77111589671378, longitude: 23.594475426399345),
                 timePosted: Date.now.addingTimeInterval(-1400),
                 status: .Available,
                 image: UIImage(named: "chipsImage") ?? UIImage()),
            Food(name: "Chocolate",
                 expirationDate: Date.now.addingTimeInterval(130000),
                 type: .Sweets,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.77746831852732, longitude: 23.57565199689992),
                 timePosted: Date.now.addingTimeInterval(-900),
                 status: .Available,
                 image: UIImage(named: "chocolateImage") ?? UIImage()),
            Food(name: "Strawberry",
                 expirationDate: Date.now.addingTimeInterval(50000),
                 type: .Fruit,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.77086676681078, longitude: 23.5925658032494),
                 timePosted: Date.now.addingTimeInterval(-300),
                 status: .Active,
                 image: UIImage(named: "strawberryImage") ?? UIImage()),
            Food(name: "Carrot",
                 expirationDate: Date.now.addingTimeInterval(60000),
                 type: .Vegetable,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.76843769042638, longitude: 23.60165924749185),
                 timePosted: Date.now.addingTimeInterval(-400),
                 status: .Available,
                 image: UIImage(named: "carrotImage") ?? UIImage()),
            Food(name: "Bread",
                 expirationDate: Date.now.addingTimeInterval(100000),
                 type: .Bread,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.780768790778005, longitude: 23.571196209314905),
                 timePosted: Date.now.addingTimeInterval(-600),
                 status: .Available,
                 image: UIImage(named: "breadImage") ?? UIImage()),
            Food(name: "Chicken Wings",
                 expirationDate: Date.now.addingTimeInterval(80000),
                 type: .Meat,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.79527601479926, longitude: 23.61020708499229),
                 timePosted: Date.now.addingTimeInterval(-700),
                 status: .Available,
                 image: UIImage(named: "meatImage") ?? UIImage()),
            Food(name: "Sushi",
                 expirationDate: Date.now.addingTimeInterval(130000),
                 type: .ReadyMeal,
                 owner: Donator(name: "John Doe",
                                rating: 3.8),
                 location: PointOfInterest(latitude: 46.77528865054036, longitude: 23.608206527258947),
                 timePosted: Date.now.addingTimeInterval(-100),
                 status: .Available,
                 image: UIImage(named: "readyMealImage") ?? UIImage())
        ]
    }
}
