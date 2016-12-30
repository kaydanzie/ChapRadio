//
//  ViewController.swift
//  ChapmanRadio
//
//  Created by Ziegler, Kayla on 5/2/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var djsLabel: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var talkShowLabel: UILabel! // default says "SONG"
    @IBOutlet weak var talkShowDJsLabel: UILabel! // default says "ARTIST"
    @IBOutlet weak var showNameHide: UILabel!
    @IBOutlet weak var djsHide: UILabel!
    @IBOutlet weak var nothingLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    
    var player : AVPlayer!
    
    //used for sending to ShowViewController
    //on button click "Show Details"
    var showDescrip : String = ""
    var genre : String = ""
    var time : String = ""
    var sendURL : String = ""
    var showN : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up AVPlayer
        configureView()
        
        let parsed = parseJSON(getJSON("http://api.chapmanradio.com/legacy/livestreams.json"))
        
        //parsed= show {}, nowplaying {} if not a talk show
        //if a talk show, sometimes nowplaying is empty
        
        let id = parsed["showid"]
        let stringID = String(describing: id!)
        
        
        if let intID = Int(stringID){
            
            let numID = NSNumber(value: intID as Int)
            
            //id = 0 if no show is on
            if numID != 0{
                
                let show = parsed["show"] as! NSDictionary
                
                if let genre = show["genre"]{
                    self.nothingLabel.isHidden = true
                    
                    //talk show
                    if genre as! String == "Talk" {
                        //put in song spot
                        self.talkShowLabel.text! = "TALK SHOW NAME"
                        self.talkShowDJsLabel.text! = "DJS"
                        self.djsHide.isHidden = true
                        self.showNameHide.isHidden = true
                        self.showLabel.isHidden = true
                        self.djsLabel.isHidden = true
                        
                        if let showName = show["showname"]{
                            self.songLabel.text! = showName as! String
                            self.showN = showName as! String
                        }
                        
                        if let djs = show["djs"] {
                            self.artistLabel.text! = djs as! String
                        }
                        
                        if let _ = show["description"] {
                            self.showDescrip = show["description"] as! String
                        }
                        
                        if let t = show["showtime"] {
                            self.time = t as! String
                        }
                        
                        if let _ = show["genre"] {
                            self.genre = show["genre"] as! String
                        }
                        
                        
                        var url = show["pic"] as! String
                        //send url without http://
                        self.sendURL = formatURL(url)
                        url = "http://" + formatURL(url)
                        //because in the place of song not show
                        setSongImage(url)
                        
                        
                        //is a talk show but nowplaying is not empty
                        //either a song or talk topic
                        if let nowplaying = parsed["nowplaying"] as? NSDictionary{
                            
                            //nowplaying is a song
                            if nowplaying["text"] as! String == "" {
                                self.talkShowLabel.text! = "SONG NAME"
                                self.talkShowDJsLabel.text! = "ARTIST"
                                self.djsHide.isHidden = false
                                self.showNameHide.isHidden = false
                                self.showLabel.isHidden = false
                                self.djsLabel.isHidden = false
                                
                                if let songName = nowplaying["track"]{
                                    self.songLabel.text! = songName as! String
                                }
                                
                                let songURL = nowplaying["img100"] as! String
                                setSongImage(songURL)
                                
                                
                                if let artist = nowplaying["artist"] {
                                    self.artistLabel.text! = artist as! String
                                }
                                
                                
                                if let showName = show["showname"]{
                                    self.showLabel.text! = showName as! String
                                    self.showN = showName as! String
                                }
                                
                                if let djs = show["djs"] {
                                    self.djsLabel.text! = djs as! String
                                }
                                
                                if let t = show["showtime"] {
                                    self.time = t as! String
                                }
                                
                                if let _ = show["genre"] {
                                    self.genre = show["genre"] as! String
                                }
                                
                                var url = show["pic"] as! String
                                url = formatURL(url)
                                self.sendURL = url
                                setShowImage(url)
                            }
                            
                            //nowplaying is a talk topic
                            else {
                                self.talkShowLabel.text! = "TOPIC"
                                self.talkShowDJsLabel.isHidden = true //talk topic doesn't have artist
                                self.djsHide.isHidden = false
                                self.showNameHide.isHidden = false
                                self.showLabel.isHidden = false
                                self.djsLabel.isHidden = true
                                self.sendButton.isHidden = true
                                
                                
                                if let topic = nowplaying["text"] {
                                    self.songLabel.text! = topic as! String
                                }
                                
                                if let showName = show["showname"]{
                                    self.showLabel.text! = showName as! String
                                    self.showN = showName as! String
                                }
                                
                                if let djs = show["djs"] {
                                    self.djsLabel.text! = djs as! String
                                }
                                
                                if let t = show["showtime"] {
                                    self.time = t as! String
                                }
                                
                                if let _ = show["genre"] {
                                    self.genre = show["genre"] as! String
                                }
                                
                                var url = show["pic"] as! String
                                url = formatURL(url)
                                self.sendURL = url
                                setShowImage(url)
                            }
                        }
                    }
                      
                    //not a talk show
                    else {
                        
                        //playing a song
                        if let nowplaying = parsed["nowplaying"] as? NSDictionary{
                            
                            //nowplaying is a song
                            if nowplaying["trackid"] as! String != "" {
                                self.talkShowLabel.text! = "SONG NAME"
                                self.talkShowDJsLabel.text! = "ARTIST"
                                self.djsHide.isHidden = false
                                self.showNameHide.isHidden = false
                                self.showLabel.isHidden = false
                                self.djsLabel.isHidden = false
                                
                                if let songName = nowplaying["track"]{
                                    self.songLabel.text! = songName as! String
                                }
                                
                                let songURL = nowplaying["img100"] as! String
                                setSongImage(songURL)
                                
                                
                                if let artist = nowplaying["artist"] {
                                    self.artistLabel.text! = artist as! String
                                }
                                
                                
                                if let showName = show["showname"]{
                                    self.showLabel.text! = showName as! String
                                    self.showN = showName as! String
                                }
                                
                                if let djs = show["djs"] {
                                    self.djsLabel.text! = djs as! String
                                }
                                
                                if let _ = show["description"] {
                                    self.showDescrip = show["description"] as! String
                                }
                                
                                if let t = show["showtime"] {
                                    self.time = t as! String
                                }
                                
                                if let _ = show["genre"] {
                                    self.genre = show["genre"] as! String
                                }
                                
                                var url = show["pic"] as! String
                                url = formatURL(url)
                                self.sendURL = url
                                setShowImage(url)
                            }
                            
                            //nowplaying is a talk topic
                            else{
                                self.talkShowLabel.text! = "TOPIC"
                                self.talkShowDJsLabel.isHidden = true //talk topic doesn't have artist
                                self.djsHide.isHidden = false
                                self.showNameHide.isHidden = false
                                self.showLabel.isHidden = false
                                self.djsLabel.isHidden = true
                                self.sendButton.isHidden = true
                                
                                
                                if let topic = nowplaying["text"] {
                                    self.songLabel.text! = topic as! String
                                }
                                
                                if let showName = show["showname"]{
                                    self.showLabel.text! = showName as! String
                                    self.showN = showName as! String
                                }
                                
                                if let djs = show["djs"] {
                                    self.djsLabel.text! = djs as! String
                                }
                                
                                if let t = show["showtime"] {
                                    self.time = t as! String
                                }
                                
                                if let _ = show["genre"] {
                                    self.genre = show["genre"] as! String
                                }
                                
                                var url = show["pic"] as! String
                                url = formatURL(url)
                                self.sendURL = url
                                setShowImage(url)
                            }
                            

                        }
                        
                        //not currently playing song
                        else {
                            //put in song spot
                            self.talkShowLabel.text! = "SHOW NAME"
                            self.talkShowDJsLabel.text! = "DJS"
                            self.djsHide.isHidden = true
                            self.showNameHide.isHidden = true
                            self.showLabel.isHidden = true
                            self.djsLabel.isHidden = true
                            
                            if let _ = show["genre"] {
                                self.genre = show["genre"] as! String
                            }
                            
                            if let showName = show["showname"]{
                                self.songLabel.text! = showName as! String
                                self.showN = showName as! String
                            }
                            
                            if let djs = show["djs"] {
                                self.artistLabel.text! = djs as! String
                            }
                            
                            if let t = show["showtime"] {
                                self.time = t as! String
                            }
                            
                            
                            var url = show["pic"] as! String
                            self.sendURL = formatURL(url)
                            url = "http://" + formatURL(url)
                            //because in the place of song not show
                            setSongImage(url)
                        }
                    }
                }

            }
            
            // id == 0, no show is on
            else{
                self.nothingLabel.isHidden = false
                
                self.sendButton.isHidden = true
                self.detailButton.isHidden = true
                self.djsHide.isHidden = true
                self.showNameHide.isHidden = true
                self.showLabel.isHidden = true
                self.djsLabel.isHidden = true
                self.showImageView.isHidden = true
                self.songImageView.isHidden = true
                self.songLabel.isHidden = true
                self.artistLabel.isHidden = true
                self.talkShowDJsLabel.isHidden = true
                self.talkShowLabel.isHidden = true
                self.volumeButton.isHidden = true
                self.muteButton.isHidden = true
            }
        }//end of didLoad
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getJSON(_ urlToRequest: String) -> Data {
        return (try! Data(contentsOf: URL(string: urlToRequest)!))
    }
    
    
    func parseJSON(_ input : Data) -> NSDictionary{
        
        var dictionary : NSDictionary = [:]
        
        do{
            dictionary = try JSONSerialization.jsonObject(with: input, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            return dictionary
        } catch {
            
        }
        
        return dictionary
    }
    
    
    
    func setSongImage(_ url: String) ->() {
        if let imageURL = URL(string: url){
            self.songImageView.contentMode = .scaleAspectFit
            if let data = try? Data(contentsOf: imageURL){
                self.songImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    func setShowImage(_ url: String) ->() {
        if let imageURL = URL(string: "http://"+url){
            self.showImageView.contentMode = .scaleAspectFit
            if let data = try? Data(contentsOf: imageURL){
                self.showImageView.image = UIImage(data: data)
            }
        }
    }
    
    //removes extra characters added to URL at beginning and end from JSON
    func formatURL(_ old: String) -> String {
        var new = old.substring(with: Range<String.Index>(old.startIndex..<old.characters.index(old.endIndex, offsetBy: -11)))
        new = new.substring(with: Range<String.Index>(new.characters.index(new.startIndex, offsetBy: 2)..<new.endIndex))
        
        return new
    }
    
    
    //in viewDidLoad, set up AVPlayer
    func configureView() {
        let url = "https://chapmanradio.com/stream/listen/iTunes.m3u"
        self.player = AVPlayer(url:URL(string: url)!)
        player.rate = 1.0
        player.volume = 1.0
        player.play()
    }
    
    @IBAction func hitMute(_ sender: AnyObject) {
        muteButton.isHidden = true
        volumeButton.isHidden = false
        
        player.isMuted = true
    }
    
    @IBAction func hitForVolume(_ sender: AnyObject) {
        muteButton.isHidden = false
        volumeButton.isHidden = true
        
        player.isMuted = false
    }

    
    @IBAction func goShow(_ sender: AnyObject) {
        let navVC = self.storyboard!.instantiateViewController(withIdentifier: "show_view") as! UINavigationController
        
        let showVC = navVC.viewControllers[0] as! ShowViewController
        showVC.descFromMain = self.showDescrip
        showVC.genre = self.genre
        showVC.nameMain = self.showN
        showVC.time = self.time
        showVC.urlMain = self.sendURL
        
        self.present(navVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goSchedule(_ sender: AnyObject) {
        let navVC = self.storyboard!.instantiateViewController(withIdentifier: "schedule_view") as! UINavigationController
        
        self.present(navVC, animated: true, completion: nil)
    }
    
    
    //hidden for:
    //talk show topics under nowplaying
    //no show is on
    @IBAction func sendEmail(_ sender: AnyObject) {
        
        var message = "<p><b>Show: </b>"+showLabel.text! + "</p><p><b> DJs: </b>"+djsLabel.text!
        message += "</p><p><b>Song: </b>"+songLabel.text! + "</p><p><b>Artist: </b>"+artistLabel.text!+"</p>"
        message += "<p><a href=\"http://www.chapmanradio.com/home\">Visit Chapman Radio</a>"
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Check out what's playing on Chapman Radio")
            mail.setMessageBody(message, isHTML: true)
            
            present(mail, animated: true, completion: nil)
        }
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

