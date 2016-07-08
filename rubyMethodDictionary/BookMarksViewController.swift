//
//  BookMarksViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit

class BookMarksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var bookMarkList = [["class":"","name":"","detail":""]]
    
    var selectedIndex = -1
    
    @IBOutlet weak var BookMarksTableView: UITableView!
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
    }
    @IBAction func allDelete(sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "AllDelete", message: "全部をBookMarkから削除しますか？？", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{
            (action: UIAlertAction!) -> Void in
            self.bookMarkList = [["class":"","name":"","detail":""]]
            //        UserDefaultに保存
            var myDefault = NSUserDefaults.standardUserDefaults()
            //        データを書き込んで
            myDefault.setObject(self.bookMarkList, forKey: "bookMarkList")
            //        即反映させる
            myDefault.synchronize()
            
            self.BookMarksTableView.reloadData()
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        var addDomain:String = NSBundle.mainBundle().bundleIdentifier!
        
        var myDefault = NSUserDefaults.standardUserDefaults()
        if myDefault.objectForKey("bookMarkList") != nil{
            bookMarkList = myDefault.objectForKey("bookMarkList")as! [Dictionary]
        }
//          myDefault.removePersistentDomainForName(addDomain)
        BookMarksTableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarkList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel!.text = "Class:\(bookMarkList[indexPath.row]["class"] as! String!),Method:\(bookMarkList[indexPath.row]["name"] as! String!)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        if bookMarkList[indexPath.row]["class"] != "" && bookMarkList[indexPath.row]["name"] != ""{
        performSegueWithIdentifier("bookmarkMethodSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bookmarkMethodSegue" {
            var BookMarkDetailVC = segue.destinationViewController as! MethodExplanetionViewController
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
