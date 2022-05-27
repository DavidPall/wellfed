//
//  SelectedPointView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct SelectedPointView: View {
    
    @State var foodPoint: FoodPoint
    var foodReserved: (() -> Void)?
    
    var body: some View {
        ZStack {
            FoodDetailView(foodPoint: foodPoint)
            VStack {
                Spacer()
                reserveView
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

extension SelectedPointView {
    
    private var reserveView: some View {
        VStack {
            HStack {
                Text("Expires at")
                Spacer()
                Text(foodPoint.food.expirationDate, style: .date).bold()
            }.padding()
            reserveButton.padding(.bottom)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(radius: 3)
        }
    }
    
    private var reserveButton: some View {
        Button {
            
        } label: {
            Text("Reserve")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.orange)
                }
        }
    }
}
