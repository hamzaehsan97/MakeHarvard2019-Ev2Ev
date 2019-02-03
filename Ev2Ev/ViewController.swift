//
//  ViewController.swift
//  Ev2Ev
//
//  Created by Hamza Ehsan on 2/2/19.
//  Copyright © 2019 Hamza Ehsan. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var carRequest: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var carDistance: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    
    @IBAction func toggleButton(_ sender: UISwitch) {
        if(mapView.isHidden == true){
            mapView.isHidden = false
        }else{
            mapView.isHidden = true
        }
    }
    @IBAction func back(_ sender: Any) {
        
        requestButton.isHidden=false
        backButton.isHidden=true
        mapView.isHidden = false
        carDistance.text = ""
        carRequest.text = ""
        costLabel.text = ""
        arrivalLabel.text = ""
    }
    @IBAction func buttonClick(_ sender: Any) {
        requestButton.isHidden=true
        backButton.isHidden=false
        credit-=200
        creditLabel.text = "\(credit)"
        mapView.isHidden = true
        carDistance.text = "Distance = 1.42 miles"
        carRequest.text = "Your request has been accepted"
        costLabel.text = "Cost = 200 credit points"
        arrivalLabel.text = "Arrival time =  6 minutes"
    }
    
    var credit: Int = 1000
    var charge: Int = 200
    var car = [cars]()
    func fetchData()
    {
        let fileName = Bundle.main.path(forResource: "carStats", ofType:"json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?
        do{
            data = try Data(contentsOf: filePath)
        } catch let error{
            data = nil
            print("error")
        }
        if let jsonData = data {
            let json = try! JSON(data: jsonData)
            if let carsJSONs = json["responses"]["cars"].array {
                for carsJSON in carsJSONs {
                    if let cars = cars.from(json: carsJSON){
                        self.car.append(cars)
                    }
                }
            }
            else{
                print("error1")
            }
        }
        else{
            print("error")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
       let initialLocation = CLLocation(latitude: 42.380098, longitude: -71.116629)
        zoomOnMap(location: initialLocation)
        
        let sample = cars(title: "You", charge: "20%: Recharge", coordinate: CLLocationCoordinate2D(latitude: 42.380098, longitude: -71.116629))
        mapView.addAnnotation(sample)
        creditLabel.text = "\(credit)"
        fetchData()
        mapView.addAnnotations(car)
        backButton.isHidden=true
    }
    
    private let regionRadius : CLLocationDistance = 1000
    
    func zoomOnMap(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 1.0, regionRadius * 1.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
