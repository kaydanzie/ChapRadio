//
//  DateTableViewCell.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithDate(_ position: Int, title: String, count: Int) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let userCalendar = Calendar.current
        var formattedDate : String = ""
        var newDate = Date()
        
        //no today
        if count<=6 {
            if position==0{ //tomorrow
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 1, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==1{
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 2, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==2{
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 3, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==3 {
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 4, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==4 {
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 5, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==5{
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 6, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
        }
        else{
            if position==0{
                //today, do not modify
                formattedDate = formatter.string(from: Date())
            }
            else if position==1{ //tomorrow
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 1, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==2{
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 2, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==3{
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 3, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==4 {
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 4, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==5 {
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 5, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
            else if position==6{
                newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 6, to: Date(), options: [])!
                formattedDate = formatter.string(from: newDate)
            }
        }
        

        
        self.dateLabel.text! = formattedDate
        self.titleLabel.text! = title
    }
    
    
    func initWithArray(_ position: Int, title: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let userCalendar = Calendar.current
        var formattedDate : String = ""
        var newDate = Date()
        
        switch position {
        case 0:
            //today, do not modify
            formattedDate = formatter.string(from: Date())
        case 1:
            newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 1, to: Date(), options: [])!
            formattedDate = formatter.string(from: newDate)
            break
        case 2:
            newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 2, to: Date(), options: [])!
            formattedDate = formatter.string(from: newDate)
            break
        case 3:
            newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 3, to: Date(), options: [])!
            formattedDate = formatter.string(from: newDate)
            break
        case 4:
            newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 4, to: Date(), options: [])!
            formattedDate = formatter.string(from: newDate)
            break
        case 5:
            newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 5, to: Date(), options: [])!
            formattedDate = formatter.string(from: newDate)
            break
        case 6:
            newDate = (userCalendar as NSCalendar).date(byAdding: [.day], value: 6, to: Date(), options: [])!
            formattedDate = formatter.string(from: newDate)
            break
        default:
            break
        }
        
        self.dateLabel.text! = formattedDate
        self.titleLabel.text! = title
    }
    
}
