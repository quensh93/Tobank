//
//  SecurePluginUtil.swift
//  secure_plugin
//
//  Created by Parham Hatanian on 4/22/22.
//

import Foundation
import LocalAuthentication

internal class SecurePluginUtil {
    static let kycHasRunBeforeKey: String = "ekyc_has_run_before"
    
    internal static func isAppUninstalled() -> Bool {
        let hasRunBefore = UserDefaults.standard.bool(forKey: kycHasRunBeforeKey)
        return hasRunBefore != true
    }
    
    internal static func resetKeychainOnUninstall(phoneNumberTag: String) {
        resetKeychain(phoneNumberTag: phoneNumberTag)
        UserDefaults.standard.set(true, forKey: kycHasRunBeforeKey)
    }
    
    internal static func resetKeychain(phoneNumberTag: String) {
        KeyChainUtil.removeTag(tagName: phoneNumberTag)
    }
    
    internal static func logout(phoneNumberTag: String) {
        resetKeychain(phoneNumberTag: phoneNumberTag)
    }
    
    internal static func generateKey(phoneNumberTag: String, callback: @escaping (_ responseModel: ResponseModel) -> Void) {
        if isAppUninstalled() {
            resetKeychainOnUninstall(phoneNumberTag: phoneNumberTag)
        }
        resetKeychain(phoneNumberTag: phoneNumberTag)
        var responseModel = ResponseModel()
        
        do {
            let secKey = try KeyChainUtil.makeAndStoreKey(tagName: phoneNumberTag, requiresBiometry: false)
            let publicKey = getPublicKeyStringSecKey(from: secKey)
            
            responseModel.message = "Key generated"
            responseModel.data = publicKey
            responseModel.isSuccess = true
            responseModel.statusCode = 200
            callback(responseModel)
            return
        } catch let error {
            var responseModel = ResponseModel()
            responseModel.statusCode = 500
            responseModel.isSuccess = false
            responseModel.data = nil
            responseModel.message = error.localizedDescription
            callback(responseModel)
            return
        }
    }
    
    internal static func signData(phoneNumberTag: String, data: Data, callback: @escaping (_ responseModel: ResponseModel) -> Void) {
        requestBiometric { status in
            var responseModel = ResponseModel()
            if status == .Verified {
                do {
                    guard let secKey = try loadKey(phoneNumberTag: phoneNumberTag) else {
                        responseModel.message = "Key not found"
                        responseModel.statusCode = 404
                        responseModel.data = nil
                        responseModel.isSuccess = false
                        callback(responseModel)
                        return
                    }
                    KeyChainUtil.sign(algorithm: .rsaSignatureMessagePKCS1v15SHA256, data: data, key: secKey) { signedText in
                        guard let signedText = signedText else {
                            responseModel.message = "Data not signed"
                            responseModel.statusCode = 500
                            responseModel.data = nil
                            responseModel.isSuccess = false
                            callback(responseModel)
                            return
                        }

                        responseModel.message = "Data signed"
                        responseModel.statusCode = 200
                        responseModel.data = signedText
                        responseModel.isSuccess = true
                        callback(responseModel)
                        return
                    }
                } catch let error {
                    responseModel.isSuccess = false
                    responseModel.statusCode = 500
                    responseModel.data = nil
                    responseModel.message = error.localizedDescription
                    callback(responseModel)
                    return
                }
            } else {
                responseModel.isSuccess = false
                responseModel.statusCode = 500
                responseModel.data = nil
                responseModel.message = status.rawValue
                callback(responseModel)
                return
            }
        }
    }
    
    internal static func decryptText(phoneNumberTag: String, encryptedText: String, callback: @escaping (_ responseModel: ResponseModel) -> Void) {
        requestBiometric { status in
            var responseModel = ResponseModel()
            if status == .Verified {
                do {
                    guard let secKey = try loadKey(phoneNumberTag: phoneNumberTag) else {
                        responseModel.message = "Key not found"
                        responseModel.statusCode = 404
                        responseModel.data = nil
                        responseModel.isSuccess = false
                        callback(responseModel)
                        return
                    }
                    
                    KeyChainUtil.decrypt(algorithm: .rsaEncryptionPKCS1, encryptedData: encryptedText.data(using: .utf8)!, key: secKey) { decrypted in
                        responseModel.message = "Data decrypted"
                        responseModel.statusCode = 200
                        responseModel.data = decrypted
                        responseModel.isSuccess = true
                        callback(responseModel)
                        return
                    }
                } catch let error {
                    responseModel.isSuccess = false
                    responseModel.statusCode = 500
                    responseModel.data = nil
                    responseModel.message = error.localizedDescription
                    callback(responseModel)
                    return
                }
            } else {
                responseModel.isSuccess = false
                responseModel.statusCode = 500
                responseModel.data = nil
                responseModel.message = status.rawValue
                callback(responseModel)
                return
            }
        }
    }
    
