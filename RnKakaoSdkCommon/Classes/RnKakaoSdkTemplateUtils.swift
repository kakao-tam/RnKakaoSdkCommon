//
//  RnKakaoSdkTemplateUtils.swift
//  RnKakaoSdkCommon
//
//  Created by kakao on 2022/07/27.
//

import Foundation

import KakaoSDKTemplate

public class TemplateUtils {
    enum CodingKeys: String, CodingKey {
        case templatable, objectType
    }
    
    public static func toTemplatable(decoder: Decoder) -> Templatable? {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            if let templatableValues = try? values.nestedContainer(keyedBy: CodingKeys.self, forKey: .templatable) {
                let objectType = try? templatableValues.decode(String.self, forKey: .objectType)
                switch objectType {
                case "feed":
                    if let feed = try? values.decode(FeedTemplate.self, forKey: .templatable) {
                        return feed
                    }
                    break;
                case "list":
                    if let list = try? values.decode(ListTemplate.self, forKey: .templatable) {
                        return list
                    }
                    break;
                case "location":
                    if let location = try? values.decode(LocationTemplate.self, forKey: .templatable) {
                        return location
                    }
                    break;
                case "commerce":
                    if let commerce = try? values.decode(CommerceTemplate.self, forKey: .templatable) {
                        return commerce
                    }
                    break;
                case "text":
                    if let text = try? values.decode(TextTemplate.self, forKey: .templatable) {
                        return text
                    }
                    break;
                default:
                    return nil
                }
            }
        }
        return nil
    }
}
