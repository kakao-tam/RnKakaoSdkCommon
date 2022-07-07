//
//  RnKakaoSdkInitializer.swift
//  RnKakaoSdkCommon
//
//  Created by kakao on 2022/07/07.
//

import Foundation

import KakaoSDKCommon

public final class RnKakaoSdkInitializer {
    public static let shared = RnKakaoSdkInitializer()

    public var initialized: Bool = false

    private init() {}

    public func ensure() {
        if !initialized {
            let appKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String
            if let appKey = appKey {
                KakaoSDK.initSDK(appKey: appKey)
                initialized = true
            }
        }
    }
}
