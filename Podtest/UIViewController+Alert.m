//
//  UIViewController+Alert.m
//  PhotoLocker
//
//  Created by Manoj.Ahirwar on 21/09/15.
//  Copyright (c) 2015 Gopal.Vaid. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)
-(void)showAlert:(NSString*)title  withMessage:(NSString*)message{
    UIAlertController   * alertController = [UIAlertController
                                             alertControllerWithTitle:title
                                             message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
    alertController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                      
                                   }];
    
  
    
    [alertController addAction:cancelAction];
   
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

    
    
}
@end
