//
//  ChangePassword.swift
//  VelleMan_App
//
//  Created by Jarvics  on 23/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {

    @IBOutlet weak var changePwdBtn: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var confirmPwdField: UITextField!
    @IBOutlet weak var newPwdField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        changePwdBtn.backgroundColor = ColorTheme().theme()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerImage.image = UIImage(named: "greenHeader")
            changePwdBtn.backgroundColor = ColorTheme().theme()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changePasswordBtn(sender: AnyObject)
    {
        
        var message  = ""
        var isError = false
        if oldPasswordField.text == "" || newPwdField.text == "" || confirmPwdField.text == ""
        {
            message = "All fields Are mandatory"
            isError = true
        }
            
        else if newPwdField.text?.characters.count < 6
        {
            isError = true
        
            message = "Please enter strong password"
        }
            
        else
            
        {
            if newPwdField.text != confirmPwdField.text
            {
                isError = true
                message = "new password and confirm assword does not match"
            }
            else
            {
                print("password changed")
            }
        }
        
        if isError == true
        {
            let UIAlert = AlertClass()
            
            let alertMessage = UIAlert.alert("Alert", message: message, buttonTitle:"ok")
            
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        else
        {
            changePwdApi()
        }
        
        
    }
    
    @IBAction func backBtn(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)

    }
   
    //MARK:- Change Password
    func changePwdApi()
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
                let par = NSString(format: "/%@/%@/%@",userID!,oldPasswordField.text!,newPwdField.text!)
                
                let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/change_password\(par)")!)
                
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
                                let message = dict?.valueForKey("message") as! String
                                let messageAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                                messageAlert.addAction(defaultAction)
                                self.presentViewController(messageAlert, animated: true, completion: nil)
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
                        }
                    })
                })
                
                task.resume()
            }
        
    }
    
}
