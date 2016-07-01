//
//  MenuHandler.swift
//  VelleMan_App
//
//  Created by Jarvics on 03/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit


var globalMenuView = UIView()
var globalInnerMenuView = UIView()
var currentView = UIView()
var globalMenuButton = UIButton()


class MenuHandler: NSObject {
    func createMenu(target: SpecialDealsViewController, menuView: UIView, innerMenuView: UIView, menuBtn: UIButton){

        var isMenuAlreadyAdded = false
        
        for view in (UIApplication.sharedApplication().keyWindow?.subviews)!
        {
            if view.isKindOfClass(UIView)
            {
                if view == globalMenuView
                {
                    isMenuAlreadyAdded = true
                }
            }
        }
        if isMenuAlreadyAdded == false
        {
            globalMenuView = menuView
            globalInnerMenuView = innerMenuView
            currentView = target.view
            globalMenuButton = menuBtn
            
            globalInnerMenuView.backgroundColor = ColorTheme().theme()
            
            globalMenuButton.addTarget(target, action: "menuAction:", forControlEvents: UIControlEvents.TouchUpInside)
          
                  UIApplication.sharedApplication().keyWindow?.backgroundColor = ColorTheme().theme()
            
            UIApplication.sharedApplication().keyWindow?.addSubview(globalMenuView)
            globalMenuView.frame.origin.x = -(globalMenuView.frame.size.width + target.view.frame.origin.x)
        }
        else
        {
            print("Menu Already created")
        }

    }
    
    func addMenuButton(view:UIView)
    {
        
        currentView = view
        
        globalInnerMenuView.backgroundColor = ColorTheme().theme()
          UIApplication.sharedApplication().keyWindow?.backgroundColor = ColorTheme().theme()
        
        var isMenuButtonAdded = false
        
        for view in view.subviews
        {
            if view.isKindOfClass(UIButton)
            {
                if view as! UIButton == globalMenuButton
                {
                    isMenuButtonAdded = true
                }
            }

        }
        
        if isMenuButtonAdded == false
        {
            view.addSubview(globalMenuButton)
        }
        else
        {
            print("Menu Button Already Added")
        }
    }
    
}
