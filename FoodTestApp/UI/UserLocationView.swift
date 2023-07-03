//
//  UserLocationView.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 02.07.2023.
//

import SwiftUI

final class UserLocationViewModel: ObservableObject {
    private let userLocationManager = UserLocationManager.shared
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM, YYY"
        return dateFormatter.string(from: Date())
    }
    
    @Published var userLocation = ""
    
    init() {
        getUserLocation()
    }
    
    private func getUserLocation() {
        userLocationManager.getUserLocationName { city in
            guard let city = city else { return }
            self.userLocation = city
        }
    }
}

struct UserLocationView: View {
    @StateObject var viewModel = UserLocationViewModel()
    var body: some View {
        HStack(alignment: .top) {
            Image("locationImage")
                .resizable()
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading) {
                Text(viewModel.userLocation)
                    .font(.custom("SFProDisplay-Medium", size: 18))
                
                Text(viewModel.currentDate)
                    .foregroundColor(.black.opacity(0.5))
                    .font(.custom("SFProDisplay-Regular", size: 14))
            }
        }
    }
}

struct UserLocationView_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationView()
    }
}
