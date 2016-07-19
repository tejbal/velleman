//
//  VerificationCodeViewController.swift
//  VelleMan_App
//
//  Created by Jarvics  on 22/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UIViewController {
    @IBOutlet weak var confirmationCodeTxtField: UITextField!
    @IBOutlet weak var messegLbl: UILabel!

    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    var mobileNumber = NSString()
    var tokenNumber = NSString()
    var countDownTimer : NSTimer = NSTimer()
    var timer = 59
    var type = NSString()
    var isHome = NSString()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        messegLbl.text = "Please Enter verification code sent to\(mobileNumber)"
        resendCodeBtn.enabled = false
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFunction", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func timerFunction()
    {
        if timer > 0
        {
            if timer < 10
            {
                let str = String(timer--)
                
                timerLbl.text = "Resend Code in 00:0\(str)"
            }
            else
            {
                let str = String(timer--)
                
                timerLbl.text = "Resend Code in 00:\(str)"
            }
            
            
        }
        else
        {
            timerLbl.text = ""
            countDownTimer.invalidate()
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resendCodeAction(sender: AnyObject)
    {
        forgetPwdApi()
    }
    
    
    @IBAction func submitBtnAction(sender: AnyObject)
    {
        if confirmationCodeTxtField.text == tokenNumber
        {
            if isHome == "S"
            {
                emailVerifiedApi()
            }
            else if isHome == "F"
            {
               let resetPwd = storyboard?.instantiateViewControllerWithIdentifier("resetPwd") as! ResetPasswordViewController
                self.navigationController?.pushViewController(resetPwd, animated: true)
            }
            else
            {
                registerPhone()
            }
        }
        else
        {
            let alertController = UIAlertController(title: "Alert", message:
                "Please enter correct Verification code", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    //MARK:- Resend Token
    func forgetPwdApi()
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
            let par = NSString(format: "/%@",mobileNumber)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/send_forgot_token\(par)")!)
            
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
                            let token = dict?.valueForKey("token") as! String
                            self.tokenNumber = token
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

//MARK:- Back Button
    
    @IBAction func backBtn(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- EmailVerification Api
    func emailVerifiedApi()
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
            let par = NSString(format: "/%@",userID!)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/verify_email\(par)")!)
            
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
                            if (self.type == "business"){
                                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isHome")
                            }
                            
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginHomeBusiness")
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
                    }
                })
            })
            
            task.resume()
        }
 
    }
    
    //MARK:- Register Phone
    func registerPhone()
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
            
            
            let par = NSString(format: "type=%@&phone=%@",type,mobileNumber)
            
            print(par)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/register_phone")!)
            
            request.HTTPMethod = "POST"
            let getdata = par.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
            request.HTTPBody = getdata
            let queue:NSOperationQueue! = NSOperationQueue()
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    let dict :NSDictionary?
                    do
                    {
                        dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                        
                        print("ASynchronous\(dict)")
                        let success = dict?.valueForKey("success") as! NSString
                        if success == "true"
                            
                        {
                            progressHUD.hideAnimated(true)
                            progressHUD.hidden = true
                           
                            let specialDeals = self.storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                            if (self.type == "business"){
                                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isHome")
                            }
                            
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginHomeBusiness")
                            self.navigationController?.pushViewController(specialDeals, animated: true)
                                                      
                        }
                        else
                        {
                            
                            progressHUD.hideAnimated(true)
                            progressHUD.hidden = true
                            
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
                        progressHUD.hidden = true
                        print(error.localizedDescription)
                    }
                })
            })
        }
    

    }
    
}
