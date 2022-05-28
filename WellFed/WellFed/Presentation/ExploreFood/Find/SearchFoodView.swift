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
    @Binding var homeState: HomeViewState
    
    @StateObject var viewModel: SearchFoodViewModel = SearchFoodViewModel()
    
    @State var foodList: [FoodPoint]
    
    var body: some View {
        NavigationView {
            VStack {
                if let point = foodService.reservedFoodPoint {
                    ReservedFoodView(foodPoint: point) {
                        foodService.cancel(foodPoint: point)
                    }
                } else {
                    viewPicker.padding([.horizontal, .top])
                    content
                }
            }
            .sheet(isPresented: $viewModel.showDetailedView) {
                if let point = viewModel.selectedPoint {
                    SelectedPointView(foodPoint: point) {
                        foodService.reserve(foodPoint: point)
                    }
                } else {
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        homeState = .Home
                    } label: {
                        Image(systemName: "house.fill")
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.viewOption == .Map {
            Map(coordinateRegion: $locationManager.coordinateRegion, showsUserLocation: true, annotationItems: foodList) { foodPoint in
                    MapAnnotation(coordinate: foodPoint.food.location.coordinate) {
                        Button {
                            viewModel.selectedPoint = foodPoint
                        } label: {
                            foodPoint.food.type.icon
                                .frame(width: 42, height: 42)
                                .shadow(radius: 3)
                        }
                    }
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
