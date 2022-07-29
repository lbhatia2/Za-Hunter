//
//  LocationDetailsView.swift
//  Za Hunter
//
//  Created by Lina Bhatia on 7/27/22.
//


import SwiftUI
import MapKit

struct LocationDetailsView: View {
    var selectedMapItem: MKMapItem
    var body: some View {
        let address = selectedMapItem.placemark.subThoroughfare! + "" + //street address number
        selectedMapItem.placemark.thoroughfare! + "\n" + //street name
        selectedMapItem.placemark.locality! + ", " + //state
        selectedMapItem.placemark.postalCode! //zip code
        VStack {
            Text(address)
            Text(selectedMapItem.name!)
                .font(.title)
                .padding()
            Link(destination: selectedMapItem.url!) {
                Text("Website")
                    .padding()
            }
            Button {
                let latitude = selectedMapItem.placemark.coordinate.latitude
                let longitude = selectedMapItem.placemark.coordinate.longitude
                let url = URL(string: "maps://?daddr=\(latitude),\(longitude)")
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:])
                }
            } label: {
                Text("Directions")
            }
        }
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailsView(selectedMapItem: MKMapItem())
    }
}
