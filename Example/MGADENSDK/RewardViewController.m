//
//  RewardViewController.m
//  WGADSDKDemo
//
//  Created by Mr.Song on 2020/2/18.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import "RewardViewController.h"
#import "MGRewardedAd.h"
#import "NSObject+ALiHUD.h"

@interface RewardViewController ()<MGRewardedAdDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ad1Field;
@property (weak, nonatomic) IBOutlet UITextField *ad2Field;
@property (weak, nonatomic) IBOutlet UITextField *ad3Field;

@property(nonatomic, strong)MGRewardedAd    *rewardAd1;
@property(nonatomic, strong)MGRewardedAd    *rewardAd2;
@property(nonatomic, strong)MGRewardedAd    *rewardAd3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;


@end

@implementation RewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loadAd1:(id)sender {
    if(self.ad1Field.text.length < 1) {
        [self showErrorText:@"请输入adid"];
        return;
    }
    if(!self.rewardAd1) {
        self.rewardAd1 = [[MGRewardedAd alloc] initWithAdid:self.ad1Field.text];
        self.rewardAd1.delegate = self;
      //  [self.rewardAd1 setRewardDataWithUserID:@"USER_ID" withCurrency:@"CURRENCY"];
    }
    [self.rewardAd1 loadAd];
}
- (IBAction)loadAd2:(id)sender {
    if(self.ad2Field.text.length < 1) {
        [self showErrorText:@"请输入adid"];
        return;
    }
     if(!self.rewardAd2) {
           self.rewardAd2 = [[MGRewardedAd alloc] initWithAdid:self.ad2Field.text];
           self.rewardAd2.delegate = self;
       }
    [self.rewardAd2 loadAd];
}
- (IBAction)loadAd3:(id)sender {
    if(self.ad3Field.text.length < 1) {
        [self showErrorText:@"请输入adid"];
        return;
    }
     if(!self.rewardAd3) {
           self.rewardAd3 = [[MGRewardedAd alloc] initWithAdid:self.ad3Field.text];
           self.rewardAd3.delegate = self;
       }
    [self.rewardAd3 loadAd];
}
- (IBAction)showAd1:(id)sender {
    if(self.rewardAd1.isAdValid) {
       [self.rewardAd1 showAdFromRootViewController:self];
    } else {
        [self showErrorText:@"广告未就绪"];
    }
}
- (IBAction)showAd2:(id)sender {
   if(self.rewardAd2.isAdValid) {
       [self.rewardAd2 showAdFromRootViewController:self];
    } else {
        [self showErrorText:@"广告未就绪"];
    }
}
- (IBAction)showAd3:(id)sender {
    if(self.rewardAd3.isAdValid) {
       [self.rewardAd3 showAdFromRootViewController:self];
    } else {
        [self showErrorText:@"广告未就绪"];
    }
}


#pragma mark MGInterstitialAdDelegate
- (void)rewardedAd:(MGRewardedAd *)rewardAd didFailWithError:(NSError *)error {
    [self showErrorText:@"加载奖励广告失败"];
}

- (void)rewardedAdDidLoad:(MGRewardedAd *)rewardAd {
    [self showSuccessText:@"加载奖励广告成功"];
}

- (void)rewardedAdDidClose:(MGRewardedAd *)rewardAd {
    [self showSuccessText:@"关闭了奖励广告"];

    if(self.seg.selectedSegmentIndex == 1){
        [rewardAd loadAd];
    }
}

- (void)rewardedAd:(MGRewardedAd *)rewardedAd userDidEarnReward:(MGAdReward *)reward  {
    [self showSuccessText:@"发放奖励"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
