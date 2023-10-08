//
//  MainView.swift
//  WeatherApp
//
//  Created by Jakub Rękas on 04/10/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var city = ""
    
    var body: some View {
        ZStack {
            Image(Constants.Image.backgroundImage)
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 10) {
                    Button(action: {
                        viewModel.getLocalization()
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
                        viewModel.getTemperatureFromCity(city: city)
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
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundStyle(Color(Constants.Color.primaryColor))
                        Text(temp)
                            .font(.system(size: 100))
                            .foregroundStyle(Color(Constants.Color.primaryColor))
                        Text(cityName)
                            .font(.system(size: 30))
                            .foregroundStyle(Color(Constants.Color.primaryColor))
                    }
                    .padding(.trailing, 16)
                }
                .padding(.top, 8)
                Spacer()
            }
            
            if searching {
                ProgressView()
            }
        }
        .padding(.all, 0.0)
    }
    
    var searching: Bool {
        viewModel.searching
    }
    
    var temp: String {
        if let weather = viewModel.weather {
            return weather.temperatureString
        } else {
            return ""
        }
    }
    
    var cityName: String {
        if let weather = viewModel.weather {
            return weather.cityName
        } else {
            return ""
        }
    }
    
    var imageName: String {
        if let weather = viewModel.weather {
            return weather.conditionName
        } else {
            return ""
        }
    }
}

#Preview {
    MainView()
}
