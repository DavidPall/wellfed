//
//  DonatedFoodListRowView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct DonatedFoodListRowView: View {
    
    var food: Food
    
    var body: some View {
        HStack {
            thumbnail
            mainInfoView
            Spacer()
            sideInfoView
        }
    }
    
    private var thumbnail: some View {
        return Image(uiImage: food.image)
            .resizable()
            .frame(width: 60, height: 60)
            .scaledToFit()
            .clipShape(Circle())
    }
    
    private var mainInfoView: some View {
        VStack(alignment: .leading) {
            Text(food.name).font(.title3)
            Spacer()
            HStack {
                Text("Expires at:")
                    .font(.caption)
                    .opacity(0.7)
                Text(food.expirationDate, style: .date)
                    .font(.caption)
            }
        }
    }
    
    private var sideInfoView: some View {
        VStack(alignment: .trailing) {
            food.type.icon
                .if(food.isVerified) { view in
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
            Spacer()
        }
    }
}
