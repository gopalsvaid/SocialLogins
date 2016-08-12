import UIKit

struct Config {
    private init() {}
    
    // MARK: Color palette

    

    static let whiteColor           = UIColor.whiteColor()
    
    // MARK: Semantic colors
  
     static let mainBackgroundColor        = whiteColor

    static let mainTextColor               = whiteColor
    
    static let secondaryTextColor          = UIColor.darkGrayColor()
    
    static let thirdTextColor              = UIColor.grayColor()

    static let borderColor                 = whiteColor
    

    // MARK: Base fonts
    
    static let regularFont    = UIFont.systemFontOfSize(14.0)
    static let largeFont      = UIFont.systemFontOfSize(18.0)
    static let largeLightFont = UIFont.systemFontOfSize(20.0)
    static let smallLightFont = UIFont.systemFontOfSize(12.0)
    // MARK: Semantic fonts
    
    static let bodyFont        = regularFont
    static let buttonFont      = regularFont
    static let largeBodyFont   = largeLightFont
    static let largeButtonFont = largeLightFont
    
    // MARK: Layout
    
    static let standardXPadding     = CGFloat(16.0)
    static let standardYPadding     = CGFloat(12.0)
    static let largeXPadding        = CGFloat(24.0)
    static let largeYPadding        = CGFloat(18.0)
    static let smallXPadding        = CGFloat(10.0)
    static let smallYPadding        = CGFloat(8.0)
    static let thinBorderWidth      = CGFloat(0.5)
    static let thickBorderWidth     = CGFloat(1.0)
    static let veryThickBorderWidth = CGFloat(2.0)
    static let regularButtonHeight  = CGFloat(44.0)
    static let standardButtonHeight  = CGFloat(50.0)
    static let largeButtonHeight    = CGFloat(60.0)
    static let largeButtonSpacing   = CGFloat(32.0)
    static let textFieldHeight      = CGFloat(44.0)
    static let textFieldSmallHeight = CGFloat(35.0)
    static let textFieldSpacing     = CGFloat(16.0)
    static let textFieldSmallSpacing = CGFloat(8.0)
    static let chatFieldHeight      = CGFloat(36.0)
    static let chatFieldInsets      = UIEdgeInsets(top: 8.0, left: 4.0, bottom: 8.0, right: 4.0)
    static let chatMessagePadding   = CGSize(width: 24.0, height: 12.0)
    static let chatMessageSpacing   = CGFloat(24.0)
    static let CommentMessageHeight   = CGFloat(90.0)
    static let tableViewCellHeight   = CGFloat(50.0)
    
    
    //MARK: Device
    static let iphone4Height      =  CGFloat(960.0)
    static let iphone5Height      =  CGFloat(1136.0)
    static let iphone6Height      =  CGFloat(1134.0)
    static let iphone6PlusHeight  =  CGFloat(1920.0)
    
    
    
    static  let characterSetUsername  =  NSCharacterSet(charactersInString: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").invertedSet
    
    static  let  delegate =   UIApplication.sharedApplication().delegate as! AppDelegate
    
    static let default_Logo  =   UIImage(named:"Default_Logo")
    
    static let paypal_Client_Production_Key     = "AQMOmh3EJcV9LJnOmBx0q2eLrIusDRSLL4kNePdfMsa9p-oec4Pg1LgSqFt9A4-N4kmoKWPaTRWk-aHm"
    static let paypal_Client_Sandbox_Key     = "AT8sRMmXdXf6-4e8UdRHnfUm4BWQ6Hly2s8_uvpV5YV6tNnW2Da6JMiuXw4VcAqicmANarRSWJrY7lUA"
    
    
    
}
