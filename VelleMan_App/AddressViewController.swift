//
//  AddressViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController,UITextFieldDelegate {

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
//            addressDetail.addObject(addressLine2.text! + zipcode.text! + city.text!)
//            addressTitle.addObject(address.text!)
            
            
            let alert=UIAlertController(title: "Alert", message: "Address Saved", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            self.navigationController?.popViewControllerAnimated(true)

            
            
            presentViewController(alert, animated: true, completion: nil);
            
            
            
            
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
    
}
