import UIKit

var str = "Hello, playground"

//
//  contact.swift
//  FeastVite
//
//  Created by student on 6/24/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import Contacts


/*
 To import contacts from google and facebook
 Cotacts POC in Progress
 */

class ContactsDetails{
    
    static let shared = ContactsDetails()
    let contact = CNMutableContact()
    
    func addContact(){
        contact.givenName = "Susmitha"
        contact.familyName = "Kotyada"
        contact.emailAddresses = [CNLabeledValue(label: CNLabelHome, value: "kotyadasushmithad@gmail.com")]
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        try! store.execute(saveRequest)
        
        //formatting contact name
        let fullName = CNContactFormatter.string(from: contact, style: .fullName)
        
        //fetching contacts using keysToFetch
        var keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        //checking if email id is available for the given contact
        if(contact.isKeyAvailable(CNContactEmailAddressesKey)){
            print("\(contact.emailAddresses)")
        }
//        else{
//            keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey]
//            let refetchedContact = try store.unifiedContact(withIdentifier: contact.identifier, keysToFetch: keysToFetch as [CNKeyDescriptor])
//        }
        
        //saving the modfied contact
        let mutableContact = contact.mutableCopy() as! CNMutableContact
        let newEmail = CNLabeledValue(label: CNLabelHome, value: "sushmithad@gmail.com" as NSString)
        mutableContact.emailAddresses.append(newEmail)
        
        saveRequest.update(mutableContact)
        
        
        }
        
        
    
    }
    


//print(contc)
