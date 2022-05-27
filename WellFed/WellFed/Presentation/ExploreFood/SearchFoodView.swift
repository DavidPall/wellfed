//
//  SearchFoodView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI
import MapKit

struct SearchFoodView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var foodService: FoodService
    
    @StateObject var viewModel: SearchFoodViewModel = SearchFoodViewModel()
    
    @State var foodList: [FoodPoint]
    
    var body: some View {
        VStack {
            viewPicker.padding([.horizontal, .top])
            content
        }
        .sheet(isPresented: $viewModel.showDetailedView) {
            if let point = viewModel.selectedPoint {
                Text(point.food.name)
            } else {
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.viewOption == .Map {
            Map(coordinateRegion: $locationManager.coordinateRegion, showsUserLocation: true, annotationItems: foodList) { foodPoint in
                //            MapAnnotation(coordinate: foodPoint.food.location.coordinate) {
                //                Text("asd")
                //            }
                MapMarker(coordinate: foodPoint.food.location.coordinate)
            }
        } else {
            List {
                ForEach(foodList) { foodPoint in
                    Button {
                        viewModel.selectedPoint = foodPoint
                    } label: {
                        SearchFoodListRowView(foodPoint: foodPoint)
                    }.buttonStyle(.plain)
                }
            }
        }
    }
    
    private var viewPicker: some View {
        Picker("", selection: $viewModel.viewOption) {
            ForEach(FoodLocatorViewOption.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}
