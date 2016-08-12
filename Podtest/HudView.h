//
//  HudView.h
//  AppLocker
//
//  Created by Manoj.Ahirwar on 21/09/15.
//  Copyright (c) 2015 Manoj.Ahirwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HudView : NSObject

-(void)showHud;
-(void)killHud;
+(instancetype)sharedInstance;
-(void)setProgress:(float)progress;

-(void)showHudWithTitle:(NSString*)title;

@end
