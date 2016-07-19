//
//  ForgetPassword.swift
//  VelleMan_App
//
//  Created by Jarvics  on 23/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class ForgetPassword: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var resertPwdBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resretPasswordBtn(sender: AnyObject) {
        if mobileNumberTextField.text!.isEmpty
        {
            
            let alertController = UIAlertController(title: "Alert", message:
                "Please enter mobile number or email", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            forgetPwdApi()
        }
    }

    @IBAction func backBtn(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- Forget Password Api
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
            let par = NSString(format: "/%@",mobileNumberTextField.text!)
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
                            let result = dict?.valueForKey("user") as! NSDictionary
                            let User_Id = result.valueForKey("user_id") as! String
                            NSUserDefaults.standardUserDefaults().setObject(User_Id, forKey: "user_Id")
                            let verificationView = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationCodeViewController") as! VerificationCodeViewController
                            verificationView.tokenNumber = token
                            verificationView.mobileNumber = self.mobileNumberTextField.text!
                            verificationView.isHome = "F"
                            self.navigationController?.pushViewController(verificationView, animated: true)
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
