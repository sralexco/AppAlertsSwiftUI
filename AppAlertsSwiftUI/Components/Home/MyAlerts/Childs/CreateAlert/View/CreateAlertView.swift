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
    @EnvironmentObject var loadingManager: LoadingManager
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBar(title: title, showLeft: true, showRight: false, imgLeft: "ic_nvBack",
                          callbackLeft: { path.removeLast() })
                .frame(height: 60)
            
            VStack {
                FloatingTextField(title: "Title", text: $VM.title, isError: $VM.titleError)
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16 ))
                FloatingTextField(title: "Description", text: $VM.description, isError: $VM.descriptionError)
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16 ))
                FloatingTextFieldAlter(title: "Type", isError: $VM.selectedTypeError, content: {
                        TypePickerMenu(selectedType: $VM.selectedType, types: VM.types, selectedTypeError: VM.selectedTypeError) })
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16 ))
                FloatingTextFieldAlter(title: "Location", isError: $VM.locationError, content: {
                    Text(VM.location)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black2)
                        .background(.white)
                        .padding(.top, 2)
                        .onTapGesture { path.append(MyAlertsRoute.choiseLocation) } })
                    .padding(.init(top: 10, leading: 16, bottom: 0, trailing: 16 ))
                
                FloatingTextFieldAlter(title: "Image", isError: $VM.imageError, content: {
                        ImagePickerView(photoItem: $photoItem, VM: VM) })
                    .padding(.init(top: 10, leading: 16, bottom: 0, trailing: 16 ))
                
                if let image = VM.photoImage {
                    image
                        .resizable()
                        .frame(width: 160, height: 160)
                        .padding(.leading, 16)
                        .padding(.top, 10)
                }
                
                Button(action: createAction, label: { Text("Save")})
                    .customStyle(.primary)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
            }
            .background(.white)
            .padding(.top, 0)
            .padding([.leading, .trailing], 10)
            Spacer()
        }
        .background(Color.blue1.opacity(0.20))
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        .onAppear {
            VM.goBack = { path.removeLast() }
        }
        .onReceive(NotificationCenter.default.publisher(for: .choiseLocation)) { obj in
            guard let userInfo = obj.userInfo as? [String: Any] else { return }
            updateCoordinates(userInfo: userInfo)
        }
    }
    
    private func createAction() {
        VM.requestCreateAlert()
    }
    
    private func updateCoordinates(userInfo: [String: Any]) {
        let lat = userInfo["lat"] as? Double ?? 0.0
        let lon = userInfo["lon"] as? Double ?? 0.0
        VM.location = "\(lat),\(lon)"
        VM.locationLat = "\(lat)"
        VM.locationLon = "\(lon)"
        VM.locationError = false
    }
    
    private func updateCoordinates(lat: Double, lon: Double) {
        VM.location = "\(lat),\(lon)"
        VM.locationLat = "\(lat)"
        VM.locationLon = "\(lon)"
        VM.locationError = false
    }
}


struct TypePickerMenu: View {
    @Binding var selectedType: Int
    let types: [ItemAlertTypeModel]
    let selectedTypeError: Bool

    var body: some View {
        Menu {
            Picker(selection: $selectedType, label: EmptyView()) {
                ForEach(0..<types.count, id: \.self) { index in
                    Text(types[index].title)
                        .padding(.leading, -50)
                }
            }
        } label: {
            if !types.isEmpty {
                Text(types[selectedType].title)
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
    }
}

struct ImagePickerView: View {
    @Binding var photoItem: PhotosPickerItem?
    @ObservedObject var VM: CreateAlertViewModel

    var body: some View {
        PhotosPicker(
            selection: $photoItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Text(VM.textImage)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black2)
                .background(.white)
                .padding(.top, 4)
        }
        .onChange(of: photoItem) { newItem in
            Task {
                if let data = try? await photoItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    VM.photoImage = Image(uiImage: uiImage)
                    VM.imageEncode = uiImage.toBase64(format: .jpeg(0.3))
                    VM.textImage = "Selected"
                    return
                }
                print("Failed")
            }
        }
    }
}

/*
 #Preview {
  CreateAlertView()
 }
 */
