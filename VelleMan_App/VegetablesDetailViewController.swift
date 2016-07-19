//
//  VegetablesDetailViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class VegetablesDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var CategoriesArray = [Dictionary<String, AnyObject>]()
    var tableViews = [UITableView]()
    var productArray = [[Dictionary<String, AnyObject>]]()
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var vedView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var totalOutstandingLbl: UILabel!
    @IBOutlet weak var vegScrollView: UIScrollView!
    
    @IBOutlet weak var headerImage: UIImageView!
  
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var productScrollView: UIScrollView!
   
    var index = 1
    var buttonTag = Int()
    var QtyData = NSMutableArray()
    var i = 1
    var isThemeChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        productApi()
        
        bottomView.frame.origin.y = self.view.frame.origin.y + self.view.frame.size.height + bottomView.frame.size.height
        
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            isThemeChange = true
            
            headerImage.image = UIImage(named: "greenHeader")
         
        }
    
        print(self.view.frame.size.width/3)
         print(CGFloat(index))
        if !(index == CategoriesArray.count || index == CategoriesArray.count - 1)
        {
            let vegV = (self.view.frame.size.width/3) * CGFloat(index)
            print(vegV)
            
            let vegpoint = CGPointMake(self.view.frame.origin.x + vegV, 0)
            
            vegScrollView.setContentOffset(vegpoint, animated: false)

        }
    
        
        let value = self.view.frame.size.width * CGFloat(index)
        
        let point = CGPointMake(self.view.frame.origin.x + value, 0)
        
        productScrollView.setContentOffset(point, animated: false)
        
        
}
    
    
    override func viewWillAppear(animated: Bool)
    {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewDidAppear(animated: Bool) {
    }
    
    //MARK:- Back Button
    
    @IBAction func backBtn(sender: UIButton)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    //MARK:- Next Button
    
    @IBAction func nextBtn(sender: UIButton)
    {
        
        
        
    }
    
    // MARK:- Scroll Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        var indexOfPage : Int!
        indexOfPage =  Int(productScrollView.contentOffset.x) / Int(productScrollView.frame.size.width)
        
        print(indexOfPage)
        
        let point = CGPointMake(self.view.frame.origin.x/2 + CGFloat(indexOfPage), 0)
        
        vegScrollView.setContentOffset(point, animated: false)
        
       print(vegScrollView.contentOffset)
        

    }
    
    
    //MARK:- ScrollCategory
    
