//
//  LoginViewController.swift
//  FeastVite
//
//  Created by student on 6/14/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit
var vSpinner:UIView?
// An extension to hide keyboard whenever we click anywhere except the text field.
// Also to show and hide spinners as an indicator for loading - Pradeep kolli
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.gray.withAlphaComponent(0.65)
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var showHidePassword: UIImageView!
    @IBOutlet weak var logoIV: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var stayLoggedInSwitch: UISwitch!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var signUpBTN: UIButton!
    @IBOutlet weak var loginBTN: UIButton!
    static let shared = LoginViewController()
    var backendless:Backendless?
    var auth:Authentication = Authentication()
    var alertErrors:AlertErrors = AlertErrors()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPasswordTapped(_:)))
        showHidePassword.addGestureRecognizer(tap)
        showHidePassword.isUserInteractionEnabled = true
        passwordTF.layer.cornerRadius = 15
        emailTF.layer.cornerRadius = 15
        signUpBTN.layer.cornerRadius = 15
        loginBTN.layer.cornerRadius = 15
        backgroundView.layer.cornerRadius = 15
        backendless = Backendless.sharedInstance()
        passwordTF.delegate = self
        emailTF.delegate = self
        passwordTF.returnKeyType = UIReturnKeyType.done
        self.hideKeyboardWhenTappedAround()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Controlling the Keyboard's return key - Pradeep Kolli
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF{
            passwordTF.resignFirstResponder()
        }
        return true
    }

//    @objc func keyboardDidShow(notification: NSNotification) {
//        let infoValue = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
//        let keyboardSize = infoValue.cgRectValue.size
//        UIView.animate(withDuration: 0.3, animations: {
//            var viewFrame = self.view.frame
//            viewFrame.size.height -= keyboardSize.height
//            self.view.frame = viewFrame
//        })
//    }
//    
//    @objc func keyboardWillBeHidden(notification: NSNotification) {
//        UIView.animate(withDuration: 0.3, animations: {
//            let screenFrame = UIScreen.main.bounds
//            var viewFrame = CGRect(x: 0, y: 0, width: screenFrame.size.width, height: screenFrame.size.height)
//            viewFrame.origin.y = 0
//            self.view.frame = viewFrame
//        })
//    }
//    
//    /**
//     
//     * Created by Sambi Chanimella
//     
//     * This method allows to show/hide the password when the user clicks close eye
//     
//     * @param  {[UIImageView]} imageview      [This param sends the imageview to the function]
//     
//     */
//    
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
    
    /*
     Login Functinolity
     IBAction is used to call any method during the run-time of an iOS application.
    */
    @IBAction func loginUserBTN(_ sender: Any) {
        if (emailTF.text?.isEmpty)!{
            self.alertErrors.displayAlert("Field Error", "Mail field mandatory")
            emailTF.layer.borderWidth = CGFloat(2)
            emailTF.layer.borderColor = UIColor.red.cgColor
        }
        else if ((passwordTF.text?.isEmpty)!){
            self.alertErrors.displayAlert("Field Error", "Password field mandatory")
            passwordTF.layer.borderWidth = CGFloat(2)
            passwordTF.layer.borderColor = UIColor.red.cgColor
        }
        else{
            emailTF.layer.borderWidth = CGFloat(2)
            emailTF.layer.borderColor = UIColor.green.cgColor
            passwordTF.layer.borderWidth = CGFloat(2)
            passwordTF.layer.borderColor = UIColor.green.cgColor
            let userEmail = emailTF.text!
            let userPassword = passwordTF.text!
//            self.showSpinner(onView: self.view)
            CustomLoader.instance.showLoaderView()
            loginUser(email: userEmail, password: userPassword)
        }
    }
//    Reset password button by Pradeep Kolli
    @IBAction func resetPasswordBTN(_ sender: Any) {
        if emailTF.text!.isEmpty{
            self.alertErrors.displayAlert("Mail not sent", "Please provide valid mail to get password")
            emailTF.layer.borderWidth = CGFloat(2)
            emailTF.layer.borderColor = UIColor.red.cgColor
        }
        else{
            emailTF.layer.borderWidth = CGFloat(2)
            emailTF.layer.borderColor = UIColor.green.cgColor
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let resetPasswordController = storyboard.instantiateViewController(withIdentifier: "forgotPasswordPage") as! ResetPasswordViewController
            self.navigationController?.pushViewController(resetPasswordController, animated: true)
            resetPasswordController.email = emailTF.text
              resetPasswordUser()
            
        }
        
    }
  //Login functionality,if the user login for the first time an email is sent to the user for confirmation via backendless and also validates the email id and password.
    func loginUser(email: String, password: String) -> Bool{
        var isValid:Bool = false
        backendless?.userService.login( email, password: password, response: {
            ( loginValidUser ) in
            if self.stayLoggedInSwitch.isOn{
                self.backendless?.userService.setStayLoggedIn(true)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeTabController = storyboard.instantiateViewController(withIdentifier: "HomeTabController") as! UITabBarController
                self.present(homeTabController, animated: true, completion: nil)
                if (loginValidUser != nil){
                    isValid = true
                }

            }
            else{
                self.backendless?.userService.setStayLoggedIn(false)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeTabController = storyboard.instantiateViewController(withIdentifier: "HomeTabController") as! UITabBarController
                self.navigationController?.pushViewController(homeTabController, animated: true)
                if (loginValidUser != nil){
                    isValid = true
                }
//                self.removeSpinner()

            }
        }, error: { (fault:Fault?) in
            CustomLoader.instance.hideLoaderView()
            self.emailTF.layer.borderWidth = CGFloat(2)
            self.emailTF.layer.borderColor = UIColor.red.cgColor
            self.passwordTF.layer.borderWidth = CGFloat(2)
            self.passwordTF.layer.borderColor = UIColor.red.cgColor
            self.alertErrors.displayAlert("Login Failed", (fault?.message!)!)}
        )
        print(isValid)
        return isValid
    }
//    func loginUser(login: String!, password: String!) -> Bool!{
//        var user:BackendlessUser!
//        var loggedin:Bool = false
//        Types.tryblock({ () -> Void in
//            user = self.backendless?.userService.login(login, password: password)
////            print("User has been logged in (SYNC): \(String(describing: user.getProperties()))")
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homePageController = storyboard.instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
//            self.navigationController?.pushViewController(homePageController, animated: true)
//        },
//
//       catchblock: { (exception) -> Void in
//            print("Server reported an error: \(exception as! Fault)")
//        })
//        if user != nil{
//            loggedin = true
//        }
//        return loggedin
//    }
    
    //If the user wants to change the existing password, an option is provided to reset the password..
    func resetPasswordUser() {
            let user = BackendlessUser()
            user.email = emailTF.text as NSString?
        backendless?.userService.restorePassword(emailTF.text!, response: {
            self.alertErrors.displayAlert("Mail sent", "Please check inbox for temporary password")
        },
            error: { (fault:Fault?) in
            self.alertErrors.displayAlert("Mail Not sent", "Please enter valid email")
        })
    }
    
}
