//
//  SearchFoodListRowView.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import SwiftUI

struct SearchFoodListRowView: View {
    
    @State var foodPoint: FoodPoint
    
    var body: some View {
        HStack {
            thumbnail
            VStack(alignment: .leading, spacing: 8) {
                generalInfo
                secondaryInfo
            }.padding(.vertical, 5)
        }
    }
    
    private var thumbnail: some View {
        return Image(uiImage: foodPoint.food.image)
            .resizable()
            .frame(width: 60, height: 60)
            .scaledToFit()
            .clipShape(Circle())
    }
    
    private var generalInfo: some View {
        HStack {
            Text(foodPoint.food.name).font(.title3)
            Spacer()
            if let distance = foodPoint.distance {
                Text("\(String(format: "%.0f", distance)) m")
                    .font(.body)
                    .opacity(0.7)
            }
        }
    }
    
    private var secondaryInfo: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Donator's rating: \(String(format: "%.1f", foodPoint.food.owner.rating))")
                        .font(.caption)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
                HStack {
                    Text("Expiration date: ")
                    Text(foodPoint.food.expirationDate, style: .date)
                }.font(.caption)
            }
            Spacer()
            foodPoint.food.type.icon
                .if(foodPoint.food.isVerified) { view in
                    view
                    .padding(3)
                    .background {
                        Circle().foregroundColor(.white)
                            .padding(2)
                            .background {
                                Circle().foregroundColor(.green)
                            }
                    }
                }
                .frame(width: 38, height: 38)
        }
    }
}
