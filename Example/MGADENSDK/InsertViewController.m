//
//  InsertViewController.m
//  WGADSDKDemo
//
//  Created by Mr.Song on 2020/2/18.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "InsertViewController.h"
#import "MGInterstitialAd.h"
#import "NSObject+ALiHUD.h"

@interface InsertViewController ()<MGInterstitialAdDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ad1Field;
@property (weak, nonatomic) IBOutlet UITextField *ad2Field;
@property (weak, nonatomic) IBOutlet UITextField *ad3Field;

@property(nonatomic, strong)MGInterstitialAd    *insetAd1;
@property(nonatomic, strong)MGInterstitialAd    *insetAd2;
@property(nonatomic, strong)MGInterstitialAd    *insetAd3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;


@end

@implementation InsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loadAd1:(id)sender {
    if(self.ad1Field.text.length < 1) {
        [self showErrorText:@"请输入adid"];
        return;
    }
    if(!self.insetAd1) {
        self.insetAd1 = [[MGInterstitialAd alloc] initWithAdid:self.ad1Field.text];
        self.insetAd1.delegate = self;
    }
    [self.insetAd1 loadAd];
}
- (IBAction)loadAd2:(id)sender {
    if(self.ad2Field.text.length < 1) {
        [self showErrorText:@"请输入adid"];
        return;
    }
     if(!self.insetAd2) {
           self.insetAd2 = [[MGInterstitialAd alloc] initWithAdid:self.ad2Field.text];
           self.insetAd2.delegate = self;
       }
    [self.insetAd2 loadAd];
}
- (IBAction)loadAd3:(id)sender {
    if(self.ad3Field.text.length < 1) {
        [self showErrorText:@"请输入adid"];
        return;
    }
     if(!self.insetAd3) {
           self.insetAd3 = [[MGInterstitialAd alloc] initWithAdid:self.ad3Field.text];
           self.insetAd3.delegate = self;
       }
    [self.insetAd3 loadAd];
}
- (IBAction)showAd1:(id)sender {
    if(self.insetAd1.isAdValid) {
       [self.insetAd1 showAdFromRootViewController:self];
    } else {
        [self showErrorText:@"广告未就绪"];
    }
}
- (IBAction)showAd2:(id)sender {
   if(self.insetAd2.isAdValid) {
       [self.insetAd2 showAdFromRootViewController:self];
    } else {
        [self showErrorText:@"广告未就绪"];
    }
}
- (IBAction)showAd3:(id)sender {
    if(self.insetAd3.isAdValid) {
       [self.insetAd3 showAdFromRootViewController:self];
    } else {
        [self showErrorText:@"广告未就绪"];
    }
}


#pragma mark MGInterstitialAdDelegate
- (void)interstitialAd:(MGInterstitialAd *)rewardAd didFailWithError:(NSError *)error {
    [self showErrorText:@"加载插页广告失败"];
}

- (void)interstitialAdDidLoad:(MGInterstitialAd *)rewardAd {
    [self showSuccessText:@"加载插页广告成功"];
}

- (void)interstitialAdDidClose:(MGInterstitialAd *)rewardAd {
    [self showSuccessText:@"关闭了插页广告"];
    if(self.seg.selectedSegmentIndex == 1){
        [rewardAd loadAd];
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
