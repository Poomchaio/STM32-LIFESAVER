//
//  ViewController.swift
//  HW_SYN_LAB
//
//  Created by Poomchai Taechaprapasrat on 12/14/2560 BE.
//  Copyright © 2560 Poomchai Taechaprapasrat. All rights reserved.
//

import UIKit
import PusherSwift
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    
    @IBAction func clear(_ sender: Any) {
        for i in str{
            str.remove(at: 0)
            color.remove(at: 0)
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var pusher: Pusher!
    var str = [Date]()
    var color = [Bool]()
    var redCell = "RedCell"
    var greenCell = "GreenCell"
    var channel = ["channel1"]
    var event = ["event1","even2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: redCell, bundle: nil), forCellReuseIdentifier: redCell)
        tableView.register(UINib(nibName: greenCell, bundle: nil), forCellReuseIdentifier: greenCell)

        let options = PusherClientOptions(
            host: .cluster("ap1")
        )
        
        pusher = Pusher(
            key: "473c50678fde7578a7d7",
            options: options
        )
        
        // subscribe to channel and bind to event
        let channel = pusher.subscribe("my-channel")
        
        for i in 0...2 {
            let _ = channel.bind(eventName: "event\(i)", callback: { (data: Any?) -> Void in
                if let data = data as? [String : AnyObject] {
                    if let message = data["message"] as? String {
                        if message == "help"{
                            self.color.insert(false, at: 0)
                            self.str.insert(Date(), at: 0)
                            self.tableView.reloadData()
                            print(message)
                        }
                        else{
                            if(self.color.count > 0){
                                self.color.remove(at: 0)
                                self.color.insert(true, at: 0)
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    }
                }
            })
        }
        
//        let _ = channel.bind(eventName: "event2", callback: { (data: Any?) -> Void in
//            if let data = data as? [String : AnyObject] {
//                if let message = data["message"] as? String {
//                    self.color.remove(at: 0)
//                                        self.color.insert(true, at: 0)
//                                        self.tableView.reloadData()
//                }
//            }
//        })
//        let channel2 = pusher.subscribe("channel")
//        let _ = channel2.bind(eventName: "event", callback: { (data: Any?) -> Void in
//            if let data = data as? [String : AnyObject] {
//                if let message = data["message"] as? String {
//
////                    self.color.remove(at: 0)
////                    self.color.insert(true, at: 0)
////                    self.tableView.reloadData()
//
//                }
//            }
//        })
        pusher.connect()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if color[indexPath.row] == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: redCell, for: indexPath) as? RedCell
            cell?.date.text = String(dateToString(date: str[indexPath.row]))
            //String(dateToString(date: str[indexPath.row]))
            
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: greenCell, for: indexPath) as? GreenCell
            cell?.date.text = String(dateToString(date: str[indexPath.row]))
            //String(dateToString(date: str[indexPath.row]))
            
            return cell!
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }

}

