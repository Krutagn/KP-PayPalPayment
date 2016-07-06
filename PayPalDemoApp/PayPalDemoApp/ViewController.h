//
//  ViewController.h
//  PayPalDemoApp
//
//  Created by krutagn on 05/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "PayPalConfiguration.h"
#import "PayPalPaymentViewController.h"

@interface ViewController : UIViewController<PayPalPaymentDelegate>

- (IBAction)btnPayment:(id)sender;

@end

