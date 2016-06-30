//
//  CartViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var totalOutstandingLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var bottomview: UIImageView!
    @IBOutlet weak var headerimage: UIImageView!
    var vegName = NSMutableArray()
    var vegArray = NSMutableArray()
    var priceArray = NSMutableArray()
    var cutPriceArray = NSMutableArray()
    @IBOutlet weak var cartTableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            
            headerLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            totalOutstandingLbl.font = UIFont(name: headerLbl.font.fontName, size: 20)
            nextBtn.titleLabel!.font = UIFont(name: headerLbl.font.fontName, size: 20)
            
        }
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            headerimage.image = UIImage(named: "greenHeader")
        }
        
        vegArray = ["VegImage1","vegImage2","vegImage3","vegImage4","VegImage1","vegImage2"]
        vegName = ["Bitter Gourd","Cabbage","Capsicum Green","Carrot-Red","Bitter Gourd","Cabbage"]
        priceArray = ["£10.00","£ 15.00","£ 10.00","£ 10.00","£ 15.00","£ 10.00"]
        cutPriceArray = ["£ 15.90","£ 20.90","£ 15.90","£ 15.90","£ 20.90","£ 15.90"]
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    //MARK :- Tableview DataSource
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            return 150
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
        let VegCell = tableView.dequeueReusableCellWithIdentifier("VegCell") as! ProductCell
        
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad
        {
            VegCell.vegName.font = UIFont(name: VegCell.vegName.font.fontName, size: 18)
            VegCell.priceLbl.font = UIFont(name: VegCell.vegName.font.fontName, size: 18)
            VegCell.cutPriceLbl.font = UIFont(name: VegCell.vegName.font.fontName, size: 18)
           
        }
        
        VegCell.vegImage.image = UIImage(named: vegArray[indexPath.row] as! String)
        VegCell.vegName.text = vegName[indexPath.row] as? String
        VegCell.priceLbl.text = priceArray[indexPath.row] as? String
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (cutPriceArray[indexPath.row] as? String)!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        VegCell.cutPriceLbl.attributedText = attributeString
        VegCell.NumberLbl1.layer.borderWidth = 1
        VegCell.NumberLbl1.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        VegCell.noLbl2.layer.borderWidth = 1
        VegCell.noLbl2.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor
        VegCell.noLbl3.layer.borderWidth = 1
        VegCell.noLbl3.layer.borderColor = UIColor(red: 173.0/255, green: 173.0/255, blue: 173.0/255, alpha: 1.0).CGColor

        return VegCell
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

    //MARK:- Back Button
    
    @IBAction func backBtn(sender: UIButton)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- Next Button
    
    @IBAction func nextBtn(sender: UIButton)
    {
        let Address = storyboard?.instantiateViewControllerWithIdentifier("AddressListViewController") as! AddressListViewController
        self.navigationController?.pushViewController(Address, animated: true)
    }
   
}
