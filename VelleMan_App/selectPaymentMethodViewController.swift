//
//  selectPaymentMethodViewController.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 06/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class selectPaymentMethodViewController: UIViewController {

    @IBOutlet weak var paymentMethod: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cashOnDeliveryLbl: UILabel!
    @IBOutlet weak var applePayBottomLbl: UILabel!
    @IBOutlet weak var applePayLbl: UILabel!
    @IBOutlet weak var payPalBottomLabel: UILabel!
    @IBOutlet weak var payPalLbl: UILabel!
    @IBOutlet weak var creditCardBottomView: UILabel!
    @IBOutlet weak var creaditCard: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var addressOutlet: UIButton!
    @IBOutlet weak var orderOutlet: UIButton!
    @IBOutlet weak var paymentOutlet: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var codImage: UIImageView!
    @IBOutlet weak var payAppleImage: UIImageView!
    @IBOutlet weak var paypalimage: UIImageView!
    @IBOutlet weak var visaImage: UIImageView!
    
    var isFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            headerLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            
            addressOutlet.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            orderOutlet.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            paymentOutlet.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
             creaditCard.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 18)
             creditCardBottomView.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 16)
             applePayLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 18)
             applePayBottomLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 16)
             payPalLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 18)
             payPalBottomLabel.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 16)
             cashOnDeliveryLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 18)
            
            titleLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            
            
            
        }
        
        paymentMethod.backgroundColor = ColorTheme().theme()
        addressOutlet.backgroundColor = ColorTheme().backGroundColor()
        paymentOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        orderOutlet.backgroundColor = ColorTheme().backGroundColor()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerImage.image = UIImage(named: "greenHeader")
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK :- Payment methods radio buttons
    
    @IBAction func visaButton(sender: AnyObject)
    {
        visaImage.image = UIImage(named:"paymentRadioButton")
        paypalimage.image = UIImage(named:"paymentUncheckRadioButton")
        payAppleImage.image = UIImage(named:"paymentUncheckRadioButton")
        codImage.image = UIImage(named:"paymentUncheckRadioButton")
    }
    
    @IBAction func payPalButton(sender: AnyObject)
    {
        visaImage.image = UIImage(named:"paymentUncheckRadioButton")
        paypalimage.image = UIImage(named:"paymentRadioButton")
        payAppleImage.image = UIImage(named:"paymentUncheckRadioButton")
        codImage.image = UIImage(named:"paymentUncheckRadioButton")
    }
    
    @IBAction func applepayBtn(sender: AnyObject)
    {
        visaImage.image = UIImage(named:"paymentUncheckRadioButton")
        paypalimage.image = UIImage(named:"paymentUncheckRadioButton")
        payAppleImage.image = UIImage(named:"paymentRadioButton")
        codImage.image = UIImage(named:"paymentUncheckRadioButton")
    }
    
    @IBAction func codButton(sender: AnyObject)
    {
        visaImage.image = UIImage(named:"paymentUncheckRadioButton")
        paypalimage.image = UIImage(named:"paymentUncheckRadioButton")
        payAppleImage.image = UIImage(named:"paymentUncheckRadioButton")
        codImage.image = UIImage(named:"paymentRadioButton")
    }

    @IBAction func backButton(sender: AnyObject)
    {
       self.navigationController?.popViewControllerAnimated(false)
    }

    @IBAction func orderButton(sender: AnyObject)
    {
        
            let orderVC = self.storyboard?.instantiateViewControllerWithIdentifier("OrderViewController") as! OrderViewController
            
            self.navigationController?.pushViewController(orderVC, animated: false)
    }
    
    @IBAction func paymentMethod(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addressBtn(sender: AnyObject)
    {
        let specialDeals = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
       
        specialDeals.selectedIndex = 2
        
        self.navigationController?.pushViewController(specialDeals, animated: false)
        
    }
}
