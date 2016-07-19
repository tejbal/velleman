//
//  AddressViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var countryHighlightedView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var stateHighlightedView: UIView!
    @IBOutlet weak var zipcodeHighlightedView: UIView!
    @IBOutlet weak var cityHighlightedView: UIView!
    @IBOutlet weak var addressLine2HighlightedView: UIView!
    @IBOutlet weak var addressHighlightedView: UIView!
    @IBOutlet weak var lastNameHighlightedView: UIView!
    @IBOutlet weak var firstNameHighlightedView: UIView!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var addressLine2: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var nextOutletBtn: UIButton!
    @IBOutlet weak var paymentOutlet: UIButton!
    @IBOutlet weak var orderOutlet: UIButton!
    @IBOutlet weak var addressOutlet: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    
    var addresData = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            headerLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
        }
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerImage.image = UIImage(named: "greenHeader")
            saveBtn.backgroundColor = ColorTheme().theme()
        }
        
    }

    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK :- Next Button
    
    @IBAction func nextButton(sender: AnyObject)
    {
//        let orderVC = self.storyboard?.instantiateViewControllerWithIdentifier("OrderViewController")  as! OrderViewController
//        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    //MARK:- Back Button
    
    
    
    @IBAction func backBtn(sender: UIButton)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBtn (sender: UIButton)
    {
        if firstName.text != "" || lastname.text != "" || address.text != "" || addressLine2.text != "" || city.text != "" ||  zipcode.text != "" ||
        state.text != "" || country.text != ""
        {
         if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
            {
           addAddressApi()
            }
            
            else
        {
        let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "Please Login or register first!", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
        }
        let loginAction: UIAlertAction = UIAlertAction(title: "Login", style: .Default) { action -> Void in
            
            
            let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            
            self.navigationController?.pushViewController(loginVc, animated: false)
            
        }
        let signupAction: UIAlertAction = UIAlertAction(title: "Register", style: .Default) { action -> Void in
            
            let SignUp = self.storyboard?.instantiateViewControllerWithIdentifier("businessSignUp") as! BusinessSignUpViewController
            SignUp.signUpBool = false
            
            self.navigationController?.pushViewController(SignUp, animated: false)
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(loginAction)
        actionSheetController.addAction(signupAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)

    }
        }
        else
        {
           let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "All text fields Are mandotry"
            alert.addButtonWithTitle("ok")
            alert.show()
        }
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        let backGroundColor = ColorTheme()
        
//        if textField == firstName
//        {
//            firstNameHighlightedView.backgroundColor = backGroundColor.theme()
//        }
//        if textField == lastname
//        {
//            lastNameHighlightedView.backgroundColor = backGroundColor.theme()
//        }
//        if textField == address
//        {
//            addressHighlightedView.backgroundColor = backGroundColor.theme()
//        }
//        if textField  ==  addressLine2
//        {
//             addressLine2HighlightedView.backgroundColor = backGroundColor.theme()
//        }
//         if textField == zipcode
//        {
//            zipcodeHighlightedView.backgroundColor = backGroundColor.theme()
//        }
//        if textField ==  country
//        {
//             countryHighlightedView.backgroundColor = backGroundColor.theme()
//        }
//        if textField ==  state
//        {
//            stateHighlightedView.backgroundColor = backGroundColor.theme()
//        }
//        if textField == city
//        {
//            cityHighlightedView.backgroundColor = backGroundColor.theme()
//        }
        return true
    }
    
    //MARK:- Add New Address Button
    
    @IBAction func backButton(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func addNewAddressbtn(sender: AnyObject)
    {
        let addressList = self.storyboard?.instantiateViewControllerWithIdentifier("AddressListViewController") as! AddressListViewController
        self.navigationController?.pushViewController(addressList, animated: true)
        
    }
    
    //MARK:- Add AddressApi
    func addAddressApi()
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
            let par = NSString(format: "first_name=%@&last_name=%@&address_1=%@&address_2=%@&city=%@&zipcode=%@&state=%@&country=%@&user_id=%@",firstName.text!,lastname.text!,address.text!,addressLine2.text!,city.text!,zipcode.text!,state.text!,country.text!,userID!)
            
            print(par)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/save_user_address")!)
            
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
                            
                            self.navigationController?.popViewControllerAnimated(true)
                            
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
