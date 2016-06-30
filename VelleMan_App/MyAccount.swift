//
//  myAccount.swift
//  VelleMan_App
//
//  Created by Jarvics  on 27/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class MyAccount: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        getUserProfileapi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
    //MARK:- GetUserProfile Api
    func getUserProfileapi()
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
            
            
            
            
            
            
            let request = NSMutableURLRequest(URL:NSURL(string: "http://omninos.in/velleman/index.php/Api/get_user_profile/2")!)

            
            request.HTTPMethod = "GET"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in

                dispatch_async(dispatch_get_main_queue(),{
                    let dict :NSDictionary?
                    do
                    {
                        dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                        
                        print("ASynchronous\(dict)")
                        let success = dict?.valueForKey("success") as! String
                        print(success)
                        if success == "True"
                        {
                            
                            
                        }
                        else
                        {
                            
                            progressHUD.hideAnimated(true)
                            progressHUD.hidden = true
                            
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
                        progressHUD.hidden = true
                        print(error.localizedDescription)
                    }
                })
            })
            task.resume()

        }
    }
    
    //MARK:- Back Button
    
    @IBAction func backBtn(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
