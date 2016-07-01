//
//  ColorTheme.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 14/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class ColorTheme: NSObject
{

    
    func theme() -> UIColor
    {
        if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            return UIColor(red: 37/255, green: 167/255, blue: 158/255, alpha: 1.0)
        }
        else
        {
             return  UIColor(red: 132.0/255.0, green: 7.0/255, blue: 40.0/255, alpha: 1.0)
        }
        
    }
    
    func backGroundighlightedColor() -> UIColor
    {
        if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            return UIColor(red: 15/255, green: 175/255, blue: 151/255, alpha: 1.0)
            
        }
        else
        {
            return  UIColor(red: 132.0/255.0, green: 7.0/255, blue: 40.0/255, alpha: 1.0)
        }
    }
    
    func backGroundColor() -> UIColor
    {
        if NSUserDefaults.standardUserDefaults().boolForKey("isHome") == true
        {
            
            return UIColor(red: 14/255, green: 157/255, blue: 151/255, alpha: 1.0)
        }
        else
        {
            
            return  UIColor(red: 114/255.0, green: 16.0/255, blue: 41.0/255, alpha: 1.0)
        }
    }

}
