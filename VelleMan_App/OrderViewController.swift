//
//  OrderViewController.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 06/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var addressTitleLbl: UILabel!
    @IBOutlet weak var orderTableView: UITableView!

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var totalOutstandingLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var addressTEXTVIEW: UITextView!
    @IBOutlet weak var addressOutlet: UIButton!
    @IBOutlet weak var orderOutlet: UIButton!
    @IBOutlet weak var paymentoutlet: UIButton!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    var isFromAddressList = ""
    var vegName = NSMutableArray()
    var vegArray = NSMutableArray()
    var priceArray = NSMutableArray()
    var cutPriceArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addressTitleLbl.textAlignment = .Left
        userName.textAlignment = .Left
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            headerLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            
            addressOutlet.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            orderOutlet.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            paymentoutlet.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            addressTitleLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
        
            
            userName.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            addressTEXTVIEW.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            nextBtn.titleLabel?.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            totalOutstandingLbl.font = UIFont(name: (addressOutlet.titleLabel?.font.fontName)!, size: 20)
            
        }
        
        
        addressOutlet.backgroundColor = ColorTheme().backGroundColor()
        paymentoutlet.backgroundColor = ColorTheme().backGroundColor()
        orderOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerImage.image = UIImage(named: "greenHeader")

        }
        
        vegArray = ["VegImage1","vegImage2","vegImage3","vegImage4","VegImage1","vegImage2"]
        vegName = ["Bitter Gourd","Cabbage","Capsicum Green","Carrot-Red","Bitter Gourd","Cabbage"]
        priceArray = ["£ 10.00","£ 15.00","£ 10.00","£ 10.00","£ 15.00","£ 10.00"]
        cutPriceArray = ["£ 15.90","£ 20.90","£ 15.90","£ 15.90","£ 20.90","£ 15.90"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK :- Tableview DataSource
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            return 130
        }
        else
        {
            return 93
        }
        
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return vegArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let Order = tableView.dequeueReusableCellWithIdentifier("orderCell") as! OrderCell
        Order.selectionStyle = .None
       
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            Order.orderProductName.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.priceLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.previousPriceLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.quantityLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.boxQuantityLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
        }
        
        Order.orderImage.image = UIImage(named: vegArray[indexPath.row] as! String)
        Order.orderProductName.text = vegName[indexPath.row] as? String
        Order.priceLbl.text = priceArray[indexPath.row] as? String
        
        
        Order.previousPriceLbl.text = cutPriceArray[indexPath.row] as? String
        Order.previousPriceLbl.textColor = ColorTheme().theme()
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (cutPriceArray[indexPath.row] as? String)!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        Order.previousPriceLbl.attributedText = attributeString

        
        Order.noLbl1.layer.borderWidth = 1
        Order.noLbl1.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        Order.noLbl2.layer.borderWidth = 1
        Order.noLbl2.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        Order.noLbl3.layer.borderWidth = 1
        Order.noLbl3.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        
        return Order
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

    @IBAction func removeOrderButton(sender: AnyObject)
    {
        vegName.removeObjectAtIndex(sender.tag)
        vegArray.removeObjectAtIndex(sender.tag)
        priceArray.removeObjectAtIndex(sender.tag)
        cutPriceArray.removeObjectAtIndex(sender.tag)
        orderTableView.reloadData()
    }
    
    @IBAction func paymentMethod(sender: AnyObject)
    {
        let paymentMethod = self.storyboard?.instantiateViewControllerWithIdentifier("selectPaymentMethodViewController") as! selectPaymentMethodViewController
        
        self.navigationController?.pushViewController(paymentMethod, animated: true)
        
    }
    @IBAction func paymentView(sender: AnyObject)
    {
        let paymentaVC = self.storyboard?.instantiateViewControllerWithIdentifier("selectPaymentMethodViewController") as! selectPaymentMethodViewController
        
        paymentaVC.isFrom = "order"
        self.navigationController?.pushViewController(paymentaVC, animated: false)
        
    }

        @IBAction func backButton(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    
    @IBAction func AddressOutlet(sender: AnyObject)
    {
        let specialDeals = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
        
        specialDeals.selectedIndex = 2
        
        self.navigationController?.pushViewController(specialDeals, animated: false)
      
    }
    
    //Mark:- API to get item of a cart
    
    func getCartItem()
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
            
            //             let par = NSString(format: "/%@/%@/%@",userID!,oldPasswordField.text!,newPwdField.text!)
            
            
            let par = NSString(format: "/%@",userID!)
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_cart_items/device_id_or_token")!)
            
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
                            let message = dict?.valueForKey("message") as! String
                            let messageAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            messageAlert.addAction(defaultAction)
                            let specialDeals = self.storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
                            
                            specialDeals.selectedIndex = 2
                            
                            self.navigationController?.pushViewController(specialDeals, animated: true)
                            self.presentViewController(messageAlert, animated: true, completion: nil)
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
