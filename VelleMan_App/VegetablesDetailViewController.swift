//
//  VegetablesDetailViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class VegetablesDetailViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate {
    var priceArray = NSMutableArray()
    var vegName = NSMutableArray()
    var vegArray = NSMutableArray()
    var cutPriceArray = NSMutableArray()
    @IBOutlet weak var vegCollectionView: UICollectionView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var vedView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var im2: UIImageView!
    @IBOutlet weak var totalOutstandingLbl: UILabel!
    @IBOutlet weak var vegTableView: UITableView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var vegScrollView: UIScrollView!
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var meatTableView: UITableView!
    @IBOutlet weak var dryFruitstableView: UITableView!
    @IBOutlet weak var fruitstableView: UITableView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var othersView: UIView!
    @IBOutlet weak var dryFruitsView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var fruitsView: UIView!
    @IBOutlet weak var vegetablesView: UIView!
    @IBOutlet weak var allProductView: UIView!
    @IBOutlet weak var othersImageView: UIImageView!
    @IBOutlet weak var allImageView: UIImageView!
    @IBOutlet weak var dryfruitsImage: UIImageView!
    @IBOutlet weak var fruitsImage: UIImageView!
    @IBOutlet weak var productScrollView: UIScrollView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var allBtnOutlet: UIButton!
    
    @IBOutlet weak var othersOutlet: UIButton!
    @IBOutlet weak var dryfruitsOutlet: UIButton!
    @IBOutlet weak var fruitsOutlet: UIButton!
    @IBOutlet weak var vegetableOutlet: UIButton!
    
    
    var QtyData = NSMutableArray()
    var i = 1
    var isThemeChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bottomView.frame.origin.y = self.view.frame.origin.y + self.view.frame.size.height + bottomView.frame.size.height
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            vegetableOutlet.titleLabel?.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            allBtnOutlet.titleLabel?.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            othersOutlet.titleLabel?.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            fruitsOutlet.titleLabel?.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            dryfruitsOutlet.titleLabel?.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            headerLbl.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 22)
            totalOutstandingLbl.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            nextBtn.titleLabel?.font = UIFont(name: (vegetableOutlet.titleLabel?.font.fontName)!, size: 20)
            
        }
       
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            isThemeChange = true
            
            headerImage.image = UIImage(named: "greenHeader")
            allBtnOutlet.backgroundColor = UIColor(red: 37/255, green: 167/255, blue: 158/255, alpha: 1.0)

            othersOutlet.backgroundColor = UIColor(red: 37/255, green: 167/255, blue: 158/255, alpha: 1.0)

            dryfruitsOutlet.backgroundColor = UIColor(red: 37/255, green: 167/255, blue: 158/255, alpha: 1.0)

            fruitsOutlet.backgroundColor = UIColor(red: 37/255, green: 167/255, blue: 158/255, alpha: 1.0)

            vegetableOutlet.backgroundColor =  UIColor(red: 37/255, green: 167/255, blue: 158/255, alpha: 1.0)
            
            
            
            vedView.backgroundColor = ColorTheme().backGroundColor()

            vegTableView.reloadData()

        }
    
        productTableView.backgroundView = UIImageView(image: UIImage(named: "LoginBackground"))
        vegTableView.backgroundView = UIImageView(image: UIImage(named: "LoginBackground"))
        fruitstableView.backgroundView = UIImageView(image: UIImage(named: "LoginBackground"))
        meatTableView.backgroundView = UIImageView(image: UIImage(named: "LoginBackground"))
        dryFruitstableView.backgroundView = UIImageView(image: UIImage(named: "LoginBackground"))
        
        vegScrollView.contentSize = CGSizeMake(vedView.frame.size.width, vegScrollView.frame.size.height)
        
        QtyData = [2,4,1,3]
        vegArray = ["VegImage1","vegImage2","vegImage4","vegImage3"]
        vegName = ["Bitter Gourd","Cabbage","Capsicum Green","Carrot-Red"]
        priceArray = [10.90,25.90,10.90,15.90]
        cutPriceArray = ["£15.90","£ 29.90","£ 15.90","£ 18.90"]
        productScrollView.delegate = self
        productScrollView.contentSize = CGSizeMake(self.view.frame.width * 5 , 0)
        
        let value = self.view.frame.size.width * CGFloat(i)
        
        let point = CGPointMake(self.view.frame.origin.x + value, 0)
        
        productScrollView.setContentOffset(point, animated: false)

        productImageView.image = UIImage(named:"img1")
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        vegTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        vegTableView.reloadData()
    }
    
    //MARK:- Back Button
    
    @IBAction func backBtn(sender: UIButton)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vegArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let vegCell = tableView.dequeueReusableCellWithIdentifier("VegetablesViewCell") as! VegetablesViewCell
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            vegCell.addtoCartButton.frame.size.height = 30
            vegCell.addtoCartButton.titleLabel?.font = UIFont(name: (vegCell.addtoCartButton.titleLabel?.font.fontName)!, size: 17)
            vegCell.previousPrice.font = UIFont(name: vegCell.previousPrice.font.fontName, size: 20)
            vegCell.newPrice.font = UIFont(name: vegCell.newPrice.font.fontName, size: 20)
            vegCell.productName.font = UIFont(name: vegCell.productName.font.fontName, size: 20)
            
        }
        
       
        let str = String(QtyData[indexPath.row])
        vegCell.qtyTextField.text = "Qty \(str)"
        vegCell.incrementButton.tag = indexPath.row
        vegCell.decrementButton.tag = indexPath.row
        vegCell.addtoCartButton.tag = indexPath.row
        
        vegCell.backgroundColor = UIColor.clearColor()

        vegCell.productImage.image = UIImage(named: vegArray[indexPath.row] as! String)
        
        vegCell.no112.layer.borderWidth = 1
        
        vegCell.no112.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        vegCell.no113.layer.borderWidth = 1
        vegCell.no113.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        vegCell.no114.layer.borderWidth = 1
        
        let color = ColorTheme()
        
        
        vegCell.no114.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        vegCell.addtoCartButton.layer.borderWidth = 1
        vegCell.addtoCartButton.layer.cornerRadius = vegCell.addtoCartButton.frame.size.height/2
        
        vegCell.addtoCartButton.titleLabel?.textColor = color.theme()
        vegCell.addtoCartButton.layer.borderColor = color.theme().CGColor
        vegCell.previousPrice.textColor = color.theme()
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (cutPriceArray[indexPath.row] as? String)!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        vegCell.previousPrice.attributedText = attributeString
        
        vegCell.productName.text = vegName[indexPath.row] as? String
        
        let d = String(priceArray[indexPath.row] as! Float)
        
        vegCell.newPrice.text = "£\(d)"
        
        
        return vegCell
    }
    
    //MARK:- Collection View Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return vegArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let vegCell = collectionView.dequeueReusableCellWithReuseIdentifier("vegCell", forIndexPath: indexPath) as! VegetableDetailCollectionViewCell
        vegCell.vegImageView.image = UIImage(named: vegArray[indexPath.row] as! String)
        
        
        
        vegCell.NoLbl1.layer.borderWidth = 1
        vegCell.NoLbl1.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        vegCell.NoLbl2.layer.borderWidth = 1
        vegCell.NoLbl2.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        vegCell.NoLbl3.layer.borderWidth = 1
         vegCell.NoLbl3.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        vegCell.addBtn.layer.borderWidth = 1
        vegCell.addBtn.layer.cornerRadius = 8
        vegCell.addBtn.layer.borderColor = UIColor(red: 120.0/255, green: 17.0/255, blue: 39.0/255, alpha: 1.0).CGColor
        vegCell.viewCOntent.layer.cornerRadius = 5
        vegCell.vegName.text = vegName[indexPath.row] as? String
        vegCell.priceLbl.text = priceArray[indexPath.row] as? String
        
        return vegCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.view.frame.size.width/2.1, self.view.frame.size.width/2.5)
    }
    
    //    MARK :- Scroll View Delegates
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if scrollView == productScrollView
        {
            let page = scrollView.contentOffset.x / scrollView.frame.size.width
            
            print(page)
            
            if page == 0
            {
                allTab(UIButton)
            }
            else if page == 1
            {
                vegetablesTab(UIButton)
                let point = CGPointMake(0, 0)
                
                vegScrollView.setContentOffset(point, animated: true)
            }
            else if page == 2
            {
                fruitsTab(UIButton)
            }
            else if page == 3
            {
                dryfrutsTab(UIButton)
                let point = CGPointMake(self.dryfruitsOutlet.frame.size.width, 0)
                
                vegScrollView.setContentOffset(point, animated: true)
            }
            else if page == 4
            {
                othersTab(UIButton)
                
                let point = CGPointMake(self.dryfruitsOutlet.frame.size.width, 0)
                
                vegScrollView.setContentOffset(point, animated: true)
            }
         }
    }
    
    //MARK:- Next Button
    
    @IBAction func nextBtn(sender: UIButton)
    {
        
        addItemToCart()
        
        
        
    }
    
     // MARK:- Scroll View Tabs Buttons

    @IBAction func vegetablesTab(sender: AnyObject)
    {
     // vegCollectionView.frame.origin.x = (self.view.frame.size.width + 1.0)
      
            vegetableOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
       
        
        
        allBtnOutlet.backgroundColor = UIColor.clearColor()
        dryfruitsOutlet.backgroundColor = UIColor.clearColor()
        fruitsOutlet.backgroundColor = UIColor.clearColor()
        othersOutlet.backgroundColor = UIColor.clearColor()
        
        let pointx = CGPointMake(self.allProductView.frame.origin.x + self.allProductView.frame.size.width, 0)
        
        productScrollView.setContentOffset(pointx, animated: true)
        
        
        let point = CGPointMake(0, 0)
        
        vegScrollView.setContentOffset(point, animated: true)
        
    }
    
    
    @IBAction func othersTab(sender: AnyObject)
    {
        
        let pointx = CGPointMake(self.dryFruitsView.frame.origin.x + self.dryFruitsView.frame.size.width, 0)
        
        productScrollView.setContentOffset(pointx, animated: true)
      
        othersOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        
        allBtnOutlet.backgroundColor = UIColor.clearColor()
        dryfruitsOutlet.backgroundColor = UIColor.clearColor()
        fruitsOutlet.backgroundColor = UIColor.clearColor()
        vegetableOutlet.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func dryfrutsTab(sender: AnyObject)
    {
        let pointx = CGPointMake(self.fruitsView.frame.origin.x + self.fruitsView.frame.size.width, 0)
        
        productScrollView.setContentOffset(pointx, animated: true)
        
        dryfruitsOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        
        allBtnOutlet.backgroundColor = UIColor.clearColor()
        vegetableOutlet.backgroundColor = UIColor.clearColor()
        fruitsOutlet.backgroundColor = UIColor.clearColor()
        othersOutlet.backgroundColor = UIColor.clearColor()
        let point = CGPointMake(self.dryfruitsOutlet.frame.size.width, 0)
        
        vegScrollView.setContentOffset(point, animated: true)
    }
    
    @IBAction func allTab(sender: AnyObject)
    {
        
        let pointx = CGPointMake(0, 0)
        
        productScrollView.setContentOffset(pointx, animated: true)
        
        allBtnOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
       
        vegetableOutlet.backgroundColor = UIColor.clearColor()
        dryfruitsOutlet.backgroundColor = UIColor.clearColor()
        fruitsOutlet.backgroundColor = UIColor.clearColor()
        othersOutlet.backgroundColor = UIColor.clearColor()
        
    }
   
    @IBAction func fruitsTab(sender: AnyObject)
    {
        let pointx = CGPointMake(self.vegetablesView.frame.origin.x + self.vegetablesView.frame.size.width, 0)
        
        productScrollView.setContentOffset(pointx, animated: true)
        
        allBtnOutlet.backgroundColor = UIColor.clearColor()
        dryfruitsOutlet.backgroundColor = UIColor.clearColor()
        vegetableOutlet.backgroundColor = UIColor.clearColor()
        othersOutlet.backgroundColor = UIColor.clearColor()
        
        fruitsOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
       
        let point = CGPointMake(0, 0)
        
        vegScrollView.setContentOffset(point, animated: true)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func addToCartButton(sender: AnyObject)
    {
        
        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
            UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations:
                {
                    
                    let price =  self.QtyData.objectAtIndex(sender.tag) as! Double
                    
                    let data = self.priceArray.objectAtIndex(sender.tag) as! Double
                    print(price)
                    print(data)
                    let  totalPrice = price*Double(data)
                    
                    self.totalOutstandingLbl.text = "Total Outstanding : £\(totalPrice)"
                    
                    self.bottomView.frame.origin.y = self.view.frame.origin.y + self.view.frame.size.height - self.bottomView.frame.size.height
            }) { (finished) in
                print("finished")
            }

        }
        else
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "Please Login or register first!", preferredStyle: .Alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                
            }
            let loginAction: UIAlertAction = UIAlertAction(title: "Login", style: .Default) { action -> Void in
                
                
                let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                
                self.navigationController?.pushViewController(loginVc, animated: true)
                
            }
            let signupAction: UIAlertAction = UIAlertAction(title: "Register", style: .Default) { action -> Void in
                
                let SignUp = self.storyboard?.instantiateViewControllerWithIdentifier("businessSignUp") as! BusinessSignUpViewController
                SignUp.signUpBool = false
                
                self.navigationController?.pushViewController(SignUp, animated: true)
                
            }
            
            
            actionSheetController.addAction(cancelAction)
            actionSheetController.addAction(loginAction)
            actionSheetController.addAction(signupAction)
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        }
        
    }
    
    
    
    //MARK:- Add item to Cart
    // add device_id , user_id and product_id  i havn't implemeted that
    func addItemToCart()
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
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/add_to_cart/device_id_or_token/user_id/product_id\(par)")!)
            
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
    

    @IBAction func decrementProductCount(sender: AnyObject)
    {
        var Str = QtyData.objectAtIndex(sender.tag) as! Int
        
        if Str != 0
        {
            Str -= 1
            QtyData.replaceObjectAtIndex(sender.tag, withObject: Str)
        }
        
        dryFruitstableView.reloadData()
        meatTableView.reloadData()
        productTableView.reloadData()
        vegTableView.reloadData()
        fruitstableView.reloadData()
    }
    
    @IBAction func incrementProductCount(sender: AnyObject)
    {
        var Str = QtyData.objectAtIndex(sender.tag) as! Int
        
        Str += 1
        QtyData.replaceObjectAtIndex(sender.tag, withObject: Str)
        
        dryFruitstableView.reloadData()
        meatTableView.reloadData()
        productTableView.reloadData()
        vegTableView.reloadData()
        fruitstableView.reloadData()
    }
    
    
}