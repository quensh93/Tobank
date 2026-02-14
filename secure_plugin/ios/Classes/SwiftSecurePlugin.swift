import Flutter
import UIKit

public class SwiftSecurePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "secure_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftSecurePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            platformVersion(result: result)
            break
        case "isEnroll":
            let args = call.arguments as! [String: Any]
            let phoneNumberTag = args["phoneNumber"] as! String
            isKeyExists(phoneNumberTag: phoneNumberTag, result: result)
            break
        case "generateKeys":
            let args = call.arguments as! [String: Any]
            let phoneNumberTag = args["phoneNumber"] as! String
            generateKeyPairs(phoneNumberTag: phoneNumberTag, result: result)
            break
        case "signText":
            let args = call.arguments as! [String: Any]
            let plainText = args["plainText"] as! String
            let phoneNumberTag = args["phoneNumber"] as! String
            signText(phoneNumberTag: phoneNumberTag, plainText: plainText, result: result)
            break
        case "signBytes":
            let args = call.arguments as! [String: Any]
            let phoneNumberTag = args["phoneNumber"] as! String
            let data = args["bytesData"] as! FlutterStandardTypedData
            signData(phoneNumberTag: phoneNumberTag, data: data.data, result: result)
            break
        case "removeKey":
            let args = call.arguments as! [String: Any]
            let phoneNumberTag = args["phoneNumber"] as! String
            logout(phoneNumberTag: phoneNumberTag, result: result)
            break
        case "decrypt":
            let args = call.arguments as! [String: Any]
            let encryptedText = args["ecryptedText"] as! String
            let phoneNumberTag = args["phoneNumber"] as! String
            decrypt(phoneNumberTag: phoneNumberTag, encryptedText: encryptedText, result: result)
            break
        case "getPrivateKey":
            let args = call.arguments as! [String: Any]
            let phoneNumberTag = args["phoneNumber"] as! String
            getPrivateKey(phoneNumberTag: phoneNumberTag, result: result)
            break
        case "getPublicKey":
            let args = call.arguments as! [String: Any]
            let phoneNumberTag = args["phoneNumber"] as! String
            getPublicKey(phoneNumberTag: phoneNumberTag, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
}

private extension SwiftSecurePlugin {
    private func platformVersion(result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    private func isKeyExists(phoneNumberTag: String, result: @escaping FlutterResult) {
        do {
            var responseModel = ResponseModel()
            let isExists = try SecurePluginUtil.isKeyExists(phoneNumberTag: phoneNumberTag)
            
            if isExists {
                responseModel.statusCode = 200
                responseModel.isSuccess = true
                responseModel.message = "Key found"
                responseModel.data = "true"
            }else{
                responseModel.statusCode = 404
                responseModel.isSuccess = false
                responseModel.message = "Key not found"
                responseModel.data = nil
            }
            result(responseModel.encodeToJson())
        } catch let error {
            var responseModel = ResponseModel()
            responseModel.statusCode = 500
            responseModel.isSuccess = false
            responseModel.data = nil
            responseModel.message = error.localizedDescription
            result(responseModel.encodeToJson())
        }
    }
    
    private func generateKeyPairs(phoneNumberTag: String, result: @escaping FlutterResult) {
        SecurePluginUtil.generateKey(phoneNumberTag: phoneNumberTag, callback: { responseModel in
            result(responseModel.encodeToJson())
        })
    }
    
    private func signText(phoneNumberTag: String, plainText: String, result: @escaping FlutterResult) {
        let data = plainText.data(using: .utf8)!
        SecurePluginUtil.signData(phoneNumberTag: phoneNumberTag, data: data) { responseModel in
            result(responseModel.encodeToJson())
        }
    }
    
    private func signData(phoneNumberTag: String, data: Data, result: @escaping FlutterResult) {
        SecurePluginUtil.signData(phoneNumberTag: phoneNumberTag, data: data) { responseModel in
            result(responseModel.encodeToJson())
        }
    }
    
    private func logout(phoneNumberTag: String, result: @escaping FlutterResult) {
        SecurePluginUtil.logout(phoneNumberTag: phoneNumberTag)
        var responseModel = ResponseModel()
        responseModel.message = "Key removed successfully"
        responseModel.statusCode = 200
        responseModel.data = nil
        responseModel.isSuccess = true
        result(responseModel.encodeToJson())
    }
    
    private func decrypt(phoneNumberTag: String, encryptedText: String, result: @escaping FlutterResult) {
        SecurePluginUtil.decryptText(phoneNumberTag: phoneNumberTag, encryptedText: encryptedText) { responseModel in
            result(responseModel.encodeToJson())
        }
    }
    
    private func getPrivateKey(phoneNumberTag: String, result: @escaping FlutterResult) {
        SecurePluginUtil.getPrivateKey(phoneNumberTag: phoneNumberTag) { responseModel in
            result(responseModel.encodeToJson())
        }
    }
    
    private func getPublicKey(phoneNumberTag: String, result: @escaping FlutterResult) {
        SecurePluginUtil.getPublicKey(phoneNumberTag: phoneNumberTag) { responseModel in
            result(responseModel.encodeToJson())
        }
    }
}
