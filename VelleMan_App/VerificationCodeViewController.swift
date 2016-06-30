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
    var mobileNumber = ""
    var countDownTimer : NSTimer = NSTimer()
    var timer = 59
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        messegLbl.text = "Please Enter verification code sent to +44\(mobileNumber)"
        
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
        
    }
    
    
    @IBAction func submitBtnAction(sender: AnyObject)
    {
                let specialDeals = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
               self.navigationController?.pushViewController(specialDeals, animated: true)
    }

}
