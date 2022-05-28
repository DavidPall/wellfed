//
//  DonatorProfileView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import SwiftUI

struct DonatorProfileView: View {
    
    @Binding var homeState: HomeViewState
    
    var body: some View {
        NavigationView {
            ScrollView {
                content
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            Button {
                                
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        })
                    }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        homeState = .Home
                    } label: {
                        Image(systemName: "house.fill")
                    }
                }
            }
        }
    }
    
    private var content: some View {
        VStack {
            VStack {
                Image(uiImage: UIImage(named: "profilePicture") ?? UIImage())
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("John Doe").font(.largeTitle).bold()
            }.padding()
            statistics
            tips
            Spacer()
            buttons
        }
    }
                    
    private var tips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Buy only what you need").bold()
                                .padding()
                            Spacer()
                        }
                        Text("Plan your meals. Make a shopping list and stick to it, and avoid impulse buys. Not only will you waste less food, you’ll also save money!")
                            .padding([.horizontal, .bottom])
                        Spacer()
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color(UIColor.systemGray5))
                            .shadow(radius: 5)
                            .padding()
                    }
                    VStack {
                        HStack {
                            Spacer()
                            LottieView(name: "lightBulb.json", loopMode: .loop)
                                .frame(width: 70, height: 70)
                                .offset(x: 10, y: -10)
                        }
                        Spacer()
                    }
                }
                ZStack {
                    VStack {
                        HStack {
                            Text("Sharing is caring").bold()
                                .padding()
                            Spacer()
                        }
                        Text("Donate food that would otherwise be wasted. For example, Apps can connect neighbours with each other and with local businesses so surplus food can be shared, not thrown away.")
                            .padding([.horizontal, .bottom])
                        Spacer()
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color(UIColor.systemGray5))
                            .shadow(radius: 5)
                            .padding()
                    }
                    VStack {
                        HStack {
                            Spacer()
                            LottieView(name: "lightBulb.json", loopMode: .loop)
                                .frame(width: 70, height: 70)
                                .offset(x: 10, y: -10)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

private var buttons: some View {
    VStack {
        NavigationLink("Terms and Conditions", destination: {})
        Text("Log out")
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundColor(.gray.opacity(0.3))
            }
    }.padding()
}

private var statistics: some View {
    HStack {
        VStack(alignment: .leading) {
            Text("Total donations\n")
                .font(.caption)
                .foregroundColor(.gray)
            Text("53").font(.largeTitle)
        }
        Divider()
            .frame(height: 80)
            .padding()
        VStack(alignment: .leading) {
            Text("Donations this month")
                .font(.caption)
                .foregroundColor(.gray)
            Text("12").font(.largeTitle)
        }
        Divider()
            .frame(height: 80)
            .padding()
        VStack(alignment: .leading) {
            Text("Rating \n")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                Text("4.6").font(.largeTitle)
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
        }
    }.padding()
}


struct DonatorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DonatorProfileView(homeState: .constant(.Donate))
    }
}
