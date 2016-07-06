//
//  ViewController.m
//  PayPalDemoApp
//
//  Created by krutagn on 05/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) PayPalConfiguration *PayPalconfig;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _PayPalconfig = [[PayPalConfiguration alloc]init];
    
    _PayPalconfig.acceptCreditCards = YES;
    
    _PayPalconfig.merchantName = @"Zaptech Solutions";
    _PayPalconfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"www.zaptechsolutions.com"];
    _PayPalconfig.merchantUserAgreementURL = [NSURL URLWithString:@"www.zaptechsolutions.com"];
    _PayPalconfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    _PayPalconfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    NSLog(@"PayPal SDK:%@",[PayPalMobile libraryVersion]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPayment:(id)sender {
    
    PayPalItem *item1 = [PayPalItem itemWithName:@"iPhone6" withQuantity:1 withPrice:[NSDecimalNumber decimalNumberWithString:@"500"] withCurrency:@"USD" withSku:@"SKU-iPhone6"];
    PayPalItem *item2 = [PayPalItem itemWithName:@"MacBook Pro" withQuantity:1 withPrice:[NSDecimalNumber decimalNumberWithString:@"10000"] withCurrency:@"USD" withSku:@"SKU-MacBookPro"];
    
    NSArray *items = @[item1,item2];
    
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc]initWithString:@"5.15"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc]initWithString:@"2.20"];
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal withShipping:shipping withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping]decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc]init];
    payment.amount = total;
    
    payment.currencyCode = @"USD";
    
    payment.shortDescription = @"My Payment";
    
    payment.items = items;
    
    payment.paymentDetails = paymentDetails;
    
    if(!payment.processable)
    {
        
    }
    
    PayPalPaymentViewController *paymentviewcontroller = [[PayPalPaymentViewController alloc]initWithPayment:payment configuration:self.PayPalconfig delegate:self];
    
    [self presentViewController:paymentviewcontroller animated:YES completion:nil];
    

}

-(void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    NSLog(@"PayPal Payment Cancle...");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"PayPal Payment Success...");
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
