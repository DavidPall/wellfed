//
//  FoodDetailView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct FoodDetailView: View {
    
    @EnvironmentObject var foodService: FoodService

    @State var foodPoint: FoodPoint
    
    var body: some View {
        Form {
            thumbnail
            generalInfo
            donator
            Section(""){}
            Section(""){}
        }
    }
    
    private var thumbnail: some View {
        Section {
            Image(uiImage: foodPoint.food.image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        }.listRowBackground(Color.clear)
    }
    
    private var generalInfo: some View {
        Section("General") {
            SectionRow(title: "Name", content: {Text(foodPoint.food.name)})
            SectionRow(title: "Verified", content: {
                Image(systemName: foodPoint.food.isVerified ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(foodPoint.food.isVerified ? .green : .red)
                    .font(.title)
            })
            SectionRow(title: "Category", content: {
                HStack {
                    Text(foodPoint.food.type.rawValue)
                    foodPoint.food.type.icon.frame(width: 32, height: 32)
                }
            })
            if let distance = foodPoint.distance {
                SectionRow(title: "Distance", content: {Text(String(format: "%.0f m", distance))})
            }
            description
        }
    }
    
    @ViewBuilder
    private var description: some View {
        if let description = foodPoint.food.description {
            VStack(alignment: .leading) {
                Text("Description").foregroundColor(.gray)
                Text(description)
                    .padding(.vertical)
            }
        }
    }
    
    private var donator: some View {
        Section("Donator") {
            SectionRow(title: "Rating", content: {
                HStack {
                    Text(String(format: "%.1f", foodPoint.food.owner.rating))
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }
            })
            donatorItems
        }
    }
    
    private var donatorItems: some View {
        VStack(alignment: .leading) {
            Text("Other items from this donator").foregroundColor(.gray)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(foodService.getDonatorList(name: foodPoint.food.owner.name)) { food in
                        OtherFoodItem(food: food)
                    }
                }
            }
        }
    }
    
    struct OtherFoodItem: View {
        var food: Food
        
        var body: some View {
            VStack {
                Image(uiImage: food.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Text("Expires at:").foregroundColor(.gray)
                Text(food.expirationDate, style: .date)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray).opacity(0.2)
            }
        }
    }
}

struct SectionRow<Content: View>: View {
    var title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            Text(title).foregroundColor(.gray)
            Spacer()
            content
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(foodPoint: FoodPoint(food: Food(name: "Milk",
                                                       expirationDate: Date.now.addingTimeInterval(100000),
                                                       type: .Dairy,
                                                       owner: Donator(name: "John Doe",
                                                                      rating: 3.8),
                                                       location: PointOfInterest(latitude: 46.767688, longitude: 23.589570),
                                                       timePosted: Date.now.addingTimeInterval(-1000),
                                                       status: .Available,
                                                       image: UIImage(named: "milkImage") ?? UIImage(),
                                                      description: "Amúgy a témát már be kellett küldeni nem? Csak mert itt mindneki adja az ötleteket, az előadók, hogy mit csináljanakba csapatok és nem értem miért, ha már mindneki választott témát"), distance: 12.3))
    }
}
