# 配合联运SDK

如果您的应用在接入广告SDK的同时，也接入了新浪游戏的联运SDK，则需要做以下配置

1. 广告SDK启动前的配置`existSinaUnionSDK`设置为`YES`

   ```
   - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
       MGADMobileAds.sharedInstance.existSinaUnionSDK = YES;
       [[MGADMobileAds sharedInstance] startMobileAdsSDK];
       
       return YES;
   }
   ```

   

2. 在联运SDK的登陆成功回调中设置`uid`

   ```
   - (void)mg_login:(MGUnionENSDKUser *)user error:(MGAuthErrCode)error {
       if (error == MGSDKAuth_Err_Ok) {
           NSLog(@"登录成功---%@",user.userID);
           MGADMobileAds.sharedInstance.userID = user.userID;
       } else {
           NSLog(@"登录失败");
       }
   }
   ```

   