//
//  ContentView.swift
//  Za Hunter
//
//  Created by Lina Bhatia on 7/27/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
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
        userTrackingMode: $userTrackingMode)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
