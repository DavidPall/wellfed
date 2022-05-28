//
//  CreateDonationViewModel.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import Foundation
import UIKit
import CoreLocation
import UserNotifications

class CreateDonationViewModel: ObservableObject {
    
    enum CameraFor {
        case thumbnail
        case recipe
    }

    @Published var name: String = ""
    @Published var expirationDate: Date = .now
    @Published var type: FoodType = .Dairy
    @Published var thumbnail: UIImage?
    @Published var description: String = ""
    @Published var recipe: UIImage?
    @Published var location: CLLocationCoordinate2D?
    
    @Published var showCamera: Bool = false
    @Published var showMap: Bool = false
    var cameraType: CameraFor = .thumbnail
    
    func getFood() -> Food? {
        if let location = location {
            
            let content = UNMutableNotificationContent()
            content.title = "Are you looking for Milk?"
            content.subtitle = "Someone recently posted it nearby. Come and check it out!"

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
            return Food(name: name, expirationDate: expirationDate,
                       type: type,
                       owner: Donator(name: "John Doe", rating: 3.8),
                       location: PointOfInterest(latitude: location.latitude, longitude: location.longitude),
                       timePosted: .now,
                       status: .Available,
                       image: thumbnail ?? UIImage(named: "placeholder") ?? UIImage(),
                        description: description.isEmpty ? nil : description,
                       isVerified: recipe != nil)
        }
        return nil
    }
}
