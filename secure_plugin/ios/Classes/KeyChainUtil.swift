//
//  KeyChainUtil.swift
//  secure_plugin
//
//  Created by Parham Hatanian on 4/22/22.
//

import Foundation

internal class KeyChainUtil {
    internal static func removeTag(tagName: String) {
        let tag = tagName.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String                 : kSecClassKey,
            kSecAttrApplicationTag as String    : tag,
            kSecAttrKeyType as String           : kSecAttrKeyTypeRSA,
            kSecReturnRef as String             : true
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    static internal func makeAndStoreKey(tagName: String,
                                         requiresBiometry: Bool = false) throws -> SecKey {
        
        let tag = tagName.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecAttrKeyType as String           : kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String     : 1024,
            kSecAttrSynchronizable as String    : false,
            kSecPrivateKeyAttrs as String : [
                kSecAttrIsPermanent as String       : true,
                kSecAttrApplicationTag as String    : tag,
            ]
        ]
        
        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        
        return privateKey
    }
    
    static internal func loadKey(tagName: String) -> SecKey? {
        let tag = tagName.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String                 : kSecClassKey,
            kSecAttrApplicationTag as String    : tag,
            kSecAttrKeyType as String           : kSecAttrKeyTypeRSA,
            kSecReturnRef as String             : true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else {
            return nil
        }
        return (item as! SecKey)
    }
    
    internal static func sign(algorithm: SecKeyAlgorithm, data: Data, key: SecKey, callBack: @escaping (_ signed: String?) -> Void ) {
        guard SecKeyIsAlgorithmSupported(key, .sign, algorithm) else {
            callBack(nil)
            return
        }
        
        DispatchQueue.global().async {
            var error: Unmanaged<CFError>?
            let signature = SecKeyCreateSignature(key,
                                                  algorithm,
                                                  data as CFData,
                                                  &error) as Data?
            DispatchQueue.main.async {
                guard let signature = signature else {
                    callBack(nil)
                    return
                }
                
                let signedText = signature.base64EncodedString()
                
                callBack(signedText)
                
                return
            }
        }
    }
    
    internal static func decrypt(algorithm: SecKeyAlgorithm, encryptedData: Data, key: SecKey, callBack: @escaping (_ decrypted: String?) -> Void ) {
        
        guard SecKeyIsAlgorithmSupported(key, .decrypt, algorithm) else {
            callBack(nil)
            return
        }
        
        DispatchQueue.global().async {
            var error: Unmanaged<CFError>?
            let clearTextData = SecKeyCreateDecryptedData(key,
                                                          algorithm,
                                                          encryptedData as CFData,
                                                          &error) as Data?
            DispatchQueue.main.async {
                guard let clearTextData = clearTextData else {
                    callBack(nil)
                    return
                }
                let clearText = String(data: clearTextData, encoding: .utf8)
                callBack(clearText)
                return
            }
        }
    }
}
