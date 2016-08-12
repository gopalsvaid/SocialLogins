//
//  FBManager.swift
//  ParentApp
//
//  Created by Gopal.Vaid on 04/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKShareKit


/**
 Facebook api response.
 
 - error:  For response comes as a error.
 - result: For response comes as a result by not appropriate.
 - user:   For response cames as a user info and succeed.
 */
enum FBResult {
    case error
    case result
    case user
}


/// This is the Facebook api's response handler block.
typealias FacebookCompletionBlcok  = (type: FBResult!, data: AnyObject?) -> ()


/// The FBManager perfroms all the Facebook related activities.
class FBManager: NSObject {
    
    /// Static object of `FBSDKLoginManager`.
   
    
    

    /**
     It perform the Facebook login actions and handle the response.
     
     - It creates the default facebook login user interface with following permission **public_profile, email, user_friends**.
     - It takes user's login credential and calls the facebook login api.
     - it manage the response whether user login successfully or not.
     - It calls the `completionBlock` depends of the response.

    */
    class func loginWithFacebook(completionBlock: FacebookCompletionBlcok) {
       let  fbloginManager = FBSDKLoginManager()
        fbloginManager.logOut()

       // fbloginManager.loginBehavior = .Web
        fbloginManager.logInWithReadPermissions(["public_profile","email","user_friends"], fromViewController: MainWindow.rootViewController) { ( result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            
            
            if error != nil {
                completionBlock(type: FBResult.error , data: error)
                
            }else if result.isCancelled{
                 completionBlock(type: FBResult.result , data: result)
                
            }else{
              
                if result.grantedPermissions.contains("email"){
                    print(result.description)
                    if (FBSDKAccessToken.currentAccessToken() != nil){
                        
                        let request =   FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email,id,name, first_name, last_name, middle_name, gender, birthday, about, bio, hometown, link, website, cover"])
                        request.startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                            if error == nil {
                                
                                
                                //let url: NSURL? = FBSDKProfile.currentProfile()?.imageURLForPictureMode(FBSDKProfilePictureMode.Square, size: CGSizeMake(100, 100))
                                
                                let dic: NSDictionary = result as! NSDictionary

                                
                                let urlNew : NSURL? = NSURL(string: NSString(format: "https://graph.facebook.com/%@/picture?type=large", (dic.valueForKey("id") as? String)!) as String)
                                
                                
                                print (dic)
                                
                                let user =   User(socialId: dic.valueForKey("id") as? String , name: dic.valueForKey("name") as? String, firstName: dic.valueForKey("first_name") as? String, lastName: dic.valueForKey("last_name") as? String, email: dic.valueForKey("email") as? String, gender: dic.valueForKey("gender") as? String, socialLink: dic.valueForKey("link") as? String, password: nil , coverImage: dic.valueForKey("cover")?.valueForKey("source") as? String, profileIamge: urlNew?.description , location: nil, lat: nil, long: nil, socialKind: "Facebook" , bio: dic.valueForKey("bio") as? String)
                                
                                completionBlock(type: FBResult.user , data: user)
                                
                            }
                        })
                    }else{
                         completionBlock(type: FBResult.result , data: result)
                    }
                    
                }
                
              

              
                
            }
        }
    }
    
    class func postMessage (graphPath graphPath : NSString, parameters : NSDictionary, controller : UIViewController, completionBlock: FacebookCompletionBlcok){
        let  fbloginManager = FBSDKLoginManager()

        fbloginManager.logInWithPublishPermissions(["publish_actions"], fromViewController: controller) { ( result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            
            
            if error != nil {
                completionBlock(type: FBResult.error , data: error)
                
            }else if result.isCancelled{
                completionBlock(type: FBResult.result , data: result)
                
            }else{
                if result.grantedPermissions.contains("publish_actions"){
                
                    let request =  FBSDKGraphRequest(graphPath: graphPath as String, parameters: parameters as [NSObject : AnyObject], HTTPMethod: "POST")
                    
                    request.startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                        if error == nil {
                            completionBlock(type: FBResult.result , data: result!)
                        }else{
                            completionBlock(type: FBResult.error , data: nil)
                        }
                    })
                    
                }
            }
        }
        
        
        //let request =   FBSDKGraphRequest(graphPath: "me/feed", parameters: ["message":"Hello World \n http://hiteshi.com"])
        
        
    }
    
    /**
       It performs logout operation from Facebook.
     
       - It removes logged in user's cache files and inforation.
     */
    class func logout(){
        FBSDKLoginManager().logOut()
    }


}

