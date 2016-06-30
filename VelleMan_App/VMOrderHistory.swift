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
        
        let mh = MenuHandler()
        mh.addMenuButton(self.view)
        
        invoiceName = ["Invoice 00004","Invoice 00003","Invoice 00002","Invoice 00001"]
        image = ["paypal","paypal","paypal","paypal"]
        dateLbl = ["29 march 2016","29 march 2016","29 march 2016","29 march 2016"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
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

   //MARK:- Menu Action
    
    
    
    
}
