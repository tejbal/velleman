//
//  CurrentOrderViewController.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class CurrentOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var currentOrderTableView: UITableView!
    
    @IBOutlet weak var headerImage: UIImageView!
    var invoice = NSMutableArray()
    var quantity = NSMutableArray()
    var productName = NSMutableArray()
    var productImage = NSMutableArray()
    var paidStatus = NSMutableArray()
    var priceLbl = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
         currentOrderTableView.tableFooterView = UIView(frame: CGRectZero)
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true)
        {
            self.tabBarController?.tabBar.backgroundImage = UIImage(named: "themefooter")
            headerImage.image = UIImage(named: "greenHeader")
        }
        
        
        let mh = MenuHandler()
        mh.addMenuButton(self.view)
        
        currentOrderTableView.delegate = self
        currentOrderTableView.dataSource = self
        
        invoice = ["Invoice 00004","Invoice 00003","Invoice 00002","Invoice 00001"]
         productName = ["Capsicum","Carrot - Red","Bitter gourd","Cabage"]
        productImage = ["vegImage4","vegImage3","VegImage1","vegImage2"]
        quantity = ["250 gms","300 gms","1 kg","500 gms"]
        
       
        paidStatus = ["PENDING","PAID","PAID","PAID"]
        
        priceLbl = ["£15.90","£ 29.90","£ 15.90","£ 18.90"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        currentOrderTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        currentOrderTableView.reloadData()
        
//        self.tabBarController!.tabBar.hidden = false
    }
    
    // MARK:- UITableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productImage.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let currentOrder = tableView.dequeueReusableCellWithIdentifier("currentOrderCell")  as! currentOrderCell
        
        currentOrder.cancelOrderLabel.textColor = ColorTheme().theme()
        currentOrder.cancelOrder.tag = indexPath.row
     
       
        
        currentOrder.productInvoice.text = invoice[indexPath.row] as? String
        currentOrder.paidStatus.text = paidStatus[indexPath.row] as? String
        currentOrder.quantity.text = quantity[indexPath.row] as? String
        currentOrder.orderName.text = productName[indexPath.row] as? String
        currentOrder.priceLbl.text = priceLbl[indexPath.row]  as? String
        currentOrder.currentOrderImage.image =  UIImage(named: productImage[indexPath.row] as! String)
        
        return currentOrder
        
    }
    
    //MARK :- Cancel Order Button
    @IBAction func cancelorderButton(sender: AnyObject)
    {
        
        productImage.removeObjectAtIndex(sender.tag)
        
        currentOrderTableView.tableFooterView = UIView(frame: CGRectZero)
        
        currentOrderTableView.reloadData()
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
