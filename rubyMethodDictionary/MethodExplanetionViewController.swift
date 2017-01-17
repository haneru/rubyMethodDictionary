//
//  MethodExplanetionViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MethodExplanetionViewController: UIViewController ,GADBannerViewDelegate{

    var methodClass:String!
    
    var methodName:String!
    
    var methodText:String!
    
    var bookMarkList:[Dictionary<String,String>] = []
    
    var HistoryList:[Dictionary<String,String>] = []
    
    var contentOffset = CGPoint.zero
    
    let AdMobID = "ca-app-pub-3530000000000000/0123456789"
    let TEST_DEVICE_ID = "61b0154xxxxxxxxxxxxxxxxxxxxxxxe0"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = true

    
    @IBOutlet weak var nameLavel: UILabel!
    
    @IBOutlet weak var detailText: UITextView!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        広告実装
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

        
        
//        ユーザーデフォルト
        var addDomain:String = Bundle.main.bundleIdentifier!
        
        var myDefault = UserDefaults.standard
        
        if myDefault.object(forKey: "HistoryList") != nil{
            HistoryList = myDefault.object(forKey: "HistoryList")as!  [Dictionary]
            HistoryList.append(["class":methodClass! as String,"name":methodName! ,"detail":methodText! ])
        }
        
        if myDefault.object(forKey: "bookMarkList") != nil{
            bookMarkList = myDefault.object(forKey: "bookMarkList")as! [Dictionary]
            //            myDefault.removePersistentDomainForName(addDomain)
        }
        
        for value in bookMarkList {
            if value == ["class":self.methodClass,"name":self.methodName,"detail":self.methodText] {
                favoriteImage.image = UIImage(named: "Star Filled-50.png")
                break
            }else{
                favoriteImage.image = UIImage(named: "Star-50.png")
            }
            
        }
        if bookMarkList.isEmpty{
            self.favoriteImage.image = UIImage(named: "Star-50.png")
            
        }
        
        myDefault.set(self.HistoryList, forKey: "HistoryList")
        myDefault.synchronize()
            
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        nameLavel.text = methodName
        detailText.text = methodText
        // Do any additional setup after loading the view.
    }
    @IBAction func tapFavorite(_ sender: UITapGestureRecognizer) {
        if self.favoriteImage.image == UIImage(named: "Star-50.png"){
            self.bookMarkList.append(["class":self.methodClass!,"name":self.methodName!,"detail":self.methodText!])
            favoriteImage.image = UIImage(named: "Star Filled-50.png")
        }else{
            self.favoriteImage.image = UIImage(named: "Star-50.png")
            var i = 0
            for value in self.bookMarkList{
                if value == ["class":"\(methodClass!)","name":"\(methodName!)","detail":"\(methodText!)"]{
                    self.bookMarkList.remove(at: i)
                    break
                }
                i += 1
            }
        }
//        print(self.bookMarkList)
        //        UserDefaultに保存
        let myDefault = UserDefaults.standard
        //        データを書き込んで
        myDefault.set(self.bookMarkList, forKey: "bookMarkList")
        //        即反映させる
        myDefault.synchronize()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailText.contentOffset = contentOffset //set
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentOffset = detailText.contentOffset //keep
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
