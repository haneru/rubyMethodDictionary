//
//  choiceModuleViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit
import GoogleMobileAds

class choiceModuleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate{
    
    var selectedIndex = -1
    
    var classArray = [String]()
    
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
                admobRequest.testDevices = ["539680c1269c77bd2123b573469fbcca"]
            }
            
        }
        
        admobView.load(admobRequest)
        
        self.view.addSubview(admobView)
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let jsondata = try? Data(contentsOf: URL(fileURLWithPath: path!))
        
        let jsonArray = (try!JSONSerialization.jsonObject(with: jsondata!, options: [])) as! NSArray
        classArray = jsonArray as! [String] 

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel!.text = "\(classArray[indexPath.row])"
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        cell.textLabel!.textColor = UIColor(red:1.0,green:0.3,blue:0.3,alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "MethodSegue", sender: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MethodSegue" {
        let choiceMethodVC = segue.destination as! choiceMethodViewController
            choiceMethodVC.className = classArray[selectedIndex] as! String
        }
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
