//
//  RnKakaoSdkObjC.h
//  Pods
//
//  Created by kakao on 2022/07/07.
//

#import <Foundation/Foundation.h>

@interface RnKakaoSdkObjC : NSObject

+ (nullable NSError *)tryCatch:(void(^_Nonnull)(void))tryBlock;
@end
