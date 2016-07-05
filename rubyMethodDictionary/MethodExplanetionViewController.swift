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
    
    @IBOutlet weak var nameLavel: UILabel!
    
    @IBOutlet weak var detailText: UITextView!
    
    override func viewDidLoad() {
    }
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        nameLavel.text = methodName
        detailText.text = methodText
        var addDomain:String = NSBundle.mainBundle().bundleIdentifier!
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        if myDefault.objectForKey("bookMarkList") != nil{
            bookMarkList = myDefault.objectForKey("bookMarkList")as! [Dictionary]
            
            //  myDefault.removePersistentDomainForName(addDomain)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bookBtn(sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "BookMark", message: "保存してもいいですか？", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{
            (action: UIAlertAction!) -> Void in
            self.bookMarkList.append(["class":self.methodClass,"name":self.methodName,"detail":self.methodText])
            print(self.bookMarkList)
            //        UserDefaultに保存
            var myDefault = NSUserDefaults.standardUserDefaults()
            //        データを書き込んで
            myDefault.setObject(self.bookMarkList, forKey: "bookMarkList")
            //        即反映させる
            myDefault.synchronize()

        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        presentViewController(alert, animated: true, completion: nil)
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
