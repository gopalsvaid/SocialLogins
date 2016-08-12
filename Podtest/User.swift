//
//  User.swift
//  ParentApp
//
//  Created by Gopal.Vaid on 04/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//


import UIKit

class User:  NSObject,NSCoding {
    var myContext : UnsafeMutablePointer<()>
    var socialId: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var gender: String?
    var socialLink: String?
    var coverImage: String?
    var profileImage: String?
    var password: String?
    var location: String?
    var lat: String?
    var long: String?
    var socialKind: String?
    var bio: String?
    var referralCode: String?
    let defaultUserImage = UIImage(named: "default_User")
    dynamic  var currentRadius: String?
    dynamic  var userId: String?
    dynamic  var baseUrl: String?
    dynamic  var sessionId: String?
    
    /**
     Initializes a new User.
     */
    override init() {
        myContext = nil
        super.init()
        self.addObserver(self, forKeyPath: "currentRadius", options: NSKeyValueObservingOptions.New, context: myContext)
        
        self.addObserver(self, forKeyPath: "userId", options: NSKeyValueObservingOptions.Old, context: myContext)
        self.addObserver(self, forKeyPath: "baseUrl", options: NSKeyValueObservingOptions.Old, context: myContext)
        self.addObserver(self, forKeyPath: "sessionId", options: NSKeyValueObservingOptions.Old, context: myContext)
    }
    
    /**
     Initializes a new User with the provided data and informations.
     
     
     - parameter socialId:     The user socialid (facebook_id).
     - parameter name:         The user name.
     - parameter firstName:    The user first name.
     - parameter lastName:     The user last name.
     - parameter email:        The user email.
     - parameter gender:       The user gender.
     - parameter socialLink:   The user social link (facebook link).
     - parameter password:     The user password.
     - parameter coverImage:   The user cover image (facebook cover image).
     - parameter profileIamge: The user profile image.
     - parameter location:     The user location (address).
     - parameter lat:          The user location coordinates(latitude).
     - parameter long:         The user location coordinates(longitude).
     - parameter socialKind:   The user social kind info(about)
     - parameter bio:          The user bio.(about user)
     
     - returns: The method return new created user with provided info.
     */
    init(socialId: String!, name: String!, firstName: String!, lastName: String!, email: String!, gender:String!, socialLink: String!, password: String!, coverImage: String!, profileIamge: String!, location: String!, lat: String!, long: String!, socialKind: String!, bio: String!) {
         myContext = nil
        super.init()
        
        self.socialId = socialId
        self.name =  name
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.gender = gender
        self.socialLink = socialLink
        self.coverImage = coverImage
        self.profileImage = profileIamge
        self.password = password
        self.location = location
        self.lat =  lat
        self.long = long
        self.socialKind = socialKind
        self.bio = bio
        self.sessionId = nil
        self.baseUrl = nil
        self.userId = nil
        self.currentRadius = nil
        self.referralCode = nil
        
        // add observer self for  get notified, whenever any properties value are changed.
        //http://blog.scottlogic.com/2015/02/11/swift-kvo-alternatives.html
        self.addObserver(self, forKeyPath: "currentRadius", options: NSKeyValueObservingOptions.New, context: myContext)
        
        self.addObserver(self, forKeyPath: "userId", options: NSKeyValueObservingOptions.Old, context: myContext)
        self.addObserver(self, forKeyPath: "baseUrl", options: NSKeyValueObservingOptions.Old, context: myContext)
        self.addObserver(self, forKeyPath: "sessionId", options: NSKeyValueObservingOptions.Old, context: myContext)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
         myContext = nil
        super.init()
        self.socialId = aDecoder.decodeObjectForKey("socialId") as? String
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
        self.gender = aDecoder.decodeObjectForKey("gender") as? String
        self.socialLink = aDecoder.decodeObjectForKey("socialLink") as? String
        self.password = aDecoder.decodeObjectForKey("password") as? String
        self.coverImage = aDecoder.decodeObjectForKey("coverImage") as? String
        self.profileImage = aDecoder.decodeObjectForKey("profileImage") as? String
        self.location = aDecoder.decodeObjectForKey("location") as? String
        self.lat = aDecoder.decodeObjectForKey("lat") as? String
        self.long = aDecoder.decodeObjectForKey("long") as? String
        self.socialKind = aDecoder.decodeObjectForKey("socialKind") as? String
        self.bio = aDecoder.decodeObjectForKey("bio") as? String
        self.sessionId = aDecoder.decodeObjectForKey("sessionId") as? String
        self.baseUrl = aDecoder.decodeObjectForKey("baseUrl") as? String
        self.userId = aDecoder.decodeObjectForKey("userId") as? String
        self.currentRadius = aDecoder.decodeObjectForKey("currentRadius") as? String
        self.referralCode = aDecoder.decodeObjectForKey("referralCode") as? String
        
        self.addObserver(self, forKeyPath: "currentRadius", options: NSKeyValueObservingOptions.New, context: myContext)
        
        
        self.addObserver(self, forKeyPath: "userId", options: NSKeyValueObservingOptions.New, context: myContext)
        self.addObserver(self, forKeyPath: "sessionId", options: NSKeyValueObservingOptions.New, context: myContext)
        self.addObserver(self, forKeyPath: "baseUrl", options: NSKeyValueObservingOptions.New, context: myContext)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(self.socialId, forKey: "socialId")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.gender, forKey: "gender")
        aCoder.encodeObject(self.socialLink, forKey: "socialLink")
        aCoder.encodeObject(self.password, forKey: "password")
        aCoder.encodeObject(self.coverImage, forKey: "coverImage")
        aCoder.encodeObject(self.profileImage, forKey: "profileImage")
        aCoder.encodeObject(self.location, forKey: "location")
        aCoder.encodeObject(self.lat, forKey: "lat")
        aCoder.encodeObject(self.long, forKey: "long")
        aCoder.encodeObject(self.socialKind, forKey: "socialKind")
        aCoder.encodeObject(self.bio, forKey: "bio")
        aCoder.encodeObject(self.sessionId, forKey: "sessionId")
        aCoder.encodeObject(self.baseUrl, forKey: "baseUrl")
        aCoder.encodeObject(self.userId, forKey: "userId")
        aCoder.encodeObject(self.currentRadius, forKey: "currentRadius")
        aCoder.encodeObject(self.referralCode, forKey: "referralCode")
       
    }
    
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        
        if context == myContext {
            if let objectTemp = object, path = keyPath {
                if (objectTemp.isEqual(self))   &&  (path == "sessionId"  || path == "baseUrl" || path == "userId"||path == "currentRadius"){
                   
                    
                }
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
        
        
        
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "sessionId", context: myContext)
        self.removeObserver(self, forKeyPath: "baseUrl", context: myContext)
        self.removeObserver(self, forKeyPath: "userId", context: myContext)
        self.removeObserver(self, forKeyPath: "currentRadius", context: myContext)
        
        myContext = nil
        // perform the deinitialization
    }
    
}
