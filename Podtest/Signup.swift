//
//  Signup.swift
//  Podtest
//
//  Created by Gopal.Vaid on 10/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit

class Signup: UIViewController, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
     @IBOutlet  weak var  tableviewSignup: UITableView!
     private let SignupCellId = "SignupCellId"
     var userDetail = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set title navigational bar
        self.navigationItem.hidesBackButton = true;
        
        self.title = "SIGN UP"
       // self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 14.0)!]
        
         self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableviewSignup.registerClass(SignupCell.classForCoder(), forCellReuseIdentifier: "SignupCellId")
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: tableviewSignup.frame.height / 2.0, right: 0)
        self.tableviewSignup.contentInset = insets
        self.tableviewSignup.scrollIndicatorInsets = insets
        
        print(Singleton.sharedInstance.userSignupInfo)
        
        userDetail = NSMutableDictionary()
        userDetail = Singleton.sharedInstance.userSignupInfo;
        
        self.setBackButton()
    }
    
    
    /**
     This method is used to set and create the back button.
     */
    func setBackButton(){
        
        // creating custom back button
        let btnback = UIButton()
        btnback.setImage(UIImage(named: "btnBack"), forState: .Normal)
        btnback.frame = CGRectMake(0, 0, 30, 30)
        btnback.addTarget(self, action: #selector(Signup.actionBack), forControlEvents: .TouchUpInside)
        
        // Set Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnback
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        
        // creating custom back button
        let btnsignup = UIButton()
        btnsignup.setImage(UIImage(named: "btnBack"), forState: .Normal)
        btnsignup.frame = CGRectMake(0, 0, 30, 30)
        btnsignup.addTarget(self, action: #selector(Signup.signupApiCall), forControlEvents: .TouchUpInside)
        
        // Set Right Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnsignup
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    //MARK: Back action
    func actionBack() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func signupApiCall() {
        
    }
    
    
    // MARK: - TableViewDelegate & DataSource
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return tableviewSignup.frame.height / 6.0 
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       
        return 6
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier(SignupCellId) as! SignupCell
        
        if indexPath.row == 0{
            cell.txtField.placeholder = "First Name"
            cell.txtField.text = userDetail.valueForKey("firstname") as? String
        
        }else if indexPath.row == 1{
           cell.txtField.placeholder = "Last Name"
           cell.txtField.text = userDetail.valueForKey("lastname") as? String
            
        }else if indexPath.row == 2{
            cell.txtField.placeholder = "Email Address"
            cell.txtField.text = userDetail.valueForKey("email") as? String
            
        }else if indexPath.row == 3{
            cell.txtField.placeholder = "Phone Number"
            cell.txtField.text = userDetail.valueForKey("phone") as? String
            
        }else if indexPath.row == 4{
            cell.txtField.placeholder = "Password"
            cell.txtField.text = userDetail.valueForKey("password") as? String
            cell.txtField.secureTextEntry = true
            
        }else if indexPath.row == 5{
            cell.txtField.placeholder = "Confirm Password"
            cell.txtField.text = userDetail.valueForKey("confirmPassword") as? String
            cell.txtField.secureTextEntry = true
            
        }
        
        cell.txtField.delegate = self
        cell.txtField.tag = indexPath.row + 1000
    
        return cell
        
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        
        var dic = NSMutableDictionary()
        dic = Singleton.sharedInstance.userSignupInfo
        
        if textField.tag == 1000{
            
            let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "firstname")
             print(Singleton.sharedInstance.userSignupInfo)
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1001{
            
           let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "lastname")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1002{
            
           let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "email")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1003{
            
            let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "phone")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1004{
            
           let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "password")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1005{
            
           let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "confirmPassword")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }
    
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        
        var dic = NSMutableDictionary()
        dic = Singleton.sharedInstance.userSignupInfo
        
        if textField.tag == 1000{
            
            let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "firstname")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1001{
            
            let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "lastname")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1002{
            
            let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "email")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1003{
            
           let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "phone")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1004{
            
           let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "password")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }else if textField.tag == 1005{
            
            let txtString : String? = textField.text
            Singleton.sharedInstance.userSignupInfo.setValue(txtString, forKey: "confirmPassword")
            userDetail = NSMutableDictionary()
            userDetail = dic
            
        }
       return true
    }

}
