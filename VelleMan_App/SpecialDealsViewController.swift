//
//  SpecialDealsViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 31/05/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class SpecialDealsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate
{
    
    @IBOutlet weak var dealsOutlet: UIButton!
    @IBOutlet weak var categoryOutlet: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var innerMenuView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var dealCateView: UIView!
    @IBOutlet weak var loginNdRegstView: UIView!
    @IBOutlet weak var productTableView: UITableView!
    
    var categoryImages = NSMutableArray()
    var categoryNames = NSMutableArray()
    var categoryDetail = NSMutableArray()
    
    var loginBool = Bool()
    
    var tabBar:UITabBar?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
      let str  = UIDevice.currentDevice().identifierForVendor!.UUIDString
        print(str)
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            
           categoryOutlet.titleLabel?.font = UIFont(name: (categoryOutlet.titleLabel?.font.fontName)!, size: 20)
            dealsOutlet.titleLabel?.font = UIFont(name: (dealsOutlet.titleLabel?.font.fontName)!, size: 20)
            
            headerLbl.font = UIFont(name:headerLbl.font.fontName, size: 22)
            
        }
        
        categoryImages = ["img","img1","img2","img3"]
        categoryNames = ["Fruits","Vegetables","Dryfruits","Meat"]
        categoryDetail = ["Apple,Gooseberry,Amla,Grapes","our most sold products","our most sold products","our most sold products"]
        
       
    if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
            productTableView.frame = CGRectMake(productTableView.frame.origin.x, loginNdRegstView.frame.origin.y , productTableView.frame.size.width, productTableView.frame.size.height + loginNdRegstView.frame.size.height)
            loginNdRegstView.hidden = true
            
            if (NSUserDefaults.standardUserDefaults().boolForKey("isHome"))
            {
                self.tabBarController?.tabBar.backgroundImage = UIImage(named: "themefooter")
                headerImage.image = UIImage(named: "greenHeader")
                dealsOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
                categoryOutlet.backgroundColor = ColorTheme().backGroundColor()
               
                
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillAppear(animated: Bool) {
        let mh = MenuHandler()
        mh.createMenu(self, menuView: menuView, innerMenuView: innerMenuView, menuBtn: menuBtn)
        
        mh.addMenuButton(self.view)
    }
    
    //MARK :- Tableview DataSource
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            return 300.0
        }
        else
        {
            return 183
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return categoryNames.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductCell
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            cell.categoryName.font = UIFont(name: cell.categoryName.font.fontName, size: 25)
            
            cell.categoryDetail.font = UIFont(name: cell.categoryName.font.fontName, size: 20)

            
        }
        
        
        cell.categoryImageView.image = UIImage(named: categoryImages[indexPath.row] as! String)
        cell.categoryName.text = categoryNames[indexPath.row] as? String
        cell.categoryDetail.text = categoryDetail[indexPath.row] as? String
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let detail = storyboard?.instantiateViewControllerWithIdentifier("detail") as! VegetablesDetailViewController
        
        if indexPath.row == 0
        {
            print(detail.i)
            detail.i = 2
        }
        if indexPath.row == 1
        {
            detail.i = 1
        }
        if indexPath.row == 2
        {
            detail.i = 3
        }
        if indexPath.row == 3
        {
            detail.i = 4
        }
 
        self.navigationController?.pushViewController(detail, animated: true)
    }
    //MARK:- Menu Button
    
    @IBAction func menuBtn(sender: UIBarButtonItem)
    {
        print("hello")
    }
    //MARK:- Login Button

    @IBAction func loginBtn(sender: AnyObject)
    {
        let loginVc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
      //  NSUserDefaults.standardUserDefaults().setBool(true, forKey: "login")
        self.navigationController?.pushViewController(loginVc, animated: false)
    }
    //MARK:- Register Button
    
    @IBAction func registerBtn(sender: AnyObject)
    {
        let SignUp = storyboard?.instantiateViewControllerWithIdentifier("businessSignUp") as! BusinessSignUpViewController
          SignUp.signUpBool = false
         //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "login")
        self.navigationController?.pushViewController(SignUp, animated: false)
    }
    
    //MARK:- Menu Action
    
    @IBAction func menuAction(sender: UIButton)
    {
        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
            UIView.animateWithDuration(0.2, animations: {
                globalMenuView.frame.origin.x = 0
                currentView.frame.origin.x =  globalInnerMenuView.frame.width
                self.tabBarController?.tabBar.frame.origin.x = globalInnerMenuView.frame.width
            })
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
    
    @IBAction func hideMenuAction(sender: UIButton) {
        
        UIView.animateWithDuration(0.2, animations: {
            globalMenuView.frame.origin.x = -self.view.frame.width
            currentView.frame.origin.x =  0
            self.tabBarController?.tabBar.frame.origin.x = 0
        })
    }
    
    //MARK:- Shopping Cart Button
    
    @IBAction func cartButton(sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 2
    }
    
    //MARK:- Menu Button Action
    @IBAction func orderHistoryBtn(sender: UIButton)
    {
        
        hideMenuAction(sender)

        
        let tabBar = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
        
        
        tabBar.selectedIndex = 3
        self.navigationController?.pushViewController(tabBar, animated: false)
    }
    
    @IBAction func logOutBtn(sender: AnyObject)
    {
        hideMenuAction(sender as! UIButton)
        let tabBar = storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginHomeBusiness")
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isHome")
        tabBar.selectedIndex = 0
        self.navigationController?.pushViewController(tabBar, animated: false)
    }
    
    @IBAction func specialDealsBtn(sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func changePasswordBtn(sender: AnyObject)
    {
        let changePWDVC = self.storyboard?.instantiateViewControllerWithIdentifier("ChangePassword") as! ChangePassword
        
        hideMenuAction(sender as! UIButton)
        
        self.navigationController?.pushViewController(changePWDVC, animated: true)
    }
    
    
    @IBAction func ProfilrBtn(sender: AnyObject)
    {
        let myAccount = self.storyboard?.instantiateViewControllerWithIdentifier("MyAccount") as! MyAccount
        
        hideMenuAction(sender as! UIButton)
        self.navigationController?.pushViewController(myAccount, animated: true)
    }
    
    
}
