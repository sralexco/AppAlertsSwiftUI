//
//  ChoiseLocation.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 22/03/25.
//

import SwiftUI

extension Notification.Name {
    static let choiseLocation = Notification.Name("choiseLocation")
}

struct ChoiseLocation: View {
    
    @Binding var path:[MyAlertsRoute]
    
    @State var hideDetail = true
    @State var latitude:Double = 0
    @State var longitude:Double = 0
    
    var title = "Choise Location"
    
    var body: some View {
            ZStack(alignment: .center){
                VStack(alignment: .center, spacing: 0){
                    Text("Alerts")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .frame(alignment: .center)
                        .background(.white)
                    Rectangle()
                        .fill(Color.gray1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 0.5)
                    GoogleMapsChoise(currentLatitude: $latitude, currentLongitude:$longitude)
                        .padding(.top, -8)
                    
                    Button(action: {
                        acceptLocation()
                    }, label: {
                       Text("ACCEPT")
                            //.font(.roboto(.medium, size: 16))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.blue1)
                            .cornerRadius(12)
                    }).padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16 ))
                      .background(.white)
                    
                    Spacer(minLength: 0)
                }
               
            }
            .navigationBarHidden(true)
            .overlay { NavigationBar(title: title,
                                     showLeft: true,
                                     showRight: false, imgLeft: "ic_nvBack",
                                     callbackLeft: {
                print(path)
                path.removeLast()
            }) }
    }
    
    func acceptLocation(){
        NotificationCenter.default.post(name: NSNotification.Name.choiseLocation,
                                        object: nil, userInfo: ["lat": latitude, "lon": longitude])
        path.removeLast()
    }
    
}

/*
struct ChoiseLocation_Previews: PreviewProvider {
    static var previews: some View {
        MapAlerts()
    }
} */
