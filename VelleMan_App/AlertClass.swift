//
//  AlertClass.swift
//  VelleMan_App
//
//  Created by Jarvics  on 23/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class AlertClass: NSObject
{
    func alert(title:String,message:String,buttonTitle:String ) -> UIAlertController
    {
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
            alert.addAction(UIAlertAction(title: buttonTitle, style: .Default, handler: { (action: UIAlertAction) in
                
            }))
        

        return alert
        
    }

}
