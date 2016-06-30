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
        
        
    }
    
    @IBAction func backBtn(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)

    }
   
}
