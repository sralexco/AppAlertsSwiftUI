//
//  CreateAlertView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 21/03/25.
//

import SwiftUI
import PhotosUI
import Combine

struct CreateAlertView: View {
    @Binding var path: [MyAlertsRoute]
    @StateObject var VM = CreateAlertViewModel()
    @State private var photoItem: PhotosPickerItem?
    var title = "Create Alert"
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar(title: title, showLeft: true, showRight: false, imgLeft: "ic_nvBack",
                          callbackLeft: { path.removeLast() })
                .frame(height: 60)
            
            VStack {
                FloatingTextField(title: "Title", text: $VM.title, isError: $VM.titleError)
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16 ))
                FloatingTextField(title: "Description", text: $VM.description, isError: $VM.descriptionError)
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16 ))
                FloatingTextFieldAlter(title: "Type", isError: $VM.selectedTypeError, content: {
                    Menu {
                        Picker(selection: $VM.selectedType) {
                            ForEach(0..<VM.types.count, id: \.self) { index in
                                Text(VM.types[index].title).padding(.leading, -50)
                            }
                        } label: {}
                    } label: {
                        if !VM.types.isEmpty {
                            Text(VM.types[VM.selectedType].title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black1)
                                .padding(.top, 2)
                        } else {
                            Text("Selected")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black2)
                                .padding(.top, 2)
                        }
                    }
                })
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16 ))
                
                FloatingTextFieldAlter(title: "Location", isError: $VM.locationError, content: {
                    Text(VM.location)
                        .frame(maxWidth: .infinity, alignment: .leading)
                       // .font(.roboto(.regular, size: 16))
                        .foregroundColor(.black2)
                        .background(.white)
                        .padding(.top, 2)
                        .onTapGesture {
                            path.append(MyAlertsRoute.choiseLocation)
                        }
                }).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 10, leading: 16, bottom: 0, trailing: 16 ))
                
                FloatingTextFieldAlter(title: "Image", isError: $VM.imageError, content: {
                    PhotosPicker(
                        selection: $photoItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Text(VM.textImage)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black2)
                                .background(.white)
                                .padding(.top, 4)
                        }
                        .onChange(of: photoItem) { newItem in
                            Task {
                                if let data = try? await photoItem?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        VM.photoImage = Image(uiImage: uiImage)
                                        VM.imageEncode = uiImage.toBase64(format: .jpeg(0.3))
                                        VM.textImage = "Selected"
                                        return
                                    }
                                }
                                print("Failed")
                            }
                        }
                }).padding(.init(top: 10, leading: 16, bottom: 0, trailing: 16 ))
                
                if let _ = VM.photoImage {
                    VM.photoImage!
                        .resizable()
                        .frame(width: 160, height: 160)
                        .padding(.leading, 16)
                        .padding(.top, 10)
                }
                
                Button(action: createAction,
                       label: { Text("Save")})
                    .customStyle(.primary)
                    .padding(.top, 20)
                Spacer()
            }
            .background(.white)
            .padding(.top, 76)
            .padding([.leading, .trailing], 10)
            Spacer()
        }
        .background(Color.blue1.opacity(0.20))
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        .loadingView(show: $VM.isLoading)
    }
    
    private func createAction(){
        
    }
    
}

/*
 #Preview {
  CreateAlertView()
 }
 */
