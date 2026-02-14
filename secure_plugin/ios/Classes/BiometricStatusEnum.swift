//
//  BiometricStatusEnum.swift
//  secure_plugin
//
//  Created by Parham Hatanian on 4/24/22.
//

import Foundation

enum BiometricStatusEnum: String {
    case NoPasscode = "Device has no passcode"
    case Verified
    case NoPermission = "App does not have access to biometric"
    case Cancelled = "Authentication canceled"
}
