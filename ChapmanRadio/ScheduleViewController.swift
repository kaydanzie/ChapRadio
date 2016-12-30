//
//  ScheduleViewController.swift
//  ChapmanRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var daysTableView: UITableView!
    
    var parsed : NSDictionary!
    var parsedA : NSArray!
    
    //all the possible days in the schedule JSON
    //not all are present at same time
    //use validateDays() to clear out ones that aren't in the current schedule JSON
    var indeces : [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let test = parseJSON(getJSON("http://api.chapmanradio.com/legacy/schedule.json")) as? NSDictionary{
            parsed = test
            
            validateDays()
            
            self.daysTableView.delegate = self
            self.daysTableView.dataSource = self
            
            
            //move table view down
            let inset = UIEdgeInsetsMake(7, 0, 0, 0)
            self.daysTableView.contentInset = inset
            
            
            let cellNib = UINib(nibName: "DateTableViewCell", bundle: nil)
            self.daysTableView.register(cellNib, forCellReuseIdentifier: "date_cell")
        }
        
        
        
/*
        if let test = parseJSONArray(getJSON("http://api.chapmanradio.com/legacy/schedule.json")) as? NSArray {
            parsedA = test
            
            self.daysTableView.delegate = self
            self.daysTableView.dataSource = self
            
            //set up for tableview
            

            
            let inset = UIEdgeInsetsMake(10, 0, 0, 0)
            self.daysTableView.contentInset = inset
            
            
            let cellNib = UINib(nibName: "DateTableViewCell", bundle: nil)
            self.daysTableView.registerNib(cellNib, forCellReuseIdentifier: "date_cell")

        
        }
*/
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "date_cell") as! DateTableViewCell
        
        let thisIndex = self.indeces[indexPath.row]
        
        
        //if schedule uses dictionaries
        if let days = parsed[thisIndex]{
            let title = (days as! NSDictionary)["title"] as! NSString
            cell.initWithDate(indexPath.row, title: title as String, count: indeces.count)
        }
        
        
        //schedule uses arrays
//        if let today = parsedA[indexPath.row] as? NSDictionary{
//            let title = today["title"] as! NSString
//            cell.initWithArray(indexPath.row, title: title as String)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.init(red: 1, green: 51, blue: 85, alpha: 0)
        cell.textLabel?.textColor = UIColor.white
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return parsedA.count
        return indeces.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.daysTableView.deselectRow(at: indexPath, animated: false)
        
        let navVC = self.storyboard!.instantiateViewController(withIdentifier: "day_view") as! UINavigationController
        let dayVC = navVC.viewControllers[0] as! DayViewController
        
        
        //for dictionary
        let today = parsed[self.indeces[indexPath.row]] as! NSDictionary
        
        //for array
        //let today = parsedA[indexPath.row] as! NSDictionary
        
        
        dayVC.data = today["data"] as! NSArray
        dayVC.dateTitle = today["title"] as! String
        
        self.present(navVC, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func goBack(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func getJSON(_ urlToRequest: String) -> Data {
        return (try! Data(contentsOf: URL(string: urlToRequest)!))
        //return (try String(contentsOf: urlToRequest)).data(using: .utf8)!
    }
    
    
    //when JSON is dictionary of dictionaries
    func parseJSON(_ input : Data) -> NSDictionary{
        
        var dictionary : NSDictionary = [:]
        
        do{
            dictionary = try JSONSerialization.jsonObject(with: input, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            return dictionary
        } catch {
            
        }
        
        return dictionary
    }
    
    
    //when JSON is array of dictionaries
    func parseJSONArray(_ input : Data) -> NSArray{
        
        var array : NSArray = []
        
        do{
            array = try JSONSerialization.jsonObject(with: input, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            return array
        } catch {
            
        }
        
        return array
    }
    
    
    //removes indeces from indeces array if current JSON schedule doesn't include it
    func validateDays() -> () {
        
        var removed = 0
        
        //always contains 12 to start with
        for i in 1...12 {
            
            let test : String = "\(i)"
            
            if let _ = parsed[test] as? NSDictionary {
                
            }
            else {
                removed += 1
                indeces.remove(at: i-removed)
            }
        }
    }

}
