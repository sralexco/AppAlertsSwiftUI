//
//  DetailAlertView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//
import SwiftUI

struct DetailAlertMView: View {
    var alertID: Int
    @State private var title = ""
    @Binding var path: [MapRoute]
    @StateObject var VM = DetailAlertMViewModel()
    @EnvironmentObject var loadingManager: LoadingManager
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar(title: title, showLeft: true, showRight: false, imgLeft: "ic_nvBack",
                          callbackLeft: { path.removeLast() })
                .frame(height: 60)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(VM.title)
                        .customStyle(.title)
                        .padding(.top, 12)
                        .padding([.leading, .trailing], 20)
                    Text("\(VM.address) - \(VM.date)")
                        .customStyle(.primary2)
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 1)
                    Text("Type: \(VM.type) - By: \(VM.author)")
                        .customStyle(.primary2)
                        .padding(.top, 0)
                        .padding([.leading, .trailing], 20)
                    Text(VM.description)
                        .customStyle(.primary2)
                        .foregroundColor(.black1)
                        .padding(.top, 1)
                        .padding([.leading, .trailing], 20)
                    VStack(spacing: 16) {
                        if VM.image != "" {
                            if let uiImage = VM.image.imageFromBase64 {
                                let photoImage = Image(uiImage: uiImage)
                                ImageCellThree(image: photoImage)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding([.leading, .trailing], 20)
            }
            .padding(.top, 10)
            Spacer()
        }
        .background(Color.blue1.opacity(0.20))
        .onAppear {
            UIScrollView.appearance().bounces = false
            title = "Alert nª\(self.alertID)"
            VM.id = self.alertID
            VM.requestGetAlert()
        }
        .navigationBarHidden(true)
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        
    }
}

struct ImageCellThree: View {
    var image: Image
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .padding([.leading, .trailing], 20)
                .background(Color.white)
        }
    }
}
