//
//  ParentApp
//
//  Created by Gopal.Vaid on 04/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit
/// Global object for managing the swapush shared UI activities.
class UIManager: NSObject {
    
  
    
}


// MARK: public variable

      /// The ParentApp AppDelegate object. AppDelegate handles special UIApplication states and activities.
      var APPDelegate: AppDelegate {
     
      return  UIApplication .sharedApplication().delegate as! AppDelegate
   
      }


     /// ParentApp Root navigation Controller just over the Window. the MainNavigation controller manages a stack of view controllers to provide a drill-down interface for hierarchical content.
     var MainNavigation: UINavigationController {
        
        let navController: UINavigationController! =  APPDelegate.window?.rootViewController as! UINavigationController
        return navController
    }


     /// ParentApp main story board object, which loaded from Interface Builder.
     var MainStoryBoard: UIStoryboard = {
        
        let  storyboard:  UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
        
    }()



    /// ParentApp main Tab bar conytoller.
    var MainTabBar: UITabBarController = {
         let tabBarVC: UITabBarController! = MainStoryBoard.instantiateViewControllerWithIdentifier("MainTabBarVC") as! UITabBarController
        return tabBarVC
    }()


    /// ParentApp main Window, The root UI object. It contains Swapsuh’s visible content.
    var MainWindow: UIWindow! {
        
    return APPDelegate.window
        
    }

   
    


