//
//  Errors.swift
//  FeastVite
//
//  Created by Student on 6/21/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//
// Satyakanth kolakani
import Foundation
import UIKit

class AlertErrors {
    
    static let shared = AlertErrors()
    
    func displayAlert(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.delegate?.window??.rootViewController!.present(alert, animated: true, completion: nil)
    }
  }
