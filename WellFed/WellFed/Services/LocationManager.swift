//
//  LocationManager.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    
    @Published var coordinateRegion: MKCoordinateRegion =
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: Constants.defaultCoordinates.latitude,
                longitude: Constants.defaultCoordinates.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: Constants.defaultZoomSpan,
                longitudeDelta: Constants.defaultZoomSpan))
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func getDistanceFrom(point: PointOfInterest) -> Double? {
        guard let userLocation = currentLocation else { return nil }
        let userL = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let pointL = CLLocation(latitude: point.latitude, longitude: point.longitude)
        
        return userL.distance(from: pointL)
    }
}

// MARK: - Location delegates
extension LocationManager {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.first?.coordinate
        
        coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: locations.first?.coordinate.latitude ?? Constants.defaultCoordinates.latitude,
                longitude: locations.first?.coordinate.longitude ?? Constants.defaultCoordinates.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: Constants.defaultZoomSpan,
                longitudeDelta: Constants.defaultZoomSpan))
        manager.stopUpdatingLocation()
    }
}

// MARK: - Constants
extension LocationManager {
    struct Constants {
        static let defaultCoordinates = CLLocationCoordinate2D(latitude: 40.759211, longitude: -73.984638)
        static let defaultZoomSpan: CLLocationDegrees = 0.003
    }
}
