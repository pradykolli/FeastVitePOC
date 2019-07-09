//
//  RegistrationViewController.swift
//  FeastVite
//
//  Created by student on 6/13/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var showHidePassword: UIImageView!
    @IBOutlet weak var showHideConfirmPassword: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    static let shared = RegistrationViewController()
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var emailErrorLBL: UILabel!
    @IBOutlet weak var passwordErrorLBL: UILabel!
    @IBOutlet weak var conPasswordErrorLBL: UILabel!
    var backendless:Backendless?
    var alertErrors:AlertErrors = AlertErrors()
    @IBOutlet weak var signUpBTN: UIButton!
    
    @IBOutlet weak var resendBTN: UIButton!
    private var isAdding : Bool = true
    private var user : UserModel?
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPasswordTapped(_:)))
        showHidePassword.addGestureRecognizer(tap)
        showHidePassword.isUserInteractionEnabled = true
        let tapConfirm = UITapGestureRecognizer(target: self, action: #selector(showConfirmPasswordTapped(_:)))
        showHideConfirmPassword.addGestureRecognizer(tapConfirm)
        showHideConfirmPassword.isUserInteractionEnabled = true
        super.viewDidLoad()
        navigationItem.title = "SignUp"
        backendless = Backendless.sharedInstance()
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmPasswordTF.delegate = self
        confirmPasswordTF.returnKeyType = .done
        resendBTN.isHidden = true
        passwordErrorLBL.isHidden = true
        emailErrorLBL.isHidden = true
        conPasswordErrorLBL.isHidden = true
        backgroundView.layer.cornerRadius = 15
        emailTF.layer.cornerRadius = 15
        passwordTF.layer.cornerRadius = 15
        confirmPasswordTF.layer.cornerRadius = 15
        resendBTN.layer.cornerRadius = 15
        signUpBTN.layer.cornerRadius = 15
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    //Validation the password to meet the password requirements.
    func isValidPaasword(strValue: String) -> Bool {
        let stricterFilterString = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,16}$"
        let passwordValidator = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
        let isValid: Bool = passwordValidator.evaluate(with: strValue)
        return isValid
    }
    //Added functionality to diplay password when clicked on show password icon.
    @objc func showPasswordTapped(_ sender: UIImageView){
        if (passwordTF.text?.isEmpty)!{
            self.passwordTF.isSecureTextEntry = true
        }else{
            if passwordTF.isSecureTextEntry{
                self.passwordTF.isSecureTextEntry = false
            }else{
                self.passwordTF.isSecureTextEntry = true
            }
        }
        
    }
    //Added functionality to diplay confirm password when clicked on show confirm password icon.
    @objc func showConfirmPasswordTapped(_ sender: UIImageView){
        if (confirmPasswordTF.text?.isEmpty)!{
            self.confirmPasswordTF.isSecureTextEntry = true
        }else{
            if confirmPasswordTF.isSecureTextEntry{
                self.confirmPasswordTF.isSecureTextEntry = false
            }else{
                self.confirmPasswordTF.isSecureTextEntry = true
            }
        }
        
    }
    
    //Functionality to check whether email id is provided or not, password requirements should be met to create a valid password, and confirm password should be same as the given password.
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case emailTF:
            if (emailTF.text?.isEmpty)!{
                emailErrorLBL.isHidden = false
                self.emailErrorLBL.text = "Please enter Email"
            }else{
                emailTF.returnKeyType = .continue
                emailErrorLBL.isHidden = true
            }
            passwordTF.becomeFirstResponder()
        case passwordTF:
            if !isValidPaasword(strValue: passwordTF.text!){
                self.passwordErrorLBL.isHidden = false
                self.passwordErrorLBL.textColor = UIColor.red
                self.passwordErrorLBL.text = "Minimum 8 and Maximum 16 characters at least 1 Alphabet, 1 Number and 1 Special Character"
                
            }else{
                passwordTF.returnKeyType = .continue
                self.passwordErrorLBL.isHidden = true
            }
            confirmPasswordTF.becomeFirstResponder()
        case confirmPasswordTF:
            if passwordTF.text == confirmPasswordTF.text{
                self.conPasswordErrorLBL.isHidden = true
            }else{
                confirmPasswordTF.returnKeyType = .done
                conPasswordErrorLBL.isHidden = false
                self.conPasswordErrorLBL.text = "Passwords Must Match"
            }
            
            
        default:
            emailTF.becomeFirstResponder()
        }
    }
    
    
    /*
     Registration Form for User
    */
    
    
    
    
    @IBAction func signUpBTN(_ sender: Any) {

        if !emailErrorLBL.isHidden || !passwordErrorLBL.isHidden || !conPasswordErrorLBL.isHidden{
            self.signUpBTN.isEnabled = false
            self.signUpBTN.backgroundColor = UIColor.gray
        }else{
        let user = BackendlessUser()
        user.email = emailTF.text! as NSString
        user.password = passwordTF.text! as NSString
        backendless?.userService.register(user, response: { (user) in
            self.alertErrors.displayAlert("Confirmation mail sent", "Please check inbox for confirmation link")
            self.resendBTN.isHidden = false
        }, error: { (fault:Fault?) in
            self.alertErrors.displayAlert("Registration Error", (fault?.message)!)
        })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF{
            confirmPasswordTF.becomeFirstResponder()
        }
        else if textField == confirmPasswordTF{
            confirmPasswordTF.resignFirstResponder()
        }
        return true
    }
    // Resend Mail Confirmation for registration Successful
    
    @IBAction func resendEmailConfirmation(_ sender:Any){
        backendless?.userService.resendEmailConfirmation(emailTF.text!, response: {
            self.alertErrors.displayAlert("reconfirmation mail sent", "Please check inbox for confirmation mail")
        }, error: { (fault:Fault?) in
            self.alertErrors.displayAlert("Server Error", (fault?.message)!)
        })
    }

}
