//
//  NavigationBar.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import SwiftUI

class NavigationBarViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var showLeft: Bool = false
    @Published var showRight: Bool = false
    @Published var imgLeft: String = "ic_nvBack"
    @Published var imgRight: String = ""
}

struct NavigationBar: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var vm = NavigationBarViewModel()
    var callbackLeft: () -> Void = {}
    var callbackRight: () -> Void = {}
    
    init(title: String, showLeft: Bool = true, showRight: Bool = false, imgLeft: String = "ic_nvBack",
         imgRight: String = "", callbackLeft: @escaping () -> Void = {}, callbackRight: @escaping () -> Void = {}) {
        vm.title = title
        vm.showLeft = showLeft
        vm.showRight = showRight
        vm.imgLeft = imgLeft
        vm.imgRight = imgRight
        self.callbackLeft = callbackLeft
        self.callbackRight = callbackRight
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack(alignment: .top, spacing: 0) {
                    if vm.showLeft == true {
                        Button(action: {
                            self.callbackLeft()
                        }, label: {
                            HStack {
                                Image(vm.imgLeft)
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                    .resizable()
                                    .frame(width: 22, height: 22)
                            }
                            .frame(width: 40, height: 64)
                        })
                        .background(.white)
                        .padding(.leading, 10)
                    } else {
                        HStack {}
                        .frame(width: 40, height: 64)
                    }
                   
                    Spacer()
                    
                    Text(vm.title)
                        .padding(.top, 20)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black1)
                    
                    Spacer()
                    
                    if vm.showRight == true {
                        Button(action: {
                            self.callbackRight()
                        }, label: {
                            HStack {
                                Image(vm.imgRight)
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                    .resizable()
                                    .frame(width: 22, height: 22)
                            }
                            .frame(width: 40, height: 64)
                        })
                        .background(.white)
                        .padding(.trailing, 10)
                    } else {
                        HStack {}
                        .frame(width: 40, height: 64)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                Spacer(minLength: 0)
                Rectangle()
                    .fill(Color.gray1)
                    .frame(height: 0.5)
                    .padding(.bottom, 0)
            }
            .zIndex(1)
        }
        .background(.white)
        .frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
