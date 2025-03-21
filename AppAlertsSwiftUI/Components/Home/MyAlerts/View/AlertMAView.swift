//
//  Alert2View.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//
import SwiftUI

struct AlertMAView: View {
    var alert: DataMyAlertsModel
    
    var body: some View {
        HStack(alignment: .center) {
            Rectangle()
                .fill(Color.blue1)
                .frame(maxWidth: 4)
                .padding(.leading, 0)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(alert.title)
                    .padding(.top, 12)
                    .padding(.leading, 12)
                    //.font(.roboto(.bold, size: 16))
                    .foregroundColor(.black1)
                
                let localDate = Date().convertUTCtoLocal(format: "yyyy-MM-dd HH:mm:ss", date: alert.date)
                let formatLocal = Date().byFormat(format: "dd/MM/YY", date: localDate)
                
                Text("\(alert.city) - \(alert.country) - \(formatLocal)")
                    .padding(.top, 4)
                    .padding(.leading, 12)
                    //.font(.roboto(.regular, size: 16))
                    .foregroundColor(.black1)
                
                Spacer(minLength: 0)
            }
            Spacer()
            Image("ic_next")
                .resizable()
                .frame(width: 8, height: 14)
                .padding(.trailing,16)
            
        }
        .frame(height: 64)
        .background(.white)
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}