//    func scrollCategory()
//    {
//        for i in (0..<CategoriesArray.count)
//        {
//        }
//    }
    
   
    //MARK:- ScrollView UI
    
    func scrollViewUI()
    {
        var originX : CGFloat = 0.0
        var cateX : CGFloat = 0.0
        
        for i in (0..<CategoriesArray.count)
        {
            
            let CategoriesButton = UIButton()
            CategoriesButton.frame = CGRectMake(cateX, vedView.frame.origin.y, view.frame.size.width/3, vedView.frame.size.height)
        CategoriesButton.setTitle(CategoriesArray[i]["category_name"] as? String, forState: .Normal)
            CategoriesButton.titleLabel?.font = UIFont(name: "Arial", size: 12.0)
            CategoriesButton.backgroundColor = ColorTheme().theme()
            vedView.addSubview(CategoriesButton)
            cateX = cateX + CategoriesButton.frame.size.width
            
            let image = UIImageView()
            image.frame = CGRectMake(originX, 0, self.view.frame.size.width, self.view.frame.size.height/3.65)
            image.image = UIImage(named:"img1")
            
            let title = UILabel()
            title.frame = CGRectMake(20, image.frame.size.height/1.8, view.frame.size.width, 20)
            title.textAlignment = NSTextAlignment.Left
            
            title.text = CategoriesArray[i]["category_name"] as? String
            title.textColor = UIColor.whiteColor()
            
            let desc = UILabel()
            desc.frame = CGRectMake(20, title.frame.origin.y + title.frame.size.height + 5, view.frame.size.width, 20)
            desc.textAlignment = NSTextAlignment.Left
            desc.text = CategoriesArray[i]["category_name"] as? String
            desc.font = UIFont(name: "Arial", size: 12)
            desc.textColor = UIColor.whiteColor()
            
            let table = UITableView()
            table.frame = CGRectMake(originX, image.frame.size.height, self.view.frame.size.width, productScrollView.frame.size.height - image.frame.size.height)
            
            table.backgroundView = UIImageView(image: UIImage(named: "LoginBackground"))
            table.rowHeight = self.view.frame.size.height/3.7
            //table.tag = i + 200
            table.tableFooterView = UIView(frame:CGRectZero)
            
            table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            table.dataSource = self
            
            table.delegate = self
            
            tableViews.append(table)
            
            productArray.append(CategoriesArray[i]["products"] as! [Dictionary<String,AnyObject>])
            print(productArray)
            image.addSubview(title)
            image.addSubview(desc)
            self.productScrollView.addSubview(image)
            originX = originX + image.frame.size.width

        }
        for i in (0..<tableViews.count)
        {
            print(i)
            self.productScrollView.addSubview(tableViews[i])
            tableViews[i].tag = i
            tableViews[i].reloadData()
        }
        
        
        productScrollView.contentSize = CGSizeMake((view.frame.size.width * CGFloat(CategoriesArray.count)), productScrollView.frame.size.height)
        vegScrollView.contentSize = CGSizeMake((view.frame.size.width/3) * CGFloat(CategoriesArray.count), vegScrollView.frame.size.height)
        vedView.frame.size.width = (view.frame.size.width/3) * CGFloat(CategoriesArray.count)
    }
    
    
    // MARK:-  TableView Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray[tableView.tag].count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.selectionStyle = .None
        let wrapperImage = UIImageView()
         wrapperImage.frame = CGRectMake(10,10,(cell.contentView.frame.size.width) - 20,(self.view.frame.size.height/3.7)-10)
        cell.backgroundColor = UIColor.clearColor()
        wrapperImage.image = UIImage(named:"transparentimage")
        
        
        let productName = UILabel()
        productName.frame = CGRectMake(10, 5, wrapperImage.frame.size.width - 20,wrapperImage.frame.size.height/8)
        print("\(productArray.count)____\(productArray[tableView.tag].count)____\(tableView.tag)____\(indexPath.row)")
        productName.text = productArray[tableView.tag][indexPath.row]["product_name"] as? String
        productName.font = UIFont(name: "Arial", size: 12.0)
        wrapperImage.addSubview(productName)
        
        let productImage = UIImageView()
        productImage.frame = CGRectMake(10, (productName.frame.origin.y + productName.frame.size.height) + 5 , wrapperImage.frame.size.width/4, wrapperImage.frame.size.height/2.3)
        productImage.image = UIImage(named:"VegImage1")
        
        
        let decrementButton = UIButton()
        decrementButton.frame = CGRectMake(productImage.frame.origin.x, (productImage.frame.origin.y + productImage.frame.size.height) + 5, 30, 30)
        decrementButton.setBackgroundImage(UIImage(named:"Decrement"), forState: .Normal)
        
        let qtyTextFld = UITextField()
        qtyTextFld.frame = CGRectMake(decrementButton.frame.origin.x + decrementButton.frame.size.width + 3, decrementButton.frame.origin.y,decrementButton.frame.size.width * 1.2, decrementButton.frame.size.height)
        qtyTextFld.text = "hello"
        qtyTextFld.textAlignment = NSTextAlignment.Center
        qtyTextFld.backgroundColor = UIColor.clearColor()
        qtyTextFld.font = UIFont(name: "Arial", size: 12.0)
        qtyTextFld.tag = i + 60

        let incrementButton = UIButton()
        incrementButton.frame = CGRectMake(qtyTextFld.frame.origin.x + qtyTextFld.frame.size.width+3, (productImage.frame.origin.y + productImage.frame.size.height) + 5, 30, 30)
        incrementButton.setBackgroundImage(UIImage(named:"Increment"), forState: .Normal)
        
        let ABC1 = UIButton()
        ABC1.frame = CGRectMake(productImage.frame.origin.x + productImage.frame.size.width+10, (productName.frame.origin.y + productName.frame.size.height) + 5, 60, 20)
        ABC1.setTitle("ABC112", forState: .Normal)
        ABC1.setTitleColor(UIColor.blackColor(), forState: .Normal)
        ABC1.titleLabel?.font = UIFont(name: "Arial", size: 12.0)
        ABC1.backgroundColor = UIColor.clearColor()
        ABC1.layer.borderWidth = 1

        let ABC2 = UIButton()
        ABC2.frame = CGRectMake(ABC1.frame.origin.x + ABC1.frame.size.width+5, (productName.frame.origin.y + productName.frame.size.height) + 5, 60, 20)
        ABC2.setTitle("ABC112", forState: .Normal)
        ABC2.setTitleColor(UIColor.blackColor(), forState: .Normal)
        ABC2.titleLabel?.font = UIFont(name: "Arial", size: 12.0)
        ABC2.backgroundColor = UIColor.clearColor()
        ABC2.layer.borderWidth = 1
        
        let ABC3 = UIButton()
        ABC3.frame = CGRectMake(ABC2.frame.origin.x + ABC2.frame.size.width+5, (productName.frame.origin.y + productName.frame.size.height) + 5, 60, 20)
        ABC3.setTitle("ABC112", forState: .Normal)
        ABC3.setTitleColor(UIColor.blackColor(), forState: .Normal)
        ABC3.titleLabel?.font = UIFont(name: "Arial", size: 12.0)
        ABC3.backgroundColor = UIColor.clearColor()
        ABC3.layer.borderWidth = 1

        
        let previousPrice = UILabel()
        
        
        var originalCost = ""
        if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            originalCost = (productArray[tableView.tag][indexPath.row]["product_original_cost_for_individual"] as? String)!
        }
        else
        {
            originalCost = (productArray[tableView.tag][indexPath.row]["product_original_cost_for_business"] as? String)!
        }


        let currency = productArray[tableView.tag][indexPath.row]["product_currency"] as? String
        
        let totalCost = "\(currency!)\(originalCost)"
        
        previousPrice.frame = CGRectMake(ABC1.frame.origin.x + (ABC1.frame.size.width/2), ABC1.frame.origin.y + ABC1.frame.size.height, 50, 30)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: totalCost)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        previousPrice.attributedText = attributeString
        previousPrice.textColor = ColorTheme().theme()
        previousPrice.font = UIFont(name: "Arial", size: 12.0)
        
        let newPrice = UILabel()
        
        var newCost = ""
       if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            newCost = (productArray[tableView.tag][indexPath.row]["product_discounted_cost_for_individual"] as? String)!
        }
        else
       {
          newCost = (productArray[tableView.tag][indexPath.row]["product_discounted_cost_for_business"] as? String)!
        }
        
        
        newPrice.frame = CGRectMake(previousPrice.frame.origin.x, previousPrice.frame.origin.y + (previousPrice.frame.size.height+2), 50, 30)
        newPrice.text = "\(currency!)\(newCost)"
        newPrice.font = UIFont(name: "Arial", size: 12.0)
        
        let addToCartLbl = UILabel()
        addToCartLbl.frame = CGRectMake(ABC3.frame.origin.x, incrementButton.frame.origin.y, 50, 30)
        addToCartLbl.text = "Add"
        addToCartLbl.textColor = ColorTheme().theme()
        addToCartLbl.textAlignment = NSTextAlignment.Center
        addToCartLbl.font = UIFont(name: "Arial", size: 14.0)
        addToCartLbl.layer.cornerRadius = addToCartLbl.frame.size.height/2
        addToCartLbl.layer.borderColor = ColorTheme().theme().CGColor
        addToCartLbl.layer.borderWidth = 1.0
        
        
        let cartImage = UIImageView()
        cartImage.frame = CGRectMake(addToCartLbl.frame.origin.x - (addToCartLbl.frame.size.width/1.5), addToCartLbl.frame.origin.y, 30, 30)
        cartImage.image = UIImage(named:"GrayCart")
        
        let addButton = UIButton()
        addButton.frame = CGRectMake(cartImage.frame.origin.x, cartImage.frame.origin.y - 3, cartImage.frame.size.width + addToCartLbl.frame.size.width + (addToCartLbl.frame.size.width/1.5) , addToCartLbl.frame.size.height + 3)
        addButton.tag = indexPath.row
        buttonTag = tableView.tag
