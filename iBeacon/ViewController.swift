//
//  ViewController.swift
//  iBeacon
//
//  Created by Sagar Mutha on 4/14/16.
//  Copyright © 2016 SmartApps India. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "416C0120-5960-4280-A67C-A2A9BB166D0F")!, identifier: "SmartApps_Beacon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
        locationManager.startMonitoringForRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendLocalNotificationWithMessage(message: String) {
        let notification = UILocalNotification()
        
        notification.alertBody = message
        notification.alertAction = "View Details"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }

    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        print(beacons)
    }

    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("You have entered the beacon region")
        sendLocalNotificationWithMessage("I found you!!")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("You have exited the beacon region")
        sendLocalNotificationWithMessage("I lost you :(")
    }
}

