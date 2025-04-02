//
//  ProgNavBar.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 31/03/25.
//
import SwiftUI

struct ProNavBar: View {
    var title: String = ""
    var hasRightOptions: Bool = false
    var imageRight: String = ""
    var callbackRight: () -> Void
    
    init(title: String, hasRightOptions: Bool = false, imageRight: String = "",
         callbackRight: @escaping () -> Void = {}) {
        self.title = title
        self.hasRightOptions = hasRightOptions
        self.imageRight = imageRight
        self.callbackRight = callbackRight
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                   .padding(.leading, 20)
                   .font(.system(size: 30, weight: .regular))
                   
                Spacer()
                
                if hasRightOptions {
                    Button(action: callbackRight, label: {
                        HStack {
                            Spacer()
                            Image(imageRight)
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                        .frame(width: 70, height: 64)
                        .background(.clear)
                    })
                    .padding(.trailing, 20)
                }
                
            }
           
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}
