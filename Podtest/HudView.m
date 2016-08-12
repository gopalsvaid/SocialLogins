//
//  HudView.m
//  AppLocker
//
//  Created by Manoj.Ahirwar on 21/09/15.
//  Copyright (c) 2015 Manoj.Ahirwar. All rights reserved.
//

#import "HudView.h"
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"

@interface HudView(){
    M13ProgressHUD * hud;
    int mask;
    int statusPostion;
    int iconChange;
}

@end


@implementation HudView


-(void)showHud{
      hud.status = @"In progress";
     [hud setProgress:0 animated:NO];
     [hud performAction:M13ProgressViewActionNone animated:YES];
    
     [hud show:YES];
}
-(void)killHud{
    [hud setIndeterminate:NO];
    [hud hide:YES];
    
}
+(instancetype)sharedInstance{
    __strong static id instance =nil;
    
    if (instance==nil) {
        instance=[[HudView alloc] init];
        [instance setup];
    }
    
    return instance ;
    
    
}

 -( void)setup{
    mask=1;
    statusPostion=0;
    iconChange=0;
    
    hud = [[M13ProgressHUD alloc] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    hud.progressViewSize = CGSizeMake(60.0, 60.0);
    hud.animationPoint = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:hud];
    [hud setProgress:0.0f animated:YES];
    [hud setApplyBlurToBackground:NO];
    [hud setIndeterminate:NO];
    hud.status = @"copying...";
    
    //mask
    if ( mask== 0) {
        [hud setMaskType:M13ProgressHUDMaskTypeNone];
    } else if (mask == 1) {
        [hud setMaskType:M13ProgressHUDMaskTypeSolidColor];
    } else if (mask == 2) {
        [hud setMaskType:M13ProgressHUDMaskTypeGradient];
    } else if (mask == 3) {
        [hud setMaskType:M13ProgressHUDMaskTypeIOS7Blur];
    }
    
    // text position
    if (statusPostion == 0) {
        [hud setStatusPosition:M13ProgressHUDStatusPositionBelowProgress];
    } else if (statusPostion == 1) {
        [hud setStatusPosition:M13ProgressHUDStatusPositionAboveProgress];
    } else if (statusPostion == 2) {
        [hud setStatusPosition:M13ProgressHUDStatusPositionLeftOfProgress];
    } else if (statusPostion == 3) {
        [hud setStatusPosition:M13ProgressHUDStatusPositionRightOfProgress];
    }
    
    
    /** icon changed **/
    if (iconChange == 0) {
        [hud performAction:M13ProgressViewActionNone animated:YES];
    } else if (iconChange == 1) {
        [hud performAction:M13ProgressViewActionSuccess animated:YES];
    } else if (iconChange == 2) {
        [hud performAction:M13ProgressViewActionFailure animated:YES];
    }
 }

-(void)setProgress:(float)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
         [hud setProgress:progress animated:YES];
        if (progress==1.0f) {
            [hud performAction:M13ProgressViewActionSuccess animated:YES];
             hud.status = @"completed!";
        }
    });
  
   
}
-(void)showHudWithTitle:(NSString*)title{
    if (title!=nil) {
        hud.status= title;
        [hud setProgress:0 animated:NO];
        [hud performAction:M13ProgressViewActionNone animated:YES];
        [hud setIndeterminate:YES];
        [hud show:YES];
    }
}
@end
