//
//  ViewController.swift
//  Mapview3
//
//  Created by D7703_29 on 2017. 9. 18..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "ViewPoint", ofType: "plist")
        print("path=\(String(describing: path))")
        let contents = NSArray(contentsOfFile: path!)
        print("contents=\(String(describing: contents))")
        
        var annotations = [MKPointAnnotation]()
        
        if let myItem = contents{
            for item in myItem{
                let lat = (item as AnyObject).value(forKey: "let")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subtitle = (item as AnyObject).value(forKey: "subtitle")
                let annotation = MKPointAnnotation()
                
                print("lat = \(String(describing: lat))")
                
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                
                print("myLat = \(myLat)")
                
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = title as? String
                annotation.subtitle = subtitle as? String
                
                annotations.append(annotation)
                map.delegate = self
            }
        }
        map.showAnnotations(annotations, animated: true)
        map.addAnnotations(annotations)
    }

    func locationtocenter(){
        
        let center = CLLocationCoordinate2DMake(36.166197,129.072594)
        let span = MKCoordinateSpanMake(0.05,0.05)
        let region = MKCoordinateRegionMake(center, span)
        map.setRegion(region, animated: true)
    }
}

