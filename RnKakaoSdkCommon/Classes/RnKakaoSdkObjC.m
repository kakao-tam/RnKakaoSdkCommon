//
//  RnKakaoSdkObjC.m
//  RnKakaoSdkCommon
//
//  Created by kakao on 2022/07/07.
//

#import "RnKakaoSdkObjC.h"

@implementation RnKakaoSdkObjC

+ (nullable NSError *)tryCatch:(void(^)(void))tryBlock {
    @try {
        tryBlock();
    }
    @catch (NSException *exception) {
        return [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
    @catch (NSError *error) {
        return error;
    }
    return nil;
}

@end
