//
//  HistoryViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/08.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,GADBannerViewDelegate{
    @IBOutlet weak var HistoryTableView: UITableView!

    var HistoryList:[Dictionary<String,String>] = []
    
    var selectedIndex = -1
    
    let AdMobID = "ca-app-pub-3530000000000000/0123456789"
    let TEST_DEVICE_ID = "61b0154xxxxxxxxxxxxxxxxxxxxxxxe0"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var admobView: GADBannerView = GADBannerView()
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        admobView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height - 44 - admobView.frame.height)
        
        admobView.frame.size = CGSize(width: self.view.frame.width, height: admobView.frame.height)
        admobView.adUnitID = AdMobID
        admobView.delegate = self
        admobView.rootViewController = self
        
        let admobRequest:GADRequest = GADRequest()
        
        if AdMobTest {
            if SimulatorTest {
                admobRequest.testDevices = [kGADSimulatorID]
            }
            else {
                admobRequest.testDevices = [TEST_DEVICE_ID]
            }
            
        }
        
        admobView.load(admobRequest)
        
        self.view.addSubview(admobView)


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var addDomain:String = Bundle.main.bundleIdentifier!
        
        var myDefault = UserDefaults.standard
        if myDefault.object(forKey: "HistoryList") != nil{
            HistoryList = myDefault.object(forKey: "HistoryList")as! [Dictionary]
        }
        //          myDefault.removePersistentDomainForName(addDomain)
        HistoryList = HistoryList.reversed()
        HistoryTableView.reloadData()
    }
    @IBAction func AllDeleteBtn(_ sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "AllDelete", message: "全部をHistoryから削除しますか？", preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.HistoryList = []
            //        UserDefaultに保存
            var myDefault = UserDefaults.standard
            //        データを書き込んで
            myDefault.set(self.HistoryList, forKey: "HistoryList")
            //        即反映させる
            myDefault.synchronize()
            
            self.HistoryTableView.reloadData()
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if HistoryList[indexPath.row]["class"] != ""{
        cell.textLabel?.text = "class:\(HistoryList[indexPath.row]["class"]as! String!),name:\(HistoryList[indexPath.row]["name"] as! String!)"
        }
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        cell.textLabel!.textColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if HistoryList[indexPath.row]["class"] != "" && HistoryList[indexPath.row]["name"] != ""{
            performSegue(withIdentifier: "HistorySegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistorySegue" {
            var HistoryDetailVC = segue.destination as! MethodExplanetionViewController
            HistoryDetailVC.methodClass = HistoryList[selectedIndex]["class"] as! String!
            HistoryDetailVC.methodName = HistoryList[selectedIndex]["name"] as! String!
            HistoryDetailVC.methodText = HistoryList[selectedIndex]["detail"]
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
