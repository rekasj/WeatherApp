//
//  MainView.swift
//  WeatherApp
//
//  Created by Jakub Rękas on 04/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var city = ""
    
    var body: some View {
        ZStack {
            Image(Constants.Image.backgroundImage)
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 10) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: Constants.Image.locationCircle)
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundStyle(Color(Constants.Color.primaryColor))
                    })
                    
                    TextField("Search", text: $city)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.trailing)
                        .padding(5)
                        .frame(height: 40)
                        .textFieldStyle(.plain)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.5)))
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: Constants.Image.magnifyingglass)
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundStyle(Color(Constants.Color.primaryColor))
                    })
                }
                .padding(.horizontal, 16)
                
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Image(systemName: "sun.max")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundStyle(Color(Constants.Color.primaryColor))
                        Text("21°C")
                            .font(.system(size: 100))
                        Text("Szczecin")
                            .font(.system(size: 30))
                    }
                    .padding(.trailing, 16)
                }
                .padding(.top, 8)
                Spacer()
            }
        }
        .padding(.all, 0.0)
    }
}

#Preview {
    MainView()
}
