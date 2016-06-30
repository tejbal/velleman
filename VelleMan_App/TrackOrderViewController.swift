//
//  TrackOrderViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class TrackOrderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var headerImage: UIImageView!

    @IBOutlet weak var trackOrderTableView: UITableView!
    
    @IBOutlet weak var headerLbl: UILabel!
    
    var orderImage = NSMutableArray()
    var orderStatus = NSMutableArray()
    var orderName = NSMutableArray()
    var orderInvoice = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       trackOrderTableView.tableFooterView = UIView(frame: CGRectZero)
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            headerLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            
            
        }
        
        let mh = MenuHandler()
        mh.addMenuButton(self.view)
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            self.tabBarController?.tabBar.backgroundImage = UIImage(named: "themefooter")
            headerImage.image = UIImage(named: "greenHeader")
        }
        trackOrderTableView.separatorStyle = .None
        
        orderInvoice = ["Invoice 00004","Invoice 00003","Invoice 00002","Invoice 00001"]
        orderName = ["Capsicum","Carrot - Red","Bitter gourd","Cabage"]
        orderImage = ["vegImage4","vegImage3","VegImage1","vegImage2"]
        orderStatus = ["Packed","Shipped","Delivered","Delivered"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK :- UITableView DataSource
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            return 180
        }
        else
        {
            return 109
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderImage.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentOrder = tableView.dequeueReusableCellWithIdentifier("trackOrderCell")  as! trackOrderCell
  
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            currentOrder.orderInvoice.font = UIFont(name: currentOrder.orderInvoice.font.fontName, size: 18)
            currentOrder.trackStatus.font = UIFont(name: currentOrder.trackStatus.font.fontName, size: 18)
            currentOrder.orderName.font = UIFont(name: currentOrder.orderName.font.fontName, size: 18)
        }
        currentOrder.selectionStyle = .None
        currentOrder.orderInvoice.text = orderInvoice[indexPath.row] as? String
       
         
        currentOrder.orderName.text = orderName[indexPath.row] as? String
        currentOrder.trackStatus.text = orderStatus[indexPath.row]  as? String
        currentOrder.orderImage.image =  UIImage(named: orderImage[indexPath.row] as! String)
        currentOrder.wrapperView.layer.cornerRadius = 4
        currentOrder.wrapperView.layer.borderWidth = 1
        currentOrder.wrapperView.layer.borderColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1.0).CGColor
        currentOrder.wrapperView.layer.masksToBounds = true
        
        
        return currentOrder
        
    }


 
}
