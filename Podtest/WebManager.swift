//
//  WebManager.swift
//  Template
//
//  Created by Sumeet.Mourya on 20/10/15.
//  Copyright © 2015 Sumeet.Mourya. All rights reserved.
//

import UIKit

/// Text constant for title of newtwork error.
let k_Text_Error_NetworkTitle  =  "Network connection error."

/// Text constant for reason of newtwork error.
let k_Text_Error_NetworkReason  =  "Operation was unsuccessful."

/// Text constant for suggestion of newtwork error.
let k_Text_Error_NetworkSuggestion  = "No netwrok connection, please try again later."

/// Text constant for default alert title.
let k_Text_Alert_Title  = "Message"

/// Text constant for bool value **TRUE**.
let k_Text_Result_True = "True"

/// This is the Merchant api's response handler block.
typealias comletionBlcok = (resultType: WebManagerResult!, data: AnyObject? ) ->  ()

/// Merchant server path
let  SERVER_URL = "http://sbts.hiteshi.com/api/index.php/mobile/"

/// Login user web url.
let   loginURL       =   SERVER_URL+"Parents/register"

/// Logout user web url.
let   logoutURL   =   SERVER_URL+"Consumer/DeleteUser"

/// Login user web url.
let   CategoryURL       =   SERVER_URL+"Consumer/GetCategory"

/// Category Items url.
let   CategoryItemURL       =   SERVER_URL+"Consumer/GetItemsByCategoryId"

/// Consumer Update Quantity
let UpdateConsumerQuatityURL  =  SERVER_URL+"Consumer/UpdateQuantity"

/// Webmamager interact with server.
class WebManager: NSObject {
    
    
    /// Singleton instance for `NSURLSession`.
    lazy var defaultSession : NSURLSession! =  {
    
        let _session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        return _session
    }()
    
    /// Singleton instance  of `NSError` for showing the newtwork problem.
    var errorNetWork : NSError!
   
    
    /**
     It creates the shared instance of web manager.
     
     - returns: It returns the web manager's object.
     */
    class  func sharedInstance()-> WebManager{
  
        return _instance
    }

