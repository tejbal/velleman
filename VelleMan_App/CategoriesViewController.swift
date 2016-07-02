//
//  CategoriesViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tabbar: UITabBarItem!
    var categoryImages = NSMutableArray()
    var categoryNames = NSMutableArray()
    var categoryDetail = NSMutableArray()
    
    @IBOutlet weak var registerOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headeLbl: UILabel!
    @IBOutlet weak var loginndregisterView: UIView!
    @IBOutlet weak var dealsOutlet: UIButton!
    @IBOutlet weak var categoryOutlet: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryOutlet.backgroundColor = ColorTheme().backGroundighlightedColor()
        dealsOutlet.backgroundColor = ColorTheme().backGroundColor()
        
        let mh = MenuHandler()
        mh.addMenuButton(self.view)
        
        if NSUserDefaults.standardUserDefaults().boolForKey("loginHomeBusiness")
        {
            tableView.frame = CGRectMake(tableView.frame.origin.x, loginndregisterView.frame.origin.y , tableView.frame.size.width, tableView.frame.size.height + loginndregisterView.frame.size.height)
            loginndregisterView.hidden = true
            if (NSUserDefaults.standardUserDefaults().boolForKey("isHome"))
            {
                self.tabBarController?.tabBar.backgroundImage = UIImage(named: "themefooter")
                headerImage.image = UIImage(named: "greenHeader")
            }

        }
        
        
        categoryImages = ["img","img1","img2","img3"]
        categoryNames = ["Fruits","Vegetables","Dryfruits","Meat"]
        categoryDetail = ["Apple,Gooseberry,Amla,Grapes","our most sold products","our most sold products","our most sold products"]
        
    }

    override func viewWillAppear(animated: Bool)
    {
       
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as! ProductCell
        
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
        self.navigationController?.pushViewController(detail, animated: true)
    }

    
    @IBAction func signupBtn(sender: AnyObject)
    {
        let signUpVc = self.storyboard?.instantiateViewControllerWithIdentifier("businessSignUp") as! BusinessSignUpViewController
        signUpVc.signUpBool = false
            self.navigationController?.pushViewController(signUpVc, animated: false)
    }
    
    @IBAction func dealsBtn(sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func loginBtn(sender: AnyObject)
    {
        let loginVC = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
       
       
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
}