    internal static func loadKey(phoneNumberTag: String) throws -> SecKey? {
        
        var secKey: SecKey?
        
        if isAppUninstalled() {
            resetKeychainOnUninstall(phoneNumberTag: phoneNumberTag)
        } else {
            secKey = KeyChainUtil.loadKey(tagName: phoneNumberTag)
        }
        
        return secKey
    }
    
    internal static func isKeyExists(phoneNumberTag: String) throws -> Bool {
        
        var keyExists = false
        
        let secKey = try loadKey(phoneNumberTag: phoneNumberTag)
        keyExists = secKey != nil
        
        return keyExists
    }
    
    internal static func getPrivateKey(phoneNumberTag: String, callback: @escaping (_ responseModel: ResponseModel) -> Void) {
        requestBiometric { status in
            var responseModel = ResponseModel()
            if status == .Verified {
                do {
                    guard let secKey = try loadKey(phoneNumberTag: phoneNumberTag) else {
                        responseModel.message = "Key not found"
                        responseModel.statusCode = 404
                        responseModel.data = nil
                        responseModel.isSuccess = false
                        callback(responseModel)
                        return
                    }
                    
                    var error:Unmanaged<CFError>?
                    var data = SecKeyCopyExternalRepresentation(secKey, &error)! as Data
                    
                    responseModel.message = ""
                    responseModel.statusCode = 200
                    responseModel.data = data.base64EncodedString()
                    responseModel.isSuccess = true
                    callback(responseModel)
                    return
                    
                } catch let error {
                    responseModel.isSuccess = false
                    responseModel.statusCode = 500
                    responseModel.data = nil
                    responseModel.message = error.localizedDescription
                    callback(responseModel)
                    return
                }
            } else {
                responseModel.isSuccess = false
                responseModel.statusCode = 500
                responseModel.data = nil
                responseModel.message = status.rawValue
                callback(responseModel)
                return
            }
        }
    }
    
    internal static func getPublicKey(phoneNumberTag: String, callback: @escaping (_ responseModel: ResponseModel) -> Void) {
        var responseModel = ResponseModel()
        do {
            guard let secKey = try loadKey(phoneNumberTag: phoneNumberTag) else {
                responseModel.message = "Key not found"
                responseModel.statusCode = 404
                responseModel.data = nil
                responseModel.isSuccess = false
                callback(responseModel)
                return
            }
            
            responseModel.message = ""
            responseModel.statusCode = 200
            responseModel.data = getPublicKeyStringSecKey(from: secKey)
            responseModel.isSuccess = true
            callback(responseModel)
            return
            
        } catch let error {
            responseModel.isSuccess = false
            responseModel.statusCode = 500
            responseModel.data = nil
            responseModel.message = error.localizedDescription
            callback(responseModel)
            return
        }
    }
    
    private static func getPublicKeyStringSecKey(from secKey: SecKey) -> String {
        let publicKey = SecKeyCopyPublicKey(secKey)!
        var error:Unmanaged<CFError>?
        let cfdata = SecKeyCopyExternalRepresentation(publicKey, &error)
        let data = cfdata! as Data
        let pemPrefixBuffer :[UInt8] = [
            0x30, 0x81, 0x9f, 0x30, 0x0d, 0x06, 0x09, 0x2a,
            0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01,
            0x05, 0x00, 0x03, 0x81, 0x8d, 0x00
        ]
        var finalPemData = Data(bytes: pemPrefixBuffer as [UInt8], count: pemPrefixBuffer.count)
        finalPemData.append(data)
        let finalPemString = finalPemData.base64EncodedString()
        return finalPemString
    }
    
    private static func requestBiometric(callback: @escaping (_ status: BiometricStatusEnum) -> Void) {
        if hasBiometric() {
            let reason = "احراز هویت"
            LAContext().evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                DispatchQueue.main.async {
                    if success {
                        callback(.Verified)
                        return
                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        if let error = error as? LAError {
                            callback(mapLAError(errorCode: error.code))
                        }else{
                            callback(.Cancelled)
                        }
                        return
                    }
                }
                
            }
        } else {
            callback(.NoPasscode)
            return
        }
        
    }
    
    private static func mapLAError(errorCode: LAError.Code) -> BiometricStatusEnum {
        
        switch errorCode {
        case .appCancel,
                .authenticationFailed,
                .invalidContext,
                .notInteractive,
                .systemCancel,
                .userFallback,
                .biometryLockout,
                .biometryNotEnrolled,
                .touchIDNotAvailable,
                .touchIDNotEnrolled,
                .touchIDLockout,
                .userCancel:
            return .Cancelled
        case .passcodeNotSet:
            return .NoPasscode
        case .biometryNotAvailable:
            return .NoPermission
            
        @unknown default:
            return .Cancelled
        }
    }
    
    private static func hasBiometric() -> Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
}
