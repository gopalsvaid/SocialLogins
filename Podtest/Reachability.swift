//
//  Reachability.swift
//  Swapush
//
//  Created by Manoj.Ahirwar on 15/12/15.
//  Copyright © 2015 Manoj.Ahirwar. All rights reserved.
//

import SystemConfiguration
public class Reachability {
    /**
     It shows the the network status.
      
     The method indentify the network connection status. And provide the status whether the device currently conneted to internet or not .
     
     To use it, simply call:
     
     ```
     Reachability.isConnectedToNetwork()
     ```
    
     
     - returns:  It returns bool value (true or false).
     
     */
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}