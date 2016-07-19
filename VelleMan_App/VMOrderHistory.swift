//
//  VMOrderHistory.swift
//  VelleMan_App
//
//  Created by Jarvics Soft on 12/03/1938 Saka.
//  Copyright © 1938 Saka Jarvics. All rights reserved.
//

import UIKit

class VMOrderHistory: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet weak var orderHistoryTableView: UITableView!
    
    @IBOutlet weak var totlaPriceLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var headerimage: UIImageView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    var invoiceName = NSMutableArray()
    var invoiceDate = NSMutableArray()
    var invoiceTime = NSMutableArray()
    var dateLbl = NSMutableArray()
    var invoicePaidStatus = NSMutableArray()
    var invoiceCost = NSMutableArray()
    var image = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
            orderListApi()
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

        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            headerLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            
            totlaPriceLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            priceLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            
        }
        
        orderHistoryTableView.separatorColor = UIColor.clearColor()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            self.tabBarController?.tabBar.backgroundImage = UIImage(named: "themefooter")
            headerimage.image = UIImage(named: "greenHeader")
        }
        
        
        
        invoiceName = ["Invoice 00004","Invoice 00003","Invoice 00002","Invoice 00001"]
        image = ["paypal","paypal","paypal","paypal"]
        dateLbl = ["29 march 2016","29 march 2016","29 march 2016","29 march 2016"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let mh = MenuHandler()
        mh.addMenuButton(self.view)
        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
            orderListApi()
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
    //MARK :- Table View Datasource
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            return 200
        }
        else
        {
            return 109
        }
        
        
    }

    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let OrderCell = tableView.dequeueReusableCellWithIdentifier("OrderHistoryCell") as! OrderHistoryCell
        OrderCell.selectionStyle = .None
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            OrderCell.invoiceName.font = UIFont(name: OrderCell.invoiceName.font.fontName, size: 16)
            OrderCell.dateLbl.font = UIFont(name: OrderCell.dateLbl.font.fontName, size: 16)
            OrderCell.timeLbl.font = UIFont(name: OrderCell.timeLbl.font.fontName, size: 16)
            OrderCell.costLabel.font = UIFont(name: OrderCell.costLabel.font.fontName, size: 16)
            OrderCell.paidStatus.font = UIFont(name: OrderCell.paidStatus.font.fontName, size: 16)
            
            
        }
        
        OrderCell.dateLbl.text = dateLbl[indexPath.row] as? String
        OrderCell.wrapperView.layer.cornerRadius = 4
        OrderCell.wrapperView.layer.borderWidth = 1
        OrderCell.wrapperView.layer.borderColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1.0).CGColor
        OrderCell.wrapperView.layer.masksToBounds = true
        
        OrderCell.invoiceName.text = invoiceName[indexPath.row] as? String
        OrderCell.trackImage.image = UIImage(named: image[indexPath.row] as! String)
        return OrderCell
    }
    
    func tableView(_tableView: UITableView,willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
    }

   //MARK:- OrderList
    
    func orderListApi()
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
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_orders\(par)")!)
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
