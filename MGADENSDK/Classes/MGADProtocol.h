//
//  MGADProtocol.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/1/20.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#ifndef MGADProtocol_h
#define MGADProtocol_h


//关闭广告的两种状态
typedef NS_ENUM (NSInteger,MGADPlayState) {
    MGADPlayState_Finished = 0,
    MGADPlayState_UnFinished = 1
};

// 广告类型
typedef NS_ENUM (NSInteger,MGADType) {
    MGADType_Reward = 0,
    MGADType_Insert = 1,
    MGADType_Banner = 2
};

// 广告平台
typedef NS_ENUM (NSInteger,MGADPlat) {
    MGADPlat_Facebook = 0,
    MGADPlat_Google = 1,
    MGADPlat_Unity = 2
};

typedef void(^MGLoadADBlock)(BOOL isEnded, NSError *error);





#endif /* MGADProtocol_h */
