//
//  choiceMethodViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit

class choiceMethodViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var className: String!
    
    var methodArray = []

    @IBOutlet weak var quesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        quesLabel.text = "\(className)のどんな処理？"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        var path = NSBundle.mainBundle().pathForResource("\(className)json", ofType: "txt")
        var jsondata = NSData(contentsOfFile: path!)
        
        let jsonArray = (try!NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
        methodArray = jsonArray
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methodArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel!.text = "\(methodArray[indexPath.row])"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: nil)
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
