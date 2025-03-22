//
//  GoogleMapsChoise.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 22/03/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsChoise: UIViewRepresentable {
    @StateObject var locationManager = LocationManager()
    private let zoom: Float = 15.0
    
    var defaultMarker = GMSMarker()
    @Binding var currentLatitude:Double
    @Binding var currentLongitude:Double
    
    func makeCoordinator() -> MapChoiseCoordinator {
        return MapChoiseCoordinator(parent: self)
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let latitude:CLLocationDegrees = locationManager.manager.location?.coordinate.latitude ?? 0
        let longitude:CLLocationDegrees = locationManager.manager.location?.coordinate.longitude ?? 0
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = context.coordinator
        
        defaultMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude )
        defaultMarker.title = "Marker"
        defaultMarker.snippet = ""
        defaultMarker.map = mapView
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) { }
    
}

/*
struct GoogleMapsChoise_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}  */

class MapChoiseCoordinator: NSObject, GMSMapViewDelegate {
    
    var parent: GoogleMapsChoise
    
    init(parent: GoogleMapsChoise) {
        self.parent = parent
        let latitude:CLLocationDegrees = parent.locationManager.manager.location?.coordinate.latitude ?? 0
        let longitude:CLLocationDegrees = parent.locationManager.manager.location?.coordinate.longitude ?? 0
        self.parent.currentLatitude = latitude
        self.parent.currentLongitude = longitude
    }
    
    deinit {
        print("deinit: MapCoordinator")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        parent.defaultMarker.position = position.target
        parent.currentLatitude = position.target.latitude
        parent.currentLongitude = position.target.longitude
    }
    
}
