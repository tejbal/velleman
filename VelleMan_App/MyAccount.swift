//
//  myAccount.swift
//  VelleMan_App
//
//  Created by Jarvics  on 27/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class MyAccount: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

     @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var typ: UITextField!
    @IBOutlet weak var postcode: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var postCodeView: UIView!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var userProfileLine: UIView!
    @IBOutlet weak var pwdLine: UIView!
    @IBOutlet weak var emailLine: UIView!
    @IBOutlet weak var phoneNoLine: UIView!
    @IBOutlet weak var addressLine: UIView!
    @IBOutlet weak var typeLine: UIView!
    @IBOutlet weak var postCodeLine: UIView!
    @IBOutlet weak var companyLine: UIView!
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height / 2
        userProfileImage.layer.masksToBounds = true
         self.imagePicker.delegate = self
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, companyView.frame.origin.y + companyView.frame.size.height+5)
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerImage.image = UIImage(named: "greenHeader")
            userProfileLine.backgroundColor = ColorTheme().theme()
            pwdLine.backgroundColor = ColorTheme().theme()
            emailLine.backgroundColor = ColorTheme().theme()
            phoneNoLine.backgroundColor = ColorTheme().theme()
            addressLine.backgroundColor = ColorTheme().theme()
            typeLine.backgroundColor = ColorTheme().theme()
            postCodeLine.backgroundColor = ColorTheme().theme()
            companyLine.backgroundColor = ColorTheme().theme()
           
        }
        userName.enabled = false
        pwd.enabled = false
        email.enabled = false
        phoneNo.enabled = false
        address.enabled = false
        typ.enabled = false
        postcode.enabled = false
        company.enabled = false
        getUserProfileapi()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
    //MARK:- GetUserProfile Api
    func getUserProfileapi()
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
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_user_profile\(par)?\(arc4random_uniform(10000))")!)
            request.HTTPMethod = "GET"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in

                dispatch_async(dispatch_get_main_queue(),{
                    let dict :NSDictionary?
                    do
                    {
                        dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                        
                        print("ASynchronous\(dict)")
                        let success = dict?.valueForKey("success") as! String
                        print(success)
                        if success == "true"
                        {
                            progressHUD.hideAnimated(true)
                            progressHUD.hidden = true

                            let profileDict = dict?.valueForKey("profile") as! NSDictionary
                            
                            self.userName.text = profileDict.valueForKey("username") as? String
                            self.pwd.text =  profileDict.valueForKey("password") as? String
                            
                            self.email.text = profileDict.valueForKey("email") as? String
                            self.phoneNo.text =  profileDict.valueForKey("phone") as? String
                            
                            self.address.text = profileDict.valueForKey("address") as? String
                            self.typ.text =  profileDict.valueForKey("type") as? String
                            
                            self.postcode.text = profileDict.valueForKey("postcode") as? String
                            self.company.text =  profileDict.valueForKey("company") as? String
                            
                            
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
            task.resume()

        }
    }
    
    //MARK:- Back Button
    
    @IBAction func backBtn(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- Edit Button
    
    @IBAction func editBtn(sender: UIButton) {
        
        if editBtn.titleLabel?.text == "Edit"
        {
            userName.enabled = true
            pwd.enabled = true
            email.enabled = true
            phoneNo.enabled = true
            address.enabled = true
            typ.enabled = true
            postcode.enabled = true
            company.enabled = true
            userName.becomeFirstResponder()
            editBtn.setTitle("Update", forState: .Normal)

        }
        else
        {
            UpdateProfileApi()
        }
        
       
    }
    
    //MARK:- Update Profile Api
    func UpdateProfileApi()
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
            
            
            let imageData:NSData = UIImageJPEGRepresentation(userProfileImage.image!, 0.3)!
            let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            let userID =  NSUserDefaults.standardUserDefaults().valueForKey("user_Id") as? String
            let par = NSString(format: "username=%@&password=%@&email=%@&phone=%@&address=%@&postcode=%@&company=%@&type=%@&user_id=%@&profile_pic=%@",userName.text!,pwd.text!,email.text!,phoneNo.text!,address.text!,postcode.text!,company.text!,typ.text!,userID!,strBase64)
            
            //print(par)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/update_profile?")!)
            
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
                            
                            let message = dict?.valueForKey("message") as! String
                            
                            let messageAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            messageAlert.addAction(defaultAction)
                            
                            self.presentViewController(messageAlert, animated: true, completion: nil)
                            
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
    @IBAction func addImage(sender: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            userProfileImage.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }


}
