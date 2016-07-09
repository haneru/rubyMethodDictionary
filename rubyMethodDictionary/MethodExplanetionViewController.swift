//
//  MethodExplanetionViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit

class MethodExplanetionViewController: UIViewController {

    var methodClass:String!
    
    var methodName:String!
    
    var methodText:String!
    
    var bookMarkList = [["class":"","name":"","detail":""]]
    
    var HistoryList = [["class":"","name":"","detail":""]]
    
    @IBOutlet weak var nameLavel: UILabel!
    
    @IBOutlet weak var detailText: UITextView!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var addDomain:String = NSBundle.mainBundle().bundleIdentifier!
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        if myDefault.objectForKey("HistoryList") != nil{
            HistoryList = myDefault.objectForKey("HistoryList")as!  [Dictionary]
            HistoryList.append(["class":methodClass as String,"name":methodName ,"detail":methodText ])
        }
        
        if myDefault.objectForKey("bookMarkList") != nil{
            bookMarkList = myDefault.objectForKey("bookMarkList")as! [Dictionary]
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
        
        myDefault.setObject(self.HistoryList, forKey: "HistoryList")
        myDefault.synchronize()
            
    }
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        nameLavel.text = methodName
        detailText.text = methodText
        // Do any additional setup after loading the view.
    }
    @IBAction func tapFavorite(sender: UITapGestureRecognizer) {
        if self.favoriteImage.image == UIImage(named: "Star-50.png"){
            self.bookMarkList.append(["class":self.methodClass,"name":self.methodName,"detail":self.methodText])
            favoriteImage.image = UIImage(named: "Star Filled-50.png")
        }else{
            self.favoriteImage.image = UIImage(named: "Star-50.png")
            var i = 0
            for value in self.bookMarkList{
                if value == ["class":"\(methodClass)","name":"\(methodName)","detail":"\(methodText)"]{
                    self.bookMarkList.removeAtIndex(i)
                    break
                }
                i += 1
            }
        }
//        print(self.bookMarkList)
        //        UserDefaultに保存
        var myDefault = NSUserDefaults.standardUserDefaults()
        //        データを書き込んで
        myDefault.setObject(self.bookMarkList, forKey: "bookMarkList")
        //        即反映させる
        myDefault.synchronize()
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
