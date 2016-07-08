//
//  HistoryViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/08.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var HistoryTableView: UITableView!

    var HistoryList = [["class":"","name":"","detail":""]]
    
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        var addDomain:String = NSBundle.mainBundle().bundleIdentifier!
        
        var myDefault = NSUserDefaults.standardUserDefaults()
            HistoryList = myDefault.objectForKey("HistoryList")as! [Dictionary]
        //          myDefault.removePersistentDomainForName(addDomain)
        HistoryList = HistoryList.reverse()
        HistoryTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistoryList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         var cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        if HistoryList[indexPath.row]["class"] != ""{
        cell.textLabel?.text = "class:\(HistoryList[indexPath.row]["class"]as! String!),name:\(HistoryList[indexPath.row]["name"] as! String!)"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        if HistoryList[indexPath.row]["class"] != "" && HistoryList[indexPath.row]["name"] != ""{
            performSegueWithIdentifier("HistorySegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HistorySegue" {
            var BookMarkDetailVC = segue.destinationViewController as! MethodExplanetionViewController
            BookMarkDetailVC.methodClass = HistoryList[selectedIndex]["class"] as! String!
            BookMarkDetailVC.methodName = HistoryList[selectedIndex]["name"] as! String!
            BookMarkDetailVC.methodText = HistoryList[selectedIndex]["detail"]
                as! String!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
