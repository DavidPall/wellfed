//
//  CreateDonationView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI
import MapKit

struct CreateDonationView: View {
    
    @StateObject var viewModel: CreateDonationViewModel = CreateDonationViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var foodService: FoodService
    
    var body: some View {
        VStack {
            Form {
                thumbnail
                general
                description
                moreInfo
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        if let food = viewModel.getFood() {
                            foodService.add(food: food)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                })
            }
            .sheet(isPresented: $viewModel.showCamera, content: {
                CameraView(imageCreated: { image in
                    if viewModel.cameraType == .thumbnail {
                        viewModel.thumbnail = image
                    }
                    if viewModel.cameraType == .recipe {
                        viewModel.recipe = image
                    }
                    viewModel.showCamera = false
                }).edgesIgnoringSafeArea(.bottom)
            })
            .sheet(isPresented: $viewModel.showMap, content: {
                MapView(centerCoordinate: .constant(CLLocationCoordinate2D(latitude: 46.776677869219164, longitude: 23.603976326956342))) { coordinate in
                    viewModel.location = coordinate
                    viewModel.showMap = false
                }
            })
        }
    }
}

extension CreateDonationView {
    private var thumbnail: some View {
        Section {
            HStack {
                Spacer()
                Button {
                    viewModel.cameraType = .thumbnail
                    viewModel.showCamera.toggle()
                } label: {
                    Image(uiImage: viewModel.thumbnail ?? UIImage(named: "placeholder") ?? UIImage())
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFill()
                        .clipShape(Circle())
                }
                Spacer()
            }
        }.listRowBackground(Color.clear)
    }
    
    private var general: some View {
        Section("General") {
            TextField("Food name", text: $viewModel.name)
            Picker("Category", selection: $viewModel.type) {
                ForEach(FoodType.allCases, id: \.self) { type in
                    HStack {
                        type.icon
                            .frame(width: 38, height: 38)
                        Text(type.rawValue)
                    }
                }
            }
            DatePicker("Expires at", selection: $viewModel.expirationDate, displayedComponents: .date)
        }
    }
    
    private var description: some View {
        Section("Description") {
            TextEditor(text: $viewModel.description)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                    }
                }
        }
    }
    
    private var moreInfo: some View {
        Section("More information") {
            HStack {
                Text("Receipt")
                Spacer()
                if viewModel.recipe != nil {
                    HStack {
                        Text("Verified")
                        Image(systemName: "checkmark.circle")
                    }
                    .foregroundColor(.green)
                } else {
                    Button {
                        viewModel.cameraType = .recipe
                        viewModel.showCamera = true
                    } label: {
                        Text("Add receipt")
                    }
                }
            }
            HStack {
                Text("Location")
                Spacer()
                Button {
                    viewModel.showMap = true
                } label: {
                    if viewModel.location != nil {
                        HStack {
                            Text("Selected")
                            Image(systemName: "checkmark.circle")
                        }.foregroundColor(.green)
                    } else {
                        Text("Select location")
                    }
                }
            }
        }
    }
}

struct CreateDonationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDonationView()
    }
}
