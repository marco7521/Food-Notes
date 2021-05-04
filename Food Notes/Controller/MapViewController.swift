//
//  MapViewController.swift
//  Food Notes
//
//  Created by admin on 2021/5/4.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant: Restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        // 地址轉換為座標後標記在地圖上
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.address, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            if let placemarks = placemarks {
                // 取得第一個地點標記
                let placemark = placemarks[0]
                
                // 加上標記
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.types
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // 顯示標記
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
    }
    // MARK: - MKMapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // 如果可行則再重複使用標記
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "😋" //顯示在氣球標記的文字
        annotationView?.markerTintColor = UIColor.orange //氣球標記的背景顏色
        
        return annotationView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
