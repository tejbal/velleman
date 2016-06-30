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
    }

    @IBAction func backBtn(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
