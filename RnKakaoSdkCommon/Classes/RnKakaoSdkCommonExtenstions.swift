//
//  RnKakaoSdkCommonExtenstions.swift
//  RnKakaoSdkCommon
//
//  Created by kakao on 2022/07/07.
//

import KakaoSDKCommon

public extension Error {
    func rnCode() -> String {
        if let e = self as? SdkError {
            if e.isAuthFailed {
                return "\(e.getAuthError().reason.rawValue)"
            }
            if e.isClientFailed {
                return "\(e.getClientError().reason)"
            }
            if e.isApiFailed {
                return "\(e.getApiError().reason.rawValue)"
            }
        }
        return "UnknownError"
    }

    func rnMessage() -> String {
        if let e = self as? SdkError {
            if e.isAuthFailed {
                if let msg = e.getAuthError().info?.errorDescription {
                    return msg
                }
            }
            if e.isClientFailed {
                if let msg = e.getClientError().message {
                    return msg
                }
            }
            if e.isApiFailed {
                if let msg = e.getApiError().info?.msg {
                    return msg
                }
            }
        }
        return self.localizedDescription
    }
}

public extension NSDictionary {
    private func string(_ key: String,_ defaultValue: String? = nil) -> String? {
        if let data = self[key] {
            return data as? String
        }
        return defaultValue
    }

    private func boolean(_ key: String,_ defaultValue: Bool? = nil) -> Bool? {
        if let data = self[key] {
            return data as? Bool
        }
        return defaultValue
    }

    private func date(_ key: String, _ defaultValue: Date? = nil) -> Date? {
        if let data = self[key] as? NSNumber {
            return Date(timeIntervalSince1970: TimeInterval(truncating: data) / 1000)
        }
        return defaultValue
    }

    private func int(_ key: String, _ defaultValue: Int? = nil) -> Int? {
        if let data = self[key] as? Int {
            return data
        }
        return defaultValue
    }

    private func int64(_ key: String, _ defaultValue: Int64? = nil) -> Int64? {
        if let data = self[key] as? Int64 {
            return data
        }
        return defaultValue
    }

    private func dic(_ key: String) -> NSDictionary? {
        if let data =  self[key] {
            return data as? NSDictionary
        }
        return nil
    }

    private func array(_ key: String) -> NSArray? {
        if let data = self[key] {
            return data as? NSArray
        }
        return nil
    }

    private func stringArray(_ key: String) -> [String]? {
        if let data = self.array("propertyKeys") {
            return data.compactMap{( $0 as? String ?? "" )}
        }
        return nil
    }

    func toParam<T: Decodable>(_ t: T.Type, key: String = "_json_") -> T? {
        if let data = self.string(key)?.data(using: .utf8) {
            return try? SdkJSONDecoder.default.decode(T.self, from: data)
        }
        return nil
    }
}

public class Converter {
    public static let shared = Converter()

    let encoder: JSONEncoder;

    private init() {
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom({ date, encoder in
            var container = encoder.singleValueContainer()
            let mils = date.timeIntervalSince1970 * 1000.0
            try container.encode(Int64(mils.rounded()))
        })
    }

    public func toJson(_ dic: [String:Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic)
            return String(data: jsonData, encoding: String.Encoding.utf8) ?? "{}"
        } catch {
            return "!e{\"desc\":\"\(error.localizedDescription)\",\"msg\":\"\(error)\"}"
        }
    }
}

public extension Encodable {
    func toJsonString() -> String {
        do {
            let jsonData = try Converter.shared.encoder.encode(self)
            return String(data: jsonData, encoding: String.Encoding.utf8) ?? "{}"
        } catch {
            return "!e{\"desc\":\"\(error.localizedDescription)\",\"msg\":\"\(error)\"}"
        }
    }
}
