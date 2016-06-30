//
//  ResetPasswordViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 30/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var confirmPwdTxt: UITextField!
    @IBOutlet weak var newPwdTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //MARK:- Change Password Button
    
    @IBAction func resetPwd(sender: UIButton) {
       
        if newPwdTxt.text == "" || confirmPwdTxt.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message:
                "Please fill the required field", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if newPwdTxt.text != confirmPwdTxt.text
        {
            let alertController = UIAlertController(title: "Alert", message:
                "Password and Confirm Password does not match", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            ResetPwdApi()
        }
    }
    
    //MARK:- BACK Button
    
    @IBAction func backBtn(sender: UIButton)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    //MARK:- Reset Password
    func ResetPwdApi()
    {
        if !MyReachability.isConnectedToNetwork()
        {
            
            let alertController = UIAlertController(title: "Alert", message:
                "Network Connection Failed ", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            progressHUD.label.text = "Loading..."
            
            let userID =  NSUserDefaults.standardUserDefaults().valueForKey("user_Id") as? String
            let par = NSString(format: "/%@/%@",newPwdTxt.text!,userID!)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/update_password\(par)")!)
            
            request.HTTPMethod = "GET"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    let dict :NSDictionary?
                    do
                    {
                        dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                        print("ASynchronous\(dict)")
                        
                        
                        let success = dict?.valueForKey("success") as! NSString
                        if success == "true"
                            
                        {
                            progressHUD.hideAnimated(true)
                            let specialDeals = self.storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                            self.navigationController?.pushViewController(specialDeals, animated: true)
                        }
                        else
                        {
                            progressHUD.hideAnimated(true)
                            let message = dict?.valueForKey("message") as! String
                            let messageAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            messageAlert.addAction(defaultAction)
                            self.presentViewController(messageAlert, animated: true, completion: nil)
                        }
                    }
                    catch let error as NSError
                    {
                        progressHUD.hideAnimated(true)
                        print(error.localizedDescription)
                        let messageAlert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        messageAlert.addAction(defaultAction)
                        self.presentViewController(messageAlert, animated: true, completion: nil)
                    }
                })
            })
            
            task.resume()
        }
    }

}
