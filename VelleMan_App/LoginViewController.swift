//
//  ViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 31/05/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameLbl: UILabel!

    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Business and Home Buttom Programmatically
        self.navigationController?.navigationBar.hidden = true
        
        businessBtn.setImage(UIImage(named: "RadioUncheckBtn"), forState:.Normal)
        businessBtn.setImage(UIImage(named: "RadioCheckBtn"), forState: .Selected)
        businessBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0.0, 0.0)
        businessBtn.setTitle("Business", forState:.Normal)
        businessBtn.imageView?.contentMode = .ScaleAspectFit
        
        homeBtn.setImage(UIImage(named: "RadioUncheckBtn"), forState:.Normal)
        homeBtn.setImage(UIImage(named: "RadioCheckBtn"), forState: .Selected)
        homeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0.0, 0.0)
        homeBtn.setTitle("Home", forState:.Normal)
        homeBtn.imageView?.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK:- Business and Home Button Action
    @IBAction func businessBtn(sender: AnyObject)
    {
        if businessBtn.selected
        {
            businessBtn.selected = false
        }
        else
        {
            businessBtn.selected = true
            homeBtn.selected = false
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isHome")
        } 
    }

    @IBAction func homeBtn(sender: AnyObject)
    {
        if homeBtn.selected
        {
            homeBtn.selected = false
        }
        else
        {
            homeBtn.selected = true
            businessBtn.selected = false
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isHome")
        }
    }
    //MARK:- Sign Up Button
     @IBAction func signUpBtn(sender: AnyObject)
    {
        
        let businessSignUp = storyboard?.instantiateViewControllerWithIdentifier("businessSignUp") as! BusinessSignUpViewController
        businessSignUp.signUpBool = false
        self.navigationController?.pushViewController(businessSignUp, animated: true)
        
    }
    
    //MARK:- LoginWithPhone Button
     @IBAction func LoginWithPhoneBtn(sender: AnyObject)
    {
        
        let phoneLogin = storyboard?.instantiateViewControllerWithIdentifier("phoneLogin") as! PhoneLoginViewController
        self.navigationController?.pushViewController(phoneLogin, animated: true)
    }
    
    //MARK:- Login Button
     @IBAction func loginBtn(sender: UIButton)
    {
        if homeBtn.selected || businessBtn.selected
        {
            let specialDeals = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
//            specialDeals.loginBool = true
            self.navigationController?.pushViewController(specialDeals, animated: true)
        }
        else
        {
            let alert=UIAlertController(title: "Alert", message: "Please Select the Business or Home", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            presentViewController(alert, animated: true, completion: nil);
        }
        
        
    }
    
    @IBAction func forgotPassword(sender: AnyObject)
    {
        let ForgetPWDVC = self.storyboard?.instantiateViewControllerWithIdentifier("ForgetPassword") as! ForgetPassword
        
        self.navigationController?.pushViewController(ForgetPWDVC, animated: true)
    }

    @IBAction func backtohomeBtn(sender: AnyObject)
    {
        let specialDeals = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
        self.navigationController?.pushViewController(specialDeals, animated: false)
    }
   
    
//    func api()
//    {
//        if !MyReachability.isConnectedToNetwork()
//        {
//            
//            let alertController = UIAlertController(title: "Alert", message:
//                "Network Connection Failed ", preferredStyle: UIAlertControllerStyle.Alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
//            
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//        else
//        {
//            let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            progressHUD.label.text = "Loading..."
//            
//            
//            let par = NSString(format: "username=%@&password=%@&email=%@&profile_pic=%@&phone=%@&address=%@&postcode=%@&company=%@&type=%@",userName.text!,pwdTxtField.text!,emailTxtField.text!,strBase64,phoneNoTxtField.text!,addressTxtField.text!,postCOdeTxtField.text!,companyTxtField.text!,userType)
//            
//            print(par)
//            
//            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/login_user/email_id_or_phone_number/password")!)
//            
//            request.HTTPMethod = "POST"
//            let getdata = par.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
//            request.HTTPBody = getdata
//            let queue:NSOperationQueue! = NSOperationQueue()
//            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//                dispatch_async(dispatch_get_main_queue(),{
//                    let dict :NSDictionary?
//                    do
//                    {
//                        dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
//                        
//                        print("ASynchronous\(dict)")
//                        let success = dict?.valueForKey("success") as! String
//                        print(success)
//                        if success == "True"
//                        {
//                            progressHUD.hideAnimated(true)
//                            progressHUD.hidden = true
//                            
//                            let result = dict?.valueForKey("result") as! NSDictionary
//                            print(result)
//                            let message = dict?.valueForKey("message") as! String
//                            
//                            let User_Id = result.valueForKey("id") as! String
//                            NSUserDefaults.standardUserDefaults().setObject(User_Id, forKey: "user_Id")
//                            
//                            
//                            
//                            
//                            let UIAlert = AlertClass()
//                            
//                            let alertMessage = UIAlert.alert("Success", message: message, buttonTitle:"ok")
//                            
//                            self.presentViewController(alertMessage, animated: true, completion: nil)
//                            
//                            let verificationView = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationCodeViewController") as! VerificationCodeViewController
//                            verificationView.mobileNumber = self.phoneNoTxtField.text!
//                            self.navigationController?.pushViewController(verificationView, animated: true)
//                            
//                            
//                        }
//                        else
//                        {
//                            
//                            progressHUD.hideAnimated(true)
//                            progressHUD.hidden = true
//                            
//                            let message = dict?.valueForKey("message") as! String
//                            
//                            let messageAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
//                            
//                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                            messageAlert.addAction(defaultAction)
//                            
//                            self.presentViewController(messageAlert, animated: true, completion: nil)
//                            
//                        }
//                        
//                    }
//                    catch let error as NSError
//                    {
//                        progressHUD.hideAnimated(true)
//                        progressHUD.hidden = true
//                        print(error.localizedDescription)
//                    }
//                })
//            })
//        }
//    }

    
}

