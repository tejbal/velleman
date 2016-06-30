//
//  BusinessSignUpViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 31/05/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class BusinessSignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate {
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var createPasswordSubView: UIView!

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var termsSubView: UIView!
    @IBOutlet weak var postCodeSubView: UIView!
    @IBOutlet weak var AddressSubView: UIView!
    @IBOutlet weak var companyNameSubView: UIView!
    @IBOutlet weak var mobileNoSubView: UIView!
    @IBOutlet weak var emailSubView: UIView!
    @IBOutlet weak var confirmPasswordSubView: UIView!
    @IBOutlet weak var userSubView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var confirmPwdTxt: UITextField!
    @IBOutlet weak var homeCheckBtn: UIImageView!
    var signUpBool = Bool()
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var alreadyHaveAccLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var businesscheckBtn: UIImageView!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var acceptTermNdCndLbl: UILabel!
    @IBOutlet weak var pwdLineView: UIView!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var pwdLbl: UILabel!
    @IBOutlet weak var phoneNoLineView: UIView!
    @IBOutlet weak var phoneNoTxtField: UITextField!
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var addressHighlightedView: UIView!
    @IBOutlet weak var postCodeLineView: UIView!
    @IBOutlet weak var postCOdeTxtField: UITextField!
    @IBOutlet weak var postCodeLbl: UILabel!
    @IBOutlet weak var addressLineView: UIView!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLineView: UIView!
    @IBOutlet weak var companyTxtField: UITextField!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var emailLineView: UIView!
    var pickerView = UIPickerView()
    @IBOutlet weak var busiTxtField: UITextField!
    @IBOutlet weak var signUpScrollView: UIScrollView!
    var categoryArray = NSMutableArray()
    let imagePicker = UIImagePickerController()
    
    
    var checkSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpBool = false
        
        
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height / 2
        userProfileImage.layer.masksToBounds = true
        
         self.imagePicker.delegate = self
        self.ChangeUIDependonCategory()
        
       // busiTxtField.inputView = pickerView
        pickerView.delegate = self
        categoryArray = ["Business","Home"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK:- Back Button
    
    @IBAction func backBtn(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- Check Button
    
    @IBAction func checkBtn(sender: AnyObject)
    {
        if checkBtn.selected
        {
            checkSelected = false
            checkBtn.selected = false
        }
        else
        {
            checkSelected = true
            checkBtn.selected = true
        }
    }
    
    //MARK:- Login Button
    
    @IBAction func loginBtn(sender: AnyObject)
    {
        let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVc, animated: false)
    }
    
    //MARK :- AddImage
    
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
    
    
    @IBAction func businessCheckBtn(sender: AnyObject)
    {
        
        if businesscheckBtn.image != UIImage(named: "RadioCheckBtn")
        {
            if signUpBool == false
            {
                signUpBool = true
                
                homeCheckBtn.image = UIImage(named: "RadioUncheckBtn")
                businesscheckBtn.image = UIImage(named: "RadioCheckBtn")
                
            }
            self.ChangeUIDependonCategory()
        }
        
    }
    
    
    @IBAction func homeCheckBtn(sender: AnyObject)
    {
        if homeCheckBtn.image != UIImage(named: "RadioCheckBtn")
        {
            if signUpBool == true
            {
                signUpBool = false
                homeCheckBtn.image = UIImage(named: "RadioCheckBtn")
                businesscheckBtn.image = UIImage(named: "RadioUncheckBtn")
            }
            self.ChangeUIDependonCategory()
        }
    }

    
    //MARK:- PickerView Delegate
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return categoryArray.count
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       // busiTxtField.text = categoryArray[row] as? String
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row] as? String
    }
    
    //MARK:- TextField Action
    
    @IBAction func busTxtField(sender: UITextField)
    {
        /* if busiTxtField.text == "Business"
       {
            signUpBool = false
            self.ChangeUIDependonCategory()
        }
        if busiTxtField.text == "Home"
        {
            signUpBool = true
            self.ChangeUIDependonCategory()
        }
        */
    }
    
    
    //MARK:- ChangeUI Depend on Category
    
    func ChangeUIDependonCategory()
    {
        var i = 0
        
        if signUpBool == true
        {
            companyNameSubView.hidden = false
            
            AddressSubView.frame.origin.y = AddressSubView.frame.origin.y + companyNameSubView.frame.size.height
            
            postCodeSubView.frame.origin.y = postCodeSubView.frame.origin.y + companyNameSubView.frame.size.height
            
            termsSubView.frame.origin.y = postCodeSubView.frame.origin.y + companyNameSubView.frame.size.height + 10
           
            i = 40
        
        }
        else
        {
       
            companyNameSubView.hidden = true
            
            //AddressSubView.frame.origin.y = companyNameSubView.frame.origin.y
            
            AddressSubView.frame.origin.y = AddressSubView.frame.origin.y - companyNameSubView.frame.size.height
            
            postCodeSubView.frame.origin.y = postCodeSubView.frame.origin.y - companyNameSubView.frame.size.height
            
            termsSubView.frame.origin.y = termsSubView.frame.origin.y - companyNameSubView.frame.size.height
            
            i = 20
        }
        
        signUpScrollView.contentSize = CGSizeMake(signUpScrollView.frame.size.width, termsSubView.frame.origin.y + termsSubView.frame.size.height + CGFloat(i)
        )
        
    }
    
    
    
    
    
    @IBAction func signUpBtn(sender: AnyObject)
    {
      
        var isError = false
        var message = ""
        
        
        
        if signUpBool == false
        {
            if userName.text == "" || emailTxtField.text == "" || confirmPwdTxt.text == "" || pwdTxtField.text == "" || phoneNoTxtField.text == ""
                || postCOdeTxtField.text == "" || addressTxtField.text == ""
            {
                isError = true
                
                message = "All fields Are mandatory"
            }
            
        }
        else
        {
           if userName.text == "" || emailTxtField.text == "" || confirmPwdTxt.text == "" || pwdTxtField.text == "" || phoneNoTxtField.text == ""
                || postCOdeTxtField.text == "" || addressTxtField.text == "" || companyTxtField.text == ""
            {
                isError = true
                message = "All fields Are mandatory"

            }
        }
        
        if isError != true
        {
            if !isValidEmail(emailTxtField.text!)
            {
                isError = true
                message = "Please Enter Valid Email Address"
            }

        }
        
        if isError != true
        {
            let whitespace = NSCharacterSet.whitespaceCharacterSet()
            
            let range = phoneNoTxtField.text!.rangeOfCharacterFromSet(whitespace)
            
            
            if let phoneNumber = range
            {
                isError = true
                message = "Please Enter Valid Phone number"
            }

        }
        
        
        if isError != true
        {
            
            if phoneNoTxtField.text?.characters.count < 10
            {
                isError = true
                message = "Please Enter Valid Phone number"
                
            }
        }
        
        if isError != true
        {
            if pwdTxtField.text?.characters.count < 6
            {
                isError = true
                message = "Please enter strong password"
            }
        }

        
        if isError != true
        {
            
            if pwdTxtField.text != confirmPwdTxt.text
            {
                isError = true
                message = "Password and Confirm Password does not match"
            }
            
        }
        if isError != true
        {
            if checkSelected == false
            {
                isError = true
                message = "You did not agree to our terms And condition"
            }
        }
        
        
        
        if isError == true
        {
            let UIAlert = AlertClass()
            
            let alertMessage = UIAlert.alert("Alert", message: message, buttonTitle:"ok")
            
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
        if isError == false
        {
            api()
        }
        
    }
    
    func isValidEmail(emailid: NSString)->Bool
    {
        var isValid = true
        
        var isTrimmed = true
        
        var emailId = emailid
        
        while(isTrimmed)
        {
            
            let startSpace = emailId.substringWithRange(NSRange(location: 0, length: 1))
            
            let endSpace = emailId.substringWithRange(NSRange(location: emailId.length-1, length: 1))
            
            if startSpace == " " || endSpace == " "
            {
                if startSpace == " "
                {
                    emailId = emailId.stringByReplacingCharactersInRange(NSRange(location: 0, length: 1), withString: "")
                }
                if endSpace == " "
                {
                    emailId = emailId.stringByReplacingCharactersInRange(NSRange(location: emailId.length-1, length: 1), withString: "")
                }
            }
            else
            {
                isTrimmed = false
            }
        }
        
        
        if !emailId.containsString(" ")
        {
            var atRateSplitArray = emailId.componentsSeparatedByString("@")
            
            if(atRateSplitArray.count>=2)
            {
                for component in atRateSplitArray
                {
                    if component == ""
                    {
                        isValid = false
                    }
                }
                
                if(isValid)
                {
                    let dotSplitArray = atRateSplitArray[atRateSplitArray.count-1].componentsSeparatedByString(".")
                    
                    if(dotSplitArray.count>=2)
                    {
                        for component in dotSplitArray
                        {
                            if component == ""
                            {
                                isValid = false
                            }
                        }
                    }
                    else
                    {
                        isValid = false
                    }
                }
            }
            else
            {
                isValid = false
            }
            
        }
        else
        {
            isValid = false
        }
        
        return isValid
    }
    
    func api()
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
            
            if signUpBool == true
            {
                 companyTxtField.text = companyTxtField.text?.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            }
            else
            {
                companyTxtField.text = ""
            }

            
            
            let imageData:NSData = UIImagePNGRepresentation(userProfileImage.image!)!
            
           let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            
            var userType = ""
            if signUpBool == true
            {
                userType = "business"
            }
            else
            {
                userType = "home"
            }
            
            let par = NSString(format: "username=%@&password=%@&email=%@&profile_pic=%@&phone=%@&address=%@&postcode=%@&company=%@&type=%@",userName.text!,pwdTxtField.text!,emailTxtField.text!,strBase64,phoneNoTxtField.text!,addressTxtField.text!,postCOdeTxtField.text!,companyTxtField.text!,userType)
            
            print(par)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/register")!)
            
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
                        let success = dict?.valueForKey("success") as! String
                        print(success)
                        if success == "True"
                        {
                            progressHUD.hideAnimated(true)
                            progressHUD.hidden = true
                            
                            let result = dict?.valueForKey("result") as! NSDictionary
                           print(result)
                            let message = dict?.valueForKey("message") as! String
                            
                            let User_Id = result.valueForKey("id") as! String
                            NSUserDefaults.standardUserDefaults().setObject(User_Id, forKey: "user_Id")
                            
                            
                            
                            
                            let UIAlert = AlertClass()
                            
                            let alertMessage = UIAlert.alert("Success", message: message, buttonTitle:"ok")
                            
                            self.presentViewController(alertMessage, animated: true, completion: nil)
                            
                            let verificationView = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationCodeViewController") as! VerificationCodeViewController
                            verificationView.mobileNumber = self.phoneNoTxtField.text!
                            self.navigationController?.pushViewController(verificationView, animated: true)
                            
                            
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
