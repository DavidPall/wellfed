//
//  LocationPicker.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var didPick: ((CLLocationCoordinate2D) -> Void)?
    
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)), animated: false)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        //print(#function)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, didSelectCoordinate: { coordinate in
            didPick?(coordinate)
        })
    }
}

class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
    var parent: MapView
    var didSelectLocation: ((CLLocationCoordinate2D) -> Void)?
    
    var gRecognizer = UITapGestureRecognizer()
    
    init(_ parent: MapView, didSelectCoordinate: ((CLLocationCoordinate2D) -> Void)?) {
        self.parent = parent
        self.didSelectLocation = didSelectCoordinate
        super.init()
        self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.gRecognizer.delegate = self
        self.parent.mapView.addGestureRecognizer(gRecognizer)
    }
    
    @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
        // position on the screen, CGPoint
        let location = gRecognizer.location(in: self.parent.mapView)
        // position on the map, CLLocationCoordinate2D
        let coordinate = self.parent.mapView.convert(location, toCoordinateFrom: self.parent.mapView)
        didSelectLocation?(coordinate)
        print(coordinate)
    }
}

