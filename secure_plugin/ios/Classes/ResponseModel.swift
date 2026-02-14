//
//  ResponseModel.swift
//  secure_plugin
//
//  Created by Parham Hatanian on 6/4/22.
//

import Foundation

internal struct ResponseModel: Codable {
    var statusCode: Int? = nil
    var data: String? = nil
    var message: String? = nil
    var isSuccess: Bool? = nil
    
    func encodeToJson() -> String {
        return String(data: try! JSONEncoder().encode(self), encoding: .utf8)!
    }
}
