//
//  ViewController.swift
//  Podtest
//
//  Created by Gopal.Vaid on 08/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit
import Google
import FBSDKLoginKit

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate , UITextFieldDelegate {
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var btnLoginFb       : UIButton!
    @IBOutlet weak var btnLoginLn       : UIButton!
    @IBOutlet weak var viewBackground   : UIView!
    @IBOutlet weak var txtLogin         : UITextField!
    @IBOutlet weak var txtPassword      : UITextField!
    @IBOutlet weak var btnSignUp        : UIButton!
    @IBOutlet weak var btnLoginIn       : UIButton!
    @IBOutlet weak var btnForgot        : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         // Google SignIn
            googleSignIn()
    }
    
    
     //MARK: Google SignIn Button Actions
    
    private func googleSignIn(){
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        if error != nil{
            print(error)
            return
        }
        
        GIDSignIn.sharedInstance().uiDelegate =  self
        GIDSignIn.sharedInstance().delegate = self

        let signInButton = GIDSignInButton(frame: CGRectMake(-2, 264, self.view.frame.width - 36, 44))
        viewBackground.addSubview(signInButton)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil{
         print(error)
            return
        }
        
//        print(user)
//        print(user.profile.email)
//        print(user.profile.familyName)
//        print(user.profile.givenName)
//        
//        print(user.userID)
//        print(user.profile.name)
//        print(user.profile.description)
//        print(user.profile.imageURLWithDimension(100))
        
       self.gettingSignupRecords(user.profile.givenName , lastname: user.profile.familyName, email: user.profile.email, social_Id: user.userID, social_Type: "googleplus", userProfileURL: user.profile.imageURLWithDimension(100).absoluteString, phone: "")
    }
    
    
    //MARK: Facebook Button Actions
    
    @IBAction func actionOnBtnLoginFB(sender: AnyObject){
        self.loginWithFB()
    }
    
    private func loginWithFB(){
        
        FBManager.loginWithFacebook { (type, data) -> () in
            
            switch type!{
                
            case FBResult.error:
                print("error")   /* api error came frome facebook  loing */
                break
                
            case FBResult.result:
                print("result")  /* api facebook  loing  failed*/
                break
                
            case FBResult.user:
                /* api facebook  loing  successed with user info*/
                self.facebookSuccessResponse(data as? User)
                break
            }
        }
    }
    
    
    private func facebookSuccessResponse(fbUser: User?){
        
        self.gettingSignupRecords(fbUser?.firstName,
                                  lastname: fbUser?.lastName,
                                  email: fbUser?.email,
                                  social_Id: fbUser?.socialId,
                                  social_Type: "facebook",
                                  userProfileURL: fbUser?.profileImage,
                                  phone: "")
        
    }
    
    
    //MARK: Linkedln Actions
    
    @IBAction func actionOnBtnLoginLN(sender: AnyObject){
        self.linkedin()
    }
    
    private func linkedin() {
        
        LNManager.loginWithLinkedLn { (type, data) -> () in
            
            switch type!{
                
            case LNResult.error:
                
                print("error")   /* api error came frome linkedln  loing */
                break
                
            case LNResult.result:
                
                print("result")  /* api linkedln  loing successed */
                self.linkedLnSuccessResponse(data as! NSDictionary)
                break
                
            }
        }
    }
    
    
    private func linkedLnSuccessResponse(dic : NSDictionary){
        
         self.gettingSignupRecords( dic["firstName"] as? String ,
                                   lastname: dic["lastName"] as? String,
                                   email: dic["emailAddress"]as? String,
                                   social_Id: dic["id"] as! String,
                                   social_Type: "linkedln",
                                   userProfileURL: dic["pictureUrl"] as? String,
                                   phone: "" )
        
    }
    
    
    //MARK: GettingValue from Social sites and redirect to signup form
    
    func gettingSignupRecords(firstname: String? , lastname: String? , email: String? , social_Id: String!, social_Type: String! , userProfileURL: String?, phone: String? ) {
        
        let UUID : String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        Singleton.sharedInstance.userSignupInfo = [
            
            "firstname"           : firstname ?? "", // Always use optional values carefully!
            "lastname"            : lastname ?? "",
            "email"               : email ?? "",
            "social_Id"           : social_Id ?? "",
            "social_Type"         : social_Type ?? "",
            "userProfileURL"      : userProfileURL ?? "",
            "phone"               : phone ?? "",
            "password"            : "xyz",
            "confirmPassword"     : "xyz",
            "device_Id"           : UUID,
            "device_Type"         : "IOS",
            "device_Token"        : "akljsdfklakldsjfoiuqweroi",
            "gender"              : "M",
            "address"             : ""
            
        ];
        
        print("Dictionary :- \(Singleton.sharedInstance.userSignupInfo)")
        
        let signupVC = MainStoryBoard.instantiateViewControllerWithIdentifier("signupVC")
        MainNavigation.pushViewController(signupVC, animated: true)
        
    }
    
    
    //MARK: Signup Actions
    
    @IBAction func actionOnBtnSignup(sender: AnyObject){
        
        self.gettingSignupRecords( "" ,
                                   lastname: "",
                                   email: "",
                                   social_Id: "",
                                   social_Type: "signup",
                                   userProfileURL: "",
                                   phone: "" )
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UITextField
    
     func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
       return true
    }

}

