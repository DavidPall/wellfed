//
//  RequestFoodView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

struct RequestFoodView: View {
    
    @EnvironmentObject var foodService: FoodService
    @Binding var homeState: HomeViewState
    
    @State private var name: String = ""
    @State private var foodType: FoodType = .ReadyMeal
    
    var body: some View {
        NavigationView {
            Form {
                addSection
                addButton.listRowBackground(Color.clear)
                viewSection
                history
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
            .navigationTitle("Request")
        }
    }
    
    private var addSection: some View {
        Section("Request item") {
            TextField("Food name", text: $name)
            Picker("Category", selection: $foodType) {
                ForEach(FoodType.allCases, id: \.self) { type in
                    HStack {
                        type.icon
                            .frame(width: 38, height: 38)
                        Text(type.rawValue)
                    }
                }
            }
        }
    }
    
    private var addButton: some View {
        Button {
            withAnimation {
                foodService.requestedFoodList.append(RequestedFood(name: name, type: foodType))
                if name == "Coconut Milk" {
                    foodService.triggreNotification()
                }
                name = ""
            }
        } label: {
            HStack {
                Spacer()
                Label("Request Item", systemImage: "plus.circle")
                    .foregroundColor(name.isEmpty ? .gray : .white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(name.isEmpty ? .projectPurple.opacity(0.5) : .projectPurple)
                    }
                Spacer()
            }
        }.disabled(name.isEmpty ? true : false)
    }
    
    private var viewSection: some View {
        Section("Requested items") {
            List {
                ForEach(foodService.requestedFoodList) { food in
                    HStack {
                        Text(food.name)
                        Spacer()
                        food.type.icon
                            .frame(width: 38, height: 38)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                        Button {
                            foodService.requestedFoodList.removeAll(where: {$0.id == food.id})
                        } label: {
                            Image(systemName: "trash.circle.fill")
                                .font(.largeTitle)
                        }.tint(.red)
                    })
                }
            }
        }
    }
    
    private var history: some View {
        Section("Previously received items") {
            List {
                ForEach(foodService.receivedFoodItems) { food in
                    HStack {
                        Text(food.name)
                            .opacity(0.5)
                        Spacer()
                        food.type.icon
                            .frame(width: 38, height: 38)
                            .opacity(0.8)
                    }
                }
            }
        }
    }
}
