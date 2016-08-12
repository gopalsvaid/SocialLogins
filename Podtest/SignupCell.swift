//
//  SignupCell.swift
//  Podtest
//
//  Created by Gopal.Vaid on 10/08/16.
//  Copyright © 2016 Gopal.Vaid. All rights reserved.
//

import UIKit

class SignupCell: UITableViewCell {
    
    var txtField : UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        
        // Background View
        txtField = UITextField()
        txtField.frame = CGRectMake(10, 10, Device_Width-20, 50)
        txtField.backgroundColor=UIColor.redColor()
        self.addSubview(txtField)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        txtField.frame  = CGRect(x: 20, y: 10, width: CGRectGetWidth(self.frame) - 40, height: CGRectGetHeight(self.frame) - 20)
    }

}
