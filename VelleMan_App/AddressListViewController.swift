//
//  AddressListViewController.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 06/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit


var addressTitle = NSMutableArray()
var addressDetail = NSMutableArray()

class AddressListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var addressListTableView: UITableView!
    
    @IBOutlet weak var headetLbl: UILabel!
    @IBOutlet weak var paymentOutlet: UIButton!
    @IBOutlet weak var orderOutlet: UIButton!
    @IBOutlet weak var addressOutlet: UIButton!
    @IBOutlet weak var transparentimage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
   
    var checkToggle = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            paymentOutlet.titleLabel?.font = UIFont(name: (paymentOutlet.titleLabel?.font.fontName)!, size: 20)
            orderOutlet.titleLabel?.font = UIFont(name: (paymentOutlet.titleLabel?.font.fontName)!, size: 20)
            addressOutlet.titleLabel?.font = UIFont(name: (paymentOutlet.titleLabel?.font.fontName)!, size: 20)
            
        }
        
        let mh = MenuHandler()
        mh.addMenuButton(self.view)
        
        paymentOutlet.backgroundColor = ColorTheme().backGroundColor()
        orderOutlet.backgroundColor = ColorTheme().backGroundColor()
        addressOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerImage.image = UIImage(named: "greenHeader")
            
        }
        
        
        addressTitle = ["HOME","HOME","HOME","HOME"]
        checkToggle = [true,false,false,false]
        addressDetail = ["54 gasslfas, Albatia , Agra","55 gasslfas, Albatia , Agra","53 gasslfas, Albatia , Agra","52 gasslfas, Albatia , Agra"]
        
        addressListTableView.separatorColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        addressListTableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK :-  Tableview data Source 
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            return 130
        }
        else
        {
             return 80
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressDetail.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let addressCell = tableView.dequeueReusableCellWithIdentifier("addressListCell")  as! addressListCell
        
        addressCell.checkBtn.tag = indexPath.row
        addressCell.editBtn.tag = indexPath.row
        
        addressCell.selectionStyle = .None
        
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            addressCell.addressLbl.font = UIFont(name: addressCell.addressLbl.font.fontName, size: 20)
            addressCell.addressDetail.font = UIFont(name: addressCell.addressDetail.font.fontName, size: 20)
        }
        
        if checkToggle[indexPath.row] as! Bool == true
        {
            addressCell.checkButton.image = UIImage(named: "addressCheck")
        }
        else
        {
            addressCell.checkButton.image = UIImage(named: "addresUnCheck")
        }
        
        
        addressCell.addressLbl.text = addressTitle[indexPath.row] as? String
        addressCell.addressDetail.text = addressDetail[indexPath.row] as? String
        
        addressCell.wrapperView.layer.cornerRadius = 3
        addressCell.wrapperView.layer.borderWidth = 1
        addressCell.wrapperView.layer.borderColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1.0).CGColor
        addressCell.wrapperView.layer.masksToBounds = true
        
        
        return addressCell
        
    }
   
    // MARK :- Edit Button
    
    @IBAction func editBtn(sender: AnyObject)
    {
        
    }
   
    // MARK:- check Button
    
    @IBAction func checkBtn(sender: AnyObject)
    {
      
        let boolValue = checkToggle.objectAtIndex(sender.tag)  as! Bool
        
        if boolValue == true
        {
            
            checkToggle.replaceObjectAtIndex(sender.tag, withObject: false)
            
        }
        else
        {
            checkToggle.replaceObjectAtIndex(sender.tag, withObject: true)
            
        }
        
        addressListTableView.reloadData()
        
        
    }
    @IBAction func nextButton(sender: AnyObject)
    {
        
        let address = self.storyboard?.instantiateViewControllerWithIdentifier("OrderViewController") as! OrderViewController
        
        self.navigationController?.pushViewController(address, animated: true)
    }
    
    @IBAction func paymentButton(sender: AnyObject)
    {
       let paymentView = self.storyboard?.instantiateViewControllerWithIdentifier("selectPaymentMethodViewController") as! selectPaymentMethodViewController
        paymentView.isFrom = "Address"
        self.navigationController?.pushViewController(paymentView, animated: false)
    }
  
    
    @IBAction func orderbutton(sender: AnyObject)
    {
        let orderVC = self.storyboard?.instantiateViewControllerWithIdentifier("OrderViewController") as! OrderViewController
        orderVC.isFromAddressList = "true"
        self.navigationController?.pushViewController(orderVC, animated: false)
    }
  
    @IBAction func addNewaddressBtn(sender: AnyObject)
    {
        
        let address = self.storyboard?.instantiateViewControllerWithIdentifier("Address") as! AddressViewController
        
        self.navigationController?.pushViewController(address, animated: true)
        
    }
    
    
    @IBAction func backButton(sender: AnyObject)
    {
        
        
//        self.navigationController?.popViewControllerAnimated(true)
    }
}
