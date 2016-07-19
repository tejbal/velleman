//
//  AddressListViewController.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 06/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit




class AddressListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var addressListTableView: UITableView!
    
    @IBOutlet weak var headetLbl: UILabel!
    @IBOutlet weak var paymentOutlet: UIButton!
    @IBOutlet weak var orderOutlet: UIButton!
    @IBOutlet weak var addressOutlet: UIButton!
    @IBOutlet weak var transparentimage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
   
    var addressDetail = NSMutableArray()
    var checkToggle = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            paymentOutlet.titleLabel?.font = UIFont(name: (paymentOutlet.titleLabel?.font.fontName)!, size: 20)
            orderOutlet.titleLabel?.font = UIFont(name: (paymentOutlet.titleLabel?.font.fontName)!, size: 20)
            addressOutlet.titleLabel?.font = UIFont(name: (paymentOutlet.titleLabel?.font.fontName)!, size: 20)
            
        }
        
        
        paymentOutlet.backgroundColor = ColorTheme().backGroundColor()
        orderOutlet.backgroundColor = ColorTheme().backGroundColor()
        addressOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        
        
            if (NSUserDefaults.standardUserDefaults().boolForKey("isHome"))
            {
                 self.tabBarController?.tabBar.backgroundImage = UIImage(named: "themefooter")
                headerImage.image = UIImage(named: "greenHeader")
                nextBtn.backgroundColor = ColorTheme().theme()
        
             }
            
     
        checkToggle = [true,false,false,false]
     
        
        addressListTableView.separatorColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        let mh = MenuHandler()
        mh.addMenuButton(self.view)

        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
          getUserApi()
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
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome"))
        {
            if checkToggle[indexPath.row] as! Bool == true
            {
                addressCell.checkButton.image = UIImage(named: "GreenImage")
            }
            else
            {
                addressCell.checkButton.image = UIImage(named: "addresUnCheck")
            }

        }
        
        addressCell.addressLbl.text = addressDetail[indexPath.row]["city"] as? String
        addressCell.addressDetail.text = addressDetail[indexPath.row]["address_1"] as? String
        
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
    
    //MARK:- GetUser Api
    func getUserApi()
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
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_user_addresses\(par)")!)
            
            request.HTTPMethod = "GET"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    let dict :NSDictionary?
                    do
                    {
                        dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                        
                        print("ASynchronous\(dict)")
                        let success = dict?.valueForKey("success") as! NSString
                        
                        if success == "true"
                        {
                            progressHUD.hideAnimated(true)
                            self.addressDetail = (dict?.valueForKey("addresses"))! as! NSMutableArray
                            self.addressListTableView.reloadData()
                        }
                        else
                        {
                            progressHUD.hideAnimated(true)
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
                        print(error.localizedDescription)
                    }
                })
            })
            
            task.resume()
        }

    }
    
}
