//
//  MapViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 10/06/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class MapViewController: UIViewController{
    var annotation = MKPointAnnotation()
   
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var selector: UISegmentedControl!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2DMake(38.340594, -0.487281)
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region = MKCoordinateRegion(center: location,span: span)
        
        mapView.setRegion(region, animated: true)
        
      
    //    annotation.setCoordinate(location)
        
    }
    @IBAction func mapChangeAction(_ sender: Any) {
        
        switch  selector.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        
        default:
            break
        }
    }
    
    //libc++abi.dylib: terminating with uncaught exception of type NSException
    
  
}
