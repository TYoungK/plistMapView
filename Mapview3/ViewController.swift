//
//  ViewController.swift
//  Mapview3
//
//  Created by D7703_29 on 2017. 9. 18..
//  Copyright © 2017년 D7703_29. All rights reserved.
//

import UIKit
import MapKit
var picarray = [String]()
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
                let pic = (item as AnyObject).value(forKeyPath: "pic")
                let annotation = MKPointAnnotation()
                let mypic = pic as! String
                picarray.append(mypic)
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        
        // an already allocated annotation view
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            //annotationView?.pinTintColor = UIColor.green
            annotationView?.animatesDrop = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        if annotation.title! == "DIT" {
            leftIconView.image = UIImage(named:picarray[0] )
            annotationView?.pinTintColor = UIColor.green
        }
        if annotation.title! == "부산시민공원" {
            leftIconView.image = UIImage(named:picarray[1] )
            annotationView?.pinTintColor = UIColor.blue
        }
        if annotation.title! == "송상현광장" {
            leftIconView.image = UIImage(named:picarray[2] )
            annotationView?.pinTintColor = UIColor.black
        }
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView

    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let viewAnno = view.annotation //as! ViewPoint
        let placeName = viewAnno?.title
        let placeInfo = viewAnno?.subtitle
        
        let ac = UIAlertController(title: placeName!, message: placeInfo!, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func locationtocenter(){
        
        let center = CLLocationCoordinate2DMake(36.166197,129.072594)
        let span = MKCoordinateSpanMake(0.05,0.05)
        let region = MKCoordinateRegionMake(center, span)
        map.setRegion(region, animated: true)
    }
}