//        addButton.addTarget(self, action: #selector(VegetablesDetailViewController.addToCart(_:)), forControlEvents: .TouchUpInside)
        
        addButton.addTarget(self, action:"addToCart:", forControlEvents: .TouchUpInside)
        
        //wrapperImage.addSubview(addButton)
        wrapperImage.addSubview(cartImage)
        wrapperImage.addSubview(addToCartLbl)
        wrapperImage.addSubview(newPrice)
        wrapperImage.addSubview(previousPrice)
        wrapperImage.addSubview(ABC3)
        wrapperImage.addSubview(ABC2)
        wrapperImage.addSubview(ABC1)
        wrapperImage.addSubview(incrementButton)
        wrapperImage.addSubview(qtyTextFld)
        wrapperImage.addSubview(decrementButton)
        wrapperImage.addSubview(productImage)
        cell.contentView.addSubview(wrapperImage)
        cell.contentView.addSubview(addButton)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    //MARK:- Add to cart button
    func addToCart(sender:UIButton)
    {
        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
        let ProductID = productArray[tableViews[sender.tag].tag][sender.tag]["product_id"] as! String
        addCart(ProductID)
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
    //MARK:- Product APi
    func productApi()
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
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_categories_products\(par)")!)
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
                self.CategoriesArray = dict!.valueForKey("categories") as! [Dictionary<String, AnyObject>]
                            self.scrollViewUI()
                            
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
    
    //MARK:-ADDCart
    func addCart(productID:String)
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
             let userID =  NSUserDefaults.standardUserDefaults().valueForKey("user_Id") as? String
           let par = NSString(format: "/%@/%@/%@/%@",deviceID,userID!,productID,"5")
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/add_to_cart\(par)")!)
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
                         let message = dict?.valueForKey("message") as! String
                        if success == "true"
                        {
                            progressHUD.hideAnimated(true)
                            let messageAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            messageAlert.addAction(defaultAction)
                            self.presentViewController(messageAlert, animated: true, completion: nil)
                        
                        }
                        else
                        {
                            
                            progressHUD.hideAnimated(true)
                           
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