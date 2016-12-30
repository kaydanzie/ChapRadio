//
//  DayViewController.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //data = an array of arrays
    //contains all shows, then show information
    //one day only
    var data : NSArray!
    var dateTitle : String!
    @IBOutlet weak var dataTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title on navigation controller
        self.title = dateTitle

        self.dataTableView.dataSource = self
        self.dataTableView.delegate = self
        
        
        let cellNib = UINib(nibName: "ShowTableViewCell", bundle: nil)
        self.dataTableView.register(cellNib, forCellReuseIdentifier: "show_cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navVC = self.storyboard!.instantiateViewController(withIdentifier: "show_view") as! UINavigationController
        
        let showVC = navVC.viewControllers[0] as! ShowViewController
        showVC.showInfo = self.data[indexPath.row] as! NSArray
        
        self.present(navVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.data[indexPath.row] as! NSArray
        
        var name = info[1] as! String
        if name.contains("&amp;") {
            name = name.replacingOccurrences(of: "&amp;", with: "&")
        }
        let time = info[2] as! String
        let cell = tableView.dequeueReusableCell(withIdentifier: "show_cell") as! ShowTableViewCell
        cell.initWithShow(name, time: time)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.init(red: 1, green: 51, blue: 85, alpha: 0)
    }
    
}
