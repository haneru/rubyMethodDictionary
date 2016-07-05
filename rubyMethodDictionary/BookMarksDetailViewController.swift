//
//  BookMarksDetailViewController.swift
//  rubyMethodDictionary
//
//  Created by haneru on 2016/07/03.
//  Copyright © 2016年 haneru. All rights reserved.
//

import UIKit

class BookMarksDetailViewController: UIViewController {

    var methodClass:String!
    
    var methodName:String!
    
    var methodText:String!
    
    @IBOutlet weak var detailText: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = methodName
        
        detailText.text = methodText
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func swipeRigjt(sender: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
