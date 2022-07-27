//
//  ContentView.swift
//  Za Hunter
//
//  Created by Lina Bhatia on 7/27/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var places = [Place]()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @StateObject var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.0558, longitude: -87.6743),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: places) {place in MapPin(coordinate: place.annotation.coordinate)
            
        }
            .onAppear(){
                preformSearch(item: "Pizza ")
            }
    }
    
    func preformSearch(item: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = item
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        search.start {(response, erorr) in
            if let response = response {
                for mapItem in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = mapItem.placemark.coordinate
                    annotation.title = mapItem.name
                    places.append(Place(annotation: annotation, mapItem: mapItem))
                }
            }
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Place: Identifiable {
    let id = UUID()
    let annotation: MKPointAnnotation
    let mapItem: MKMapItem
    
}

