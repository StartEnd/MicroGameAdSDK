//
//  MGADStrategy.h
//  MGADENSDK
//
//  Created by Mr.Song on 2020/2/13.
//  Copyright © 2020 Mr.Song. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGADStrategy : NSObject

@property(nonatomic, copy)NSString      *facebook;
@property(nonatomic, copy)NSString      *google;
@property(nonatomic, copy)NSString      *unity;
@property(nonatomic, strong)NSArray     *order;
@property(nonatomic, assign)NSInteger   status;

@end

NS_ASSUME_NONNULL_END

