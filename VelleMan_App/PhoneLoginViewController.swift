//
//  PhoneLoginViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 31/05/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit


class PhoneLoginViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mobileTxtField: UITextField!
    
    @IBOutlet weak var homebtn: UIButton!
    
    @IBOutlet weak var businessBtn: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK:- Back Button
    @IBAction func backbtn(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- Submit Button
    
    @IBAction func submitBtn(sender: AnyObject)
    {
        mobileTxtField.text = mobileTxtField.text?.stringByReplacingOccurrencesOfString(" ", withString:"")
        
        if mobileTxtField.text == ""
        {
            let alertController = UIAlertController(title: "Alert", message:"Please Enter Your Mobile Number To Login", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: .None))
            self.presentViewController(alertController, animated: true, completion: .None)
        }
        else if mobileTxtField.text?.characters.count < 10
        {
            let alertController = UIAlertController(title: "Alert", message:"Please Enter Valid Mobile Number", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: .None))
            self.presentViewController(alertController, animated: true, completion: .None)
        }
        else if !(homebtn.selected || businessBtn.selected)
        {
            let alertController = UIAlertController(title: "Alert", message:"Please Select the one type", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: .None))
            self.presentViewController(alertController, animated: true, completion: .None)
        }
        else
        {
            phoneLoginApi()
        }
        
    
    
}

//MARK:-Radio Button

@IBAction func businessBtn(sender: UIButton) {
    if businessBtn.selected
    {
        businessBtn.selected = false
    }
    else
    {
        homebtn.selected = false
        
        businessBtn.selected = true
    }
    
}

@IBAction func homeBtn(sender: UIButton) {
    if homebtn.selected
    {
        homebtn.selected = false
    }
    else
    {
        homebtn.selected = true
        businessBtn.selected = false
    }
}

//MARK:- PhoneLogin Api
func phoneLoginApi()
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
        let par = NSString(format: "/%@",mobileTxtField.text!)
        
        let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/send_verification_token\(par)")!)
        
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
                        let verificationCode = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationCodeViewController") as! VerificationCodeViewController
                        verificationCode.mobileNumber = self.mobileTxtField.text!
                        verificationCode.tokenNumber = token
                        verificationCode.isHome = "P"
                        
                        if self.businessBtn.selected
                        {
                            verificationCode.type = "business"
                        }
                        else
                        {
                            verificationCode.type = "home"
                        }
                        self.navigationController?.pushViewController(verificationCode, animated: true)
                        
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
