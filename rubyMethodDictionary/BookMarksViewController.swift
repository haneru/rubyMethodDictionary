//
//  BookMarksViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BookMarksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,GADBannerViewDelegate{

    var bookMarkList:[Dictionary<String,String>] = []
    
    var selectedIndex = -1
    
    let AdMobID = "ca-app-pub-3530000000000000/0123456789"
    let TEST_DEVICE_ID = "61b0154xxxxxxxxxxxxxxxxxxxxxxxe0"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = true

    
    @IBOutlet weak var BookMarksTableView: UITableView!
    override func viewDidLoad() {
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
                admobRequest.testDevices = ["539680c1269c77bd2123b573469fbcca" ]
            }
            
        }
        
        admobView.load(admobRequest)
        
        self.view.addSubview(admobView)

        // Do any additional setup after loading the view.
    }
    @IBAction func allDelete(_ sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "AllDelete", message: "全部をBookMarkから削除しますか？？", preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.bookMarkList = []
            //        UserDefaultに保存
            var myDefault = UserDefaults.standard
            //        データを書き込んで
            myDefault.set(self.bookMarkList, forKey: "bookMarkList")
            //        即反映させる
            myDefault.synchronize()
            
            self.BookMarksTableView.reloadData()
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        var addDomain:String = Bundle.main.bundleIdentifier!
        
        var myDefault = UserDefaults.standard
        if myDefault.object(forKey: "bookMarkList") != nil{
            bookMarkList = myDefault.object(forKey: "bookMarkList")as! [Dictionary]
        }
//          myDefault.removePersistentDomainForName(addDomain)
        BookMarksTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if bookMarkList[indexPath.row]["class"] != "" && bookMarkList[indexPath.row]["name"] != ""{
            cell.textLabel!.text = "Class:\(bookMarkList[indexPath.row]["class"]!),Method:\(bookMarkList[indexPath.row]["name"]!)"
        }
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        cell.textLabel!.textColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if bookMarkList[indexPath.row]["class"] != "" && bookMarkList[indexPath.row]["name"] != ""{
        performSegue(withIdentifier: "bookmarkMethodSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookmarkMethodSegue" {
            var BookMarkDetailVC = segue.destination as! MethodExplanetionViewController
            BookMarkDetailVC.methodClass = bookMarkList[selectedIndex]["class"] as! String!
            BookMarkDetailVC.methodName = bookMarkList[selectedIndex]["name"] as! String!
            BookMarkDetailVC.methodText = bookMarkList[selectedIndex]["detail"]
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
