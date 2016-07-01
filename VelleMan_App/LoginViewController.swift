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

    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var userTxtField: UITextField!
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
        if (userTxtField.text!.isEmpty || pwdTxtField.text!.isEmpty)
        {
            let alert=UIAlertController(title: "Alert", message: "Please enter rquired fields", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            presentViewController(alert, animated: true, completion: nil);

        }
        else
        {
           Loginapi()
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
   
    
    func Loginapi()
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
            let par = NSString(format: "/%@/%@",userTxtField.text!,pwdTxtField.text!)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/login_user\(par)")!)
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
                            
                            let result = dict?.valueForKey("user") as! NSDictionary
                            let HomeBusiness = result.valueForKey("type") as! String
                            
                            let User_Id = result.valueForKey("user_id") as! String
                            NSUserDefaults.standardUserDefaults().setObject(User_Id, forKey: "user_Id")

                            let specialDeals = self.storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginHomeBusiness")
                            if (HomeBusiness == "business"){
                                 NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isHome")
                            }
                           
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

    
}

