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
        else
        {
            
            if mobileTxtField.text?.characters.count < 10
            {
                let alertController = UIAlertController(title: "Alert", message:"Please Enter Valid Mobile Number", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: .None))
                self.presentViewController(alertController, animated: true, completion: .None)
            }
            else
            {
                let verificationCode = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationCodeViewController") as! VerificationCodeViewController
                verificationCode.mobileNumber = mobileTxtField.text!
                
                self.navigationController?.pushViewController(verificationCode, animated: true)
            }

        }
        
    }
    
    

}
