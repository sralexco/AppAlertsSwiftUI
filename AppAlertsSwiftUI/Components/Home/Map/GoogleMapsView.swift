//
//  GoogleMapsView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    @StateObject var locationManager = LocationManager()
    private let zoom: Float = 15.0
    
    var alerts = [AlertMModel]()
    
    var callback : (Int) -> () = { _ in }
    
    var isShow = false
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let latitude:CLLocationDegrees = locationManager.manager.location?.coordinate.latitude ?? 0
        let longitude:CLLocationDegrees = locationManager.manager.location?.coordinate.longitude ?? 0
        let camera = GMSCameraPosition.camera(withLatitude:latitude, longitude: longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = context.coordinator
        return mapView
    }
    
   func updateUIView(_ mapView: GMSMapView, context: Context) {
        for (index, obj) in alerts.enumerated() {
            let marker : GMSMarker = GMSMarker()
            let lat:Double = Double(obj.lat) ?? 0.0
            let lon:Double = Double(obj.lon) ?? 0.0
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon )
            marker.title = obj.title
            marker.snippet = obj.description
            marker.map = mapView
            marker.userData = Int(index)
        }
    }
    
    func showCardDetail(row:Int){
        self.callback(row)
    }
    
}

class MapCoordinator: NSObject, GMSMapViewDelegate {
    
    let parent: GoogleMapsView
    
    init(parent: GoogleMapsView) {
        self.parent = parent
    }
    
    deinit {
        print("deinit: MapCoordinator")
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let row = marker.userData as? Int else {
            return false
        }
        parent.showCardDetail(row: row)
        return true
    }
    
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}
