//
//  ReservedFoodView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct ReservedFoodView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var foodPoint: FoodPoint
    var foodCancelled: (() -> Void)?
    
    var body: some View {
        ZStack {
            FoodDetailView(foodPoint: foodPoint)
            VStack {
                Spacer()
                cancelView
            }
        }
    }
    
    private var cancelView: some View {
        VStack {
            HStack {
                Text("Reserved until:")
                Spacer()
                HStack {
                    Text("Today, ")
                    Text(Date.now.reservedUntil, style: .time).bold()
                }
            }.padding()
            cancelButton.padding(.bottom)
            Button {
            } label: {
                Text("Ask for 15 more minutes.")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(radius: 3)
        }
    }
    
    private var cancelButton: some View {
        Button {
            foodCancelled?()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.projectPurple)
                }
        }
    }
}
