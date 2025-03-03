//
//  MapViewController.swift
//  AllThingsHalal
//
//  Created by Nayla Rosihan on 27/5/2024.
//

import UIKit 
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631)
        let regionRadius: CLLocationDistance = 10000  
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        searchBar.delegate = self
        setupInitialLocation()
    }

    private func setupInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631)
        let regionRadius: CLLocationDistance = 10000
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchInMap(searchText)
        }
    }

    private func searchInMap(_ searchText: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region = mapView.region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print("Error searching for: \(searchText) error: \(String(describing: error))")
                return
            }
            self.mapView.removeAnnotations(self.mapView.annotations)
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.title = item.name
                annotation.coordinate = item.placemark.coordinate
                self.mapView.addAnnotation(annotation)
            }
            if let firstItem = response.mapItems.first {
                self.mapView.setCenter(firstItem.placemark.coordinate, animated: true)
            }
        }
    }
}
