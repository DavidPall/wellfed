//
//  DonationsView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct DonationsView: View {
    @EnvironmentObject var foodService: FoodService
    @Binding var homeState: HomeViewState
    
    var body: some View {
        NavigationView {
            VStack {
                content
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Image(systemName: "plus.circle").font(.title3)
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                homeState = .Home
                            } label: {
                                Image(systemName: "house.fill")
                            }
                        }
                        
                    }
            }
            .navigationTitle("Donate")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var content: some View {
        List {
            activeSection
            availableSection
            deliveredSection
        }
    }
}

// MARK: - List sections
extension DonationsView {
    
    @ViewBuilder
    private var activeSection: some View {
        let items = foodService.getDonatorList(name: "John Doe").filter({$0.status == .Active})
        if items.isEmpty == false {
            Section(content: {
                ForEach(items) { food in
                    DonatedFoodListRowView(food: food)
                        .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                            Button {
                                print("delivered")
                                foodService.delivered(food: food)
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.largeTitle)
                                
                            }.tint(.green)
                        })
                        .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                            Button {
                                print("Declined")
                                foodService.cancelByDonator(food: food)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                            }.tint(.red)
                        })
                }
            }, header: {
                Text("Reserved")
            }, footer: {
                HStack {
                    Image(systemName: "arrow.right")
                    Text("Delivered")
                    Spacer()
                    Text("Cancel")
                    Image(systemName: "arrow.left")
                }
                .padding(.horizontal)
                .opacity(0.3)
            })
        }
    }
    
    @ViewBuilder
    private var availableSection: some View {
        let items = foodService.getDonatorList(name: "John Doe").filter({$0.status == .Available})
        if items.isEmpty == false {
            Section(content: {
                ForEach(items) { food in
                    DonatedFoodListRowView(food: food)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                foodService.delete(food: food)
                            } label: {
                                Image(systemName: "trash.circle.fill")
                                    .font(.largeTitle)
                            }.tint(.red)
                        }
                }
            }, header: {
                Text("Available")
            })
        }
    }
    
    @ViewBuilder
    private var deliveredSection: some View {
        let items = foodService.getDonatorList(name: "John Doe").filter({$0.status == .Delivered})
        if items.isEmpty == false {
            Section(content: {
                ForEach(items) { food in
                    DonatedFoodListRowView(food: food)
                }
            }, header: {
                Text("Delivered")
            }).opacity(0.5)
        }
    }
}
