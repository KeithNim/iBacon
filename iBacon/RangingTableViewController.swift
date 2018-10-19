//
//  RangingTableViewController.swift
//  iBacon
//
//  Created by 14223775 on 19/10/2018.
//  Copyright © 2018 14223775. All rights reserved.
//

import UIKit
import CoreLocation

class RangingTableViewController: UITableViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    var rangedBeacons:[CLBeacon] = [];
    @IBOutlet var rightButton: UIBarButtonItem!
    
    @IBAction func rb_clicked(_ sender: Any) {
        let uuid = UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825");
        
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "all beacons");
        
        if (rightButton.title == "Ranging for beacons") {
            
            locationManager.startRangingBeacons(in: beaconRegion)
            
            rightButton.title = "Stop Ranging"
            
        } else {
            
            locationManager.stopRangingBeacons(in: beaconRegion)
            
            rightButton.title = "Ranging for beacons"
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        print(beacons)
        
        rangedBeacons = beacons.filter() {
            return $0.rssi != 0;
        }
        
        if (rangedBeacons.count > 0) {
            
            var tintColor:UIColor?
            
            switch rangedBeacons[0].major {
                
            case 2310:
                tintColor = UIColor.yellow
                break;
                
            case 2410:
                tintColor = UIColor.green
                break;
                
            case 2510:
                tintColor = UIColor.magenta
                break;
                
            default:
                tintColor = UIColor.cyan
                break;
                
            }
            
            navigationController?.navigationBar.barTintColor = tintColor
            
        } else {
            
            navigationController?.navigationBar.barTintColor = nil
            
        }
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rangedBeacons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rangingCell", for: indexPath)
        
        // Configure the cell...
        
        let thisBeacon = rangedBeacons[indexPath.row]
        
        cell.textLabel?.text = "Major: \(thisBeacon.major), Minor: \(thisBeacon.minor)"
        
        cell.detailTextLabel?.text = "Prox: \(thisBeacon.proximity), Rssi: \(thisBeacon.rssi), Accy: \(String(format: "%.2f", thisBeacon.accuracy))m"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
