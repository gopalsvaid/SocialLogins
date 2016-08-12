//
//  Constant.swift
//  Template
//
//  Created by Gopal.Vaid on 04/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//
//http://www.paintcodeapp.com/news/iphone-6-screens-demystified

import UIKit

/**
 Web service response.
 
 - error: For response comes as a error.
 - data:  For response comes as a data.
 */
enum WebManagerResult {
    case error
    case data
    
}


/// Macro for getting device **Height**.
let Device_Height = (UIScreen.mainScreen().nativeBounds.size.height/2)

/// Macro for getting device **Width**.
let Device_Width =  (UIScreen.mainScreen().nativeBounds.size.width/2)





