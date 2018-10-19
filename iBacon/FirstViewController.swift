//
//  FirstViewController.swift
//  iBacon
//
//  Created by 14223775 on 19/10/2018.
//  Copyright © 2018 14223775. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    let center = UNUserNotificationCenter.current()
    @IBOutlet var label: UILabel!
    let locationManager = CLLocationManager()
    
    @IBAction func switched(_ sender: Any) {
        let uuid = UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825");
        
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 2510, identifier: "Region 2510")
        
        if let thisSender = sender as? UISwitch {
            
            if (thisSender.isOn == true) {
                
                locationManager.startMonitoring(for: beaconRegion)
                
                label.text = "Started Monitoring"
                
            } else {
                
                locationManager.stopMonitoring(for: beaconRegion)
                
                label.text = "Stopped Monitoring"
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        guard region is CLBeaconRegion else { return }
        
        label.text = "Now Monitoring \(region.identifier)...";
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        guard region is CLBeaconRegion else { return }
        
        label.text = "In \(region.identifier)!"
        
        let content = UNMutableNotificationContent()
        content.title = "iBacons App"
        content.body = "Entering the \(region.identifier)!"
        content.sound = .default()
        
        let request = UNNotificationRequest(identifier: "entering", content: content, trigger: nil)
        center.add(request, withCompletionHandler: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        guard region is CLBeaconRegion else { return }
        
        label.text = "Left \(region.identifier)."
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in }
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

