//
//  ViewController.swift
//  Pursuit-Core-iOS-MapKit-Introduction-Lab
//
//  Created by Bienbenido Angeles on 2/25/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var schools = [School]()
    private var annotations = [MKPointAnnotation]()
    
    private var isShowingNewAnnotations = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSchools()
        mapView.delegate = self
    }

    private func loadSchools(){
        NYCDataAPIClient.getSchools { (result) in
            switch result{
            case .failure(let appError):
                print("\(appError)")
            case .success(let schools):
                self.schools = schools
                DispatchQueue.main.async {
                    self.loadMap()
                }
            }
        }
    }
    
    private func loadMap() {
      let annotations = makeAnnotations()
      mapView.addAnnotations(annotations)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(schools.first!.latitude)!, longitude: Double(schools.first!.longitude)!), latitudinalMeters: 5000, longitudinalMeters: 5000)
        self.mapView.setRegion(region, animated: true)
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
      var annotations = [MKPointAnnotation]()
      for location in schools {
        let annotation = MKPointAnnotation()
        annotation.title = location.schoolName
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)
        annotations.append(annotation)
      }
      isShowingNewAnnotations = true
      self.annotations = annotations
      return annotations
    }

}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      guard annotation is MKPointAnnotation else { return nil }
      
      let identifier = "annotationView"
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
      
      if annotationView == nil {
        annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        annotationView?.glyphTintColor = .systemYellow
        annotationView?.markerTintColor = .systemBlue
      } else {
        annotationView?.annotation = annotation
      }
      return annotationView
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
      if isShowingNewAnnotations {
        mapView.showAnnotations(annotations, animated: false)
      }
      isShowingNewAnnotations = false
    }
}
