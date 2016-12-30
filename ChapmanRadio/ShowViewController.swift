//
//  ShowViewController.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {


    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var descFromMain : String!
    var genre : String!
    var time : String!
    var nameMain : String!
    var urlMain : String!
    var showInfo : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //coming from DayViewController tableview cells
        //gets set in didSelectRowAtIndexPath
        if showInfo != nil {
            let imgURL = formatURL(showInfo[6] as! String)
            if let url = URL(string: "http://"+imgURL){
                self.showImageView.contentMode = .scaleAspectFit
                if let data = try? Data(contentsOf: url){
                    self.showImageView.image = UIImage(data: data)
                }
            }
            
            if var name = showInfo[1] as? String{
                
                var desc = showInfo[4] as! String
                
                
                //remove escape characters from name and description
                if name.contains("&amp;"){
                    name = name.replacingOccurrences(of: "&amp;", with: "&")
                }
                
                if desc.contains("\\\'") {
                    desc = desc.replacingOccurrences(of: "\\\'", with: "'")
                }
                if desc.contains("\\\"") {
                    desc = desc.replacingOccurrences(of: "\\\"", with: "\"")
                }
                
                
                self.title = name
                self.nameLabel.text! = name
                self.timeLabel.text! = showInfo[2] as! String
                self.genreLabel.text! = showInfo[3] as! String
                self.descriptionLabel.text! = desc
            }
        }
        
        
        
        
        //coming from main view controller "Show Details" button
        else {
            
            //let imgURL = formatURL(self.urlMain)
            if let url = URL(string: "http://"+self.urlMain){
                self.showImageView.contentMode = .scaleAspectFit
                if let data = try? Data(contentsOf: url){
                    self.showImageView.image = UIImage(data: data)
                }
            }
            
            
            //remove escape characters in name and description
            if nameMain.contains("&amp;"){
                nameMain = nameMain.replacingOccurrences(of: "&amp;", with: "&")
            }
            
            if descFromMain.contains("\\\'") {
                descFromMain = descFromMain.replacingOccurrences(of: "\\\'", with: "'")
            }
            if descFromMain.contains("\\\"") {
                descFromMain = descFromMain.replacingOccurrences(of: "\\\"", with: "\"")
            }
            
            self.timeLabel.text! = self.time
            self.nameLabel.text! = self.nameMain
            self.title = self.nameMain
            self.genreLabel.text! = self.genre
            self.descriptionLabel.text! = descFromMain
        }
        
        
        self.descriptionLabel.adjustsFontSizeToFitWidth = true
        self.timeLabel.adjustsFontSizeToFitWidth = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func goCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func formatURL(_ old: String) -> String {
        var new = old.substring(with: Range<String.Index>(old.startIndex..<old.characters.index(old.endIndex, offsetBy: -11)))
        new = new.substring(with: Range<String.Index>(new.characters.index(new.startIndex, offsetBy: 2)..<new.endIndex))
        
        return new
    }
}
