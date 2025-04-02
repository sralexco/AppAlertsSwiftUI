//
//  AlertInfoView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 19/03/25.
//

import SwiftUI

struct AlertInfoView: View {
    var text: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Image("ic_info")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .padding(.leading, 10)
                
                Text(text)
                    .font(.headline)
                    .foregroundColor(.black1)
                    .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            .background(.white)
            .cornerRadius(12)
            .padding(.top, 10)
            .padding([.leading, .trailing], 10)
            Spacer()
        }
        .zIndex(1)
    }
}
