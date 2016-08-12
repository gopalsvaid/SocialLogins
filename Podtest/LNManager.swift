//
//  LNManager.swift
//  ParentApp
//
//  Created by Gopal.Vaid on 05/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit

/**
 Linkedln api response.
 
 - error:  For response comes as a error.
 - result: For response comes as a result by not appropriate.
 - user:   For response cames as a user info and succeed.
 */
enum LNResult {
    case error
    case result
}


/// This is the Facebook api's response handler block.
typealias LinkedLnCompletionBlcok  = (type: LNResult!, data: AnyObject?) -> ()


class LNManager: NSObject {
    
    /// Static object of `LinkedLnManager`.
    
    /**
     It perform the LinkedLn login actions and handle the response.
     
     - It creates the default linkedln login user interface with following permission **public_profile, email,id , first and last name **.
     - It takes user's login credential and calls the linkedln login api.
     - it manage the response whether user login successfully or not.
     - It calls the `completionBlock` depends of the response.
     
     */
    class func loginWithLinkedLn(completionBlock: LinkedLnCompletionBlcok) {
        
        LISDKSessionManager.createSessionWithAuth([LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: { (string) -> () in
            
            
            if (LISDKSessionManager.hasValidSession()) {
                
                LISDKAPIHelper.sharedInstance().getRequest("https://api.linkedin.com/v1/people/~:(id,firstName,lastName,email-address,picture-url,location)", success: { (response) -> () in
                    
                dispatch_async(dispatch_get_main_queue(), { () -> () in
                    
                    if let dataFromString = response.data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                        
                        LISDKSessionManager.clearSession()
                     
                        do {
                            let responseObject = try NSJSONSerialization.JSONObjectWithData(dataFromString, options: []) as! [String:AnyObject]
                            
                             completionBlock(type: LNResult.result , data: responseObject)
                            
                        } catch let error as NSError {
                            
                            print("error: \(error.localizedDescription)")
                            
                             completionBlock(type: LNResult.error , data: error)
                        }
                    }
                })
                    
            }, error: { (error) -> () in
                        
                        LISDKAPIHelper.sharedInstance().cancelCalls()
                        LISDKSessionManager.clearSession()
                        completionBlock(type: LNResult.error , data: error)
                })
             }
            }, errorBlock: { (error) -> () in
                
                LISDKAPIHelper.sharedInstance().cancelCalls()
                LISDKSessionManager.clearSession()
                completionBlock(type: LNResult.error , data: error)
        })
    }

}