    /**
     Initialize the Web manager with it's all properties.
     */
    private override  init() {
       super.init()
        
        var dic: Dictionary<String,String>  = Dictionary<String,String>()
        
        dic[NSLocalizedDescriptionKey] = k_Text_Error_NetworkTitle

        dic[NSLocalizedFailureReasonErrorKey] = k_Text_Error_NetworkReason
        dic[NSLocalizedRecoverySuggestionErrorKey] = k_Text_Error_NetworkSuggestion
        
       errorNetWork = NSError(domain: "Merchant.com", code: 1010, userInfo: dic )
    }
    
    
    /**
     It create the Http post request for interacting the  web server.
     
     - parameter josn:  The josn param representing request parameters.
     - parameter strUrl: The strUrl param representing request web url.
     - parameter block:  The block param representing response handler callback block.
     */
  private  func httpPostRequest(josn: NSDictionary! , strUrl : String!, block: comletionBlcok?){
        
        let  url: NSURL =  NSURL(string: strUrl)!
        var request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      //  request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        do
        {
            let data: NSData? = try  NSJSONSerialization.dataWithJSONObject(josn, options: NSJSONWritingOptions.PrettyPrinted)
             request.HTTPBody = data
        }
        catch let error as NSError {
            print(error.localizedDescription)
           
            if let tempBlcok = block{
                 tempBlcok(resultType: WebManagerResult.error, data:  error)
            }
           
           
        }
        defer{
            //release data
        }
        
       
        let task =  self.defaultSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let tempBlcok = block{
                if error == nil{
                    tempBlcok(resultType: WebManagerResult.data, data:  data)
                  
                }else{
                    tempBlcok(resultType: WebManagerResult.error, data:  error)
                }
            }

            
                //assertionFailure("unexpected response")
           
        })
            
        task.resume()
        
      
    }
    
    /**
      A method execute the post request. 
     
     - A method check the network availability. If network not available then execute the callback block with network issue.
     
     - If network available execute the post request internally.
     
     - After getting the response, parse the  data with `NSJSONSerialization`.
     
     - Execute the callback with json object.
     
     - parameter jsonOBj:  The josn param representing request parameters.
     - parameter strULR: The strUrl param representing request web url.
     - parameter comblock:  The block param representing response handler callback block.
     */
    private func executeRequestWithHanderWithParam(jsonOBj: NSDictionary? , strULR: String, comblock: comletionBlcok? ){
        print(strULR)
        print(jsonOBj)
        

        if Reachability.isConnectedToNetwork() == false{
            
           comblock!(resultType: WebManagerResult.error, data:  errorNetWork)
          return
        }
        
        
        WebManager.sharedInstance().httpPostRequest(jsonOBj, strUrl: strULR ) { (resultType, data) -> () in
            
            switch resultType!{
            case WebManagerResult.data:
                if let tempData = data as? NSData{
                     var  strJson = NSString(data: tempData, encoding: NSASCIIStringEncoding)
                     print(strJson)
                    strJson = strJson!.stringByReplacingOccurrencesOfString("\n", withString:"")
                   
                    
                    let newdata: NSData! = strJson!.dataUsingEncoding(NSASCIIStringEncoding)
             
                    do{
                        let dataResponse: NSMutableDictionary =  try NSJSONSerialization.JSONObjectWithData(newdata , options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                      
                          print(dataResponse)
                        comblock!(resultType: WebManagerResult.data, data:  dataResponse)
                        
                    }
                    catch let error as NSError {
                        print(error.localizedDescription)
                        
                        comblock!(resultType: WebManagerResult.error, data:  error)
                    }
                    
                }
                
                break
                
            case WebManagerResult.error:
                comblock!(resultType:  WebManagerResult.error, data: data)
                break
                
                
            }
            
            
        }

    }
    
    /**
     A method execute the  multipart post request.
     
     - A method check the network availability. If network not available then execute the callback block with network issue.
     
     - If network available execute the post multipart request internally.
     
     - After getting the response, parse the  data with `NSJSONSerialization`.
     
     - Execute the callback with json object.
     
     - parameter jsonOBj:  The josn param representing request parameters.
     - parameter strULR: The strUrl param representing request web url.
     - parameter comblock:  The block param representing response handler callback block.
     */
    
    private func executeUploadRequestWithHanderWithParam(jsonOBj: NSDictionary? , strULR: String, comblock: comletionBlcok? ){
        
        WebManager.sharedInstance().httpUploadPostRequest(jsonOBj, strUrl: strULR ) { (resultType, data) -> () in
            
            
               
            switch resultType!{
            case WebManagerResult.data:
                if let tempData = data as? NSData{
                   
                    do{
                        let dataResponse: NSMutableDictionary =  try NSJSONSerialization.JSONObjectWithData(tempData , options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                        
                        print(dataResponse)
                        
                        comblock!(resultType: WebManagerResult.data, data:  dataResponse)
                        
                    }
                    catch let error as NSError {
                  
                         print(error.localizedDescription)
                        comblock!(resultType: WebManagerResult.error, data:  error)
                    }
                    
                }
                
                break
                
            case WebManagerResult.error:
                comblock!(resultType:  WebManagerResult.error, data: data)
                break
                
                
            }
      
        }
    }
    
    /**
     It create the Http post multipart request for interacting the  web server (upload image).
     
     - parameter josn:  The josn param representing request parameters.
     - parameter strUrl: The strUrl param representing request web url.
     - parameter block:  The block param representing response handler callback block.
     */
    private  func httpUploadPostRequest(json: NSDictionary! , strUrl : String!, block: comletionBlcok?){
        
       
        
        
        let  url: NSURL =  NSURL(string: strUrl)!
        let request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        
        request.HTTPMethod = "POST";
        
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        ///--------------------
        
        
        let body = NSMutableData();
        
        if json != nil {
            for (key, value) in json! {
                
                if value.isKindOfClass(NSString.classForCoder()){   /*** string paramenter **/
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString("\(value)\r\n")
                }else if value.isKindOfClass(UIImage.classForCoder()){
                    
                    let filename = "image" + (key as! String) + ".jpg"
                    
                    let image = value as! UIImage
                    
                    let imageDataKey : NSData? = UIImageJPEGRepresentation(image, 1.0)
                    
                    if let imageData = imageDataKey{
                        
                        let mimetype = "image/JPG"
                        
                        body.appendString("--\(boundary)\r\n")
                        body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                        body.appendData(imageData)
                        body.appendString("\r\n")
                    }
                    
                    
                }
                
                
            }
        }
        
        
        body.appendString("--\(boundary)--\r\n")
        
        
        ///------------
        request.HTTPBody = body
        let task =  self.defaultSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let tempBlcok = block{
                if error == nil{
                    tempBlcok(resultType: WebManagerResult.data, data:  data)
                }else{
                    tempBlcok(resultType: WebManagerResult.error, data:  error)
                }
            }
            
            
            //assertionFailure("unexpected response")
            
        })
        
        task.resume()
        
        
    }
    
    
    /**
     It create the uniq string boundary for multipart request format.
     
     - returns: It reutrn the boundary as a string format.
     */
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    

    /**
     The method perfrom the authentication action.
     
     - It verifies the validity and identitiy of user who wants to access data and resources.
     
     - parameter jsondata: The jsondata param representing request parameters.
     - parameter block:  The block param representing response handler callback block.
     */
    func loginUserWithData(jsondata: NSDictionary? , block: comletionBlcok?)-> Void{
        
        WebManager.sharedInstance().executeRequestWithHanderWithParam(jsondata, strULR: loginURL, comblock: block)
    }
    
    /**
     The method perfrom the logout action.
     
     - It remove the user records from cache.
     
     - parameter jsondata: The jsondata param representing request parameters.
     - parameter block:  The block param representing response handler callback block.
     */
    
    func logoutUserWithData(jsondata: NSDictionary? , block: comletionBlcok?)-> Void{
        
        WebManager.sharedInstance().executeRequestWithHanderWithParam(jsondata, strULR: logoutURL, comblock: block)
    }
    
    
    /**
     The method send you the list of categories.
     
     - It shows all avilable data in the list.
     
     - parameter jsondata: The jsondata param representing request parameters.
     - parameter block:  The block param representing response handler callback block.
     */
    
    func categoryData(jsondata: NSDictionary? , block: comletionBlcok?)-> Void{
        
        WebManager.sharedInstance().executeRequestWithHanderWithParam(jsondata, strULR: CategoryURL, comblock: block)
    }
    

    /**
     The method send you the list of sub categories.
     
     - It shows all subcategory items of the selected category.
     
     - parameter jsondata: The jsondata param representing request parameters.
     - parameter block:  The block param representing response handler callback block.
     */
    func categoryItemData(jsondata: NSDictionary? , block: comletionBlcok?)-> Void{
        
        let id:Int! = jsondata!["CategoryId"] as! Int
        WebManager.sharedInstance().executeRequestWithHanderWithParam(jsondata, strULR: CategoryItemURL+"?CategoryId=\(id)", comblock: block)
    }
    
    /**
     The method use for buying a product.
     
     - Used for buying subcategory item in the selected category.
     
     - parameter jsondata: The jsondata param representing request parameters.
     - parameter block:  The block param representing response handler callback block.
     */
    func buyCategoryitem(jsondata: NSDictionary? , block: comletionBlcok?)-> Void{
        
        WebManager.sharedInstance().executeRequestWithHanderWithParam(jsondata,strULR: UpdateConsumerQuatityURL, comblock: block)
    }
    
    
}
   
/// private webmanager instance.
private   let  _instance = WebManager()



//MARK: NSMutableData
extension NSMutableData {
    
    /**
     The method append the new deta itself.
     
     - parameter string: The string param representing string date which is to be added.
     */
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
