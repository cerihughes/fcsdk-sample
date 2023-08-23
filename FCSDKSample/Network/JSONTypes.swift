//
//  JSONTypes.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import Foundation

struct LoginRequest: Encodable {
    var username: String
    var password: String
}

struct LoginResponse: Decodable {
    var id: UUID?
    var sessionid: String
    var voiceUser: String
    var voiceDomain: String
}
