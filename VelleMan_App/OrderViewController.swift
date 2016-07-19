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
       
        cartListApi()
        addressTitleLbl.textAlignment = .Left
        userName.textAlignment = .Left
        orderTableView.tableFooterView = UIView(frame: CGRectZero)
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
        
       // vegArray = ["VegImage1","vegImage2","vegImage3","vegImage4","VegImage1","vegImage2"]
        //vegName = ["Bitter Gourd","Cabbage","Capsicum Green","Carrot-Red","Bitter Gourd","Cabbage"]
       // priceArray = ["£ 10.00","£ 15.00","£ 10.00","£ 10.00","£ 15.00","£ 10.00"]
        //cutPriceArray = ["£ 15.90","£ 20.90","£ 15.90","£ 15.90","£ 20.90","£ 15.90"]
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
        Order.incrementBtn.tag = indexPath.row
        Order.decrementBtn.tag = indexPath.row
        Order.boxQuantityLbl.tag = indexPath.row + 400
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            Order.orderProductName.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.priceLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.previousPriceLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.quantityLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
            Order.boxQuantityLbl.font = UIFont(name: Order.orderProductName.font.fontName, size: 18)
        }
        //Order.orderImage.image = UIImage(named: vegArray[indexPath.row] as! String)
        Order.orderProductName.text = vegArray[indexPath.row].valueForKey("product_name") as? String
        
        var originalCost = ""
        if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            originalCost = (vegArray[indexPath.row]["product_original_cost_for_individual"] as? String)!
        }
        else
        {
            originalCost = (vegArray[indexPath.row]["product_original_cost_for_business"] as? String)!
        }
        let currency = vegArray[indexPath.row]["product_currency"] as? String
        let totalCost = "\(currency!)\(originalCost)"
        Order.previousPriceLbl.textColor = ColorTheme().theme()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: totalCost)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        Order.previousPriceLbl.attributedText = attributeString

        var newCost = ""
        if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            newCost = (vegArray[indexPath.row]["product_discounted_cost_for_individual"] as? String)!
        }
        else
        {
            newCost = (vegArray[indexPath.row]["product_discounted_cost_for_business"] as? String)!
        }
        

        let quantity = vegArray[indexPath.row]["quantity"] as! String

        Order.boxQuantityLbl.text = "Qty \(quantity)"
        Order.boxQuantityLbl.tag = indexPath.row + 34
        Order.priceLbl.text = "\(currency!) \(newCost)"
        
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
    
    //MARK:- Increment and Decrement button
    
    @IBAction func decrementBtn(sender: UIButton){
        let textQuan =  self.view.viewWithTag(sender.tag + 400) as! UILabel
        textQuan.text = "45"
        
    }

    @IBAction func incrementBtn(sender: UIButton)
    {

        let quantity = vegArray[sender.tag]["quantity"] as? String
        print(quantity)
        var Value = Int(quantity!)!
        
        print(Value++)
        
        var v = Value++
        print(v++)
        print(sender.tag)
        print(vegArray.valueForKey("quantity"))
       vegArray.valueForKey("quantity") = v++
        
        
        
         vegArray.valueForKey("quantity").replaceObjectAtIndex(sender.tag, withObject: v++)
//
 
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
    
  
    //MARK:- Cart List
    func cartListApi()
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
            let deviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
            let par = NSString(format: "/%@",deviceID)
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_cart_items\(par)")!)
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
                            
                            self.vegArray = dict?.valueForKey("items") as! NSMutableArray
                            self.orderTableView.reloadData()
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
    
    //MARK:- Update Qunatity
    
    func updateQuantity()
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
            let deviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
            let par = NSString(format: "/%@/%@/%@","5","8",deviceID)
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/update_cart_quantity\(par)")!)
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
