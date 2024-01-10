//
//  Token.swift
//  SampleApp
//
//  Created by AlKalouti on 12/11/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import Foundation

struct Token: Codable {
    let signature: String
    let language: String
    let service_command: String
    let access_code: String
    let response_code: String
    let device_id: String
    let merchant_identifier: String
    let status: String
    let response_message: String
    let sdk_token: String?
}
