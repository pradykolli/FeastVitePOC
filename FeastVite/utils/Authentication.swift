//
//  Authentication.swift
//  FeastVite
//
//  Created by Student on 6/26/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

class Authentication{
    
    private static var _shared:Authentication!
    static var shared:Authentication{
        if _shared == nil{
            _shared = Authentication()
        }
        return _shared
    }
    
    
    var navigationController = UINavigationController()
    func validUserHomePage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userHome = storyboard.instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
        UIApplication.shared.delegate?.window??.rootViewController?.navigationController?.pushViewController(userHome, animated: true)
    }
    func forgotPasswordPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resetPasswordController = storyboard.instantiateViewController(withIdentifier: "forgotPasswordPage") as! ResetPasswordViewController
       UIApplication.shared.delegate?.window??.rootViewController = resetPasswordController
    }
    func mainHomePage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainHomePage = storyboard.instantiateViewController(withIdentifier: "home") as! UINavigationController
        UIApplication.shared.delegate?.window??.rootViewController = mainHomePage
    }
    
}
