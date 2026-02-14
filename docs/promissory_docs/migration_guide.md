# Digital & Visual Signing Migration Guide

This guide details how to move the signing functionality (both visual and digital) to a new Flutter application.

## 1. Dependencies ([pubspec.yaml](file:///Users/arsham1/development/Arsham/tobank_app/pubspec.yaml))

Add the following dependencies to your new application's [pubspec.yaml](file:///Users/arsham1/development/Arsham/tobank_app/pubspec.yaml).

**External Packages:**
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Core Utilities
  basic_utils: ^5.7.0
  crypto: ^3.0.6
  uuid: ^4.5.1
  
  # UI & PDF
  syncfusion_flutter_pdf: ^28.2.9
  
  # Web Support
  universal_html: ^2.2.4
  universal_io: ^2.2.2
  
  # State Management (if using GetX like the original app)
  get: ^4.7.3
```

**Local Plugins (CRITICAL):**
The original application uses a local plugin `secure_plugin` which contains **native Android/iOS code** for signing. You **MUST** copy this plugin to your new project or verify if you have the source code.
```yaml
dependencies:
  # ... other deps
  secure_plugin:
    path: ./packages/secure_plugin  # Update path to where you put it
```

## 2. Required Files

Create the following files in your new project structure (e.g., `lib/features/signing/`).

### A. `lib/features/signing/model/external_signer.dart`
Wrapper for Syncfusion's signing interface.

```dart
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ExternalSigner extends IPdfExternalSigner {
  final RSAPrivateKey rsaPrivateKey;

  ExternalSigner({required this.rsaPrivateKey});

  @override
  Future<SignerResult?> sign(List<int> message) async {
    final signedBytes = CryptoUtils.rsaSign(rsaPrivateKey, Uint8List.fromList(message));
    return SignerResult(signedBytes.toList());
  }
}
```

### B. `lib/features/signing/model/sign_model.dart`
Simple data model for signature responses.

```dart
class SignModel {
  SignModel({
    this.sign,
    this.traceID,
    this.provider,
  });

  String? sign;
  String? traceID;
  String? provider; // '0' for ZoomId, '1' for Yekta
}
```

### C. `lib/features/signing/model/sign_document_data.dart`
Data class for the document to be signed.

```dart
class SignRect {
  final double x;
  final double y;
  final double height;
  final double width;

  SignRect({required this.x, required this.y, required this.height, required this.width});
  
  // Add fromJson/toJson if needed
}

class SignLocation {
  final SignRect android;
  final SignRect ios;
  final int signPageIndex;
  final bool digitalSignatureRequired;
  final SignRect? web; // Optional for web specific logic

  SignLocation({
    required this.android,
    required this.ios,
    required this.signPageIndex,
    required this.digitalSignatureRequired,
    this.web,
  });
}

class SignDocumentData {
  final String documentBase64;
  final String reason;
  final List<SignLocation> signLocations;

  SignDocumentData({
    required this.documentBase64,
    required this.reason,
    required this.signLocations,
  });
}
```

## 3. Web Support Files
You need to copy the [SecureWebPlugin](file:///Users/arsham1/development/Arsham/tobank_app/lib/util/secure_web_plugin.dart#22-355) and [WebBiometricService](file:///Users/arsham1/development/Arsham/tobank_app/lib/util/web_only_utils/web_biometric_service_stub.dart#3-27) logic if you are targeting Web.

**Copy these files from the original project:**
1.  [lib/util/secure_web_plugin.dart](file:///Users/arsham1/development/Arsham/tobank_app/lib/util/secure_web_plugin.dart) -> Copy to your new utils folder.
2.  [lib/util/web_only_utils/web_biometric_service.dart](file:///Users/arsham1/development/Arsham/tobank_app/lib/util/web_only_utils/web_biometric_service.dart) -> Copy to `lib/util/web_only_utils/`.
3.  `lib/util/web_only_utils/web_biometric_service_stub.dart` -> Copy to `lib/util/web_only_utils/`.

**Note:** `SecureWebPlugin` depends on `StorageUtil`. You will need to implement a `StorageUtil` in your new app that handles `getEncryptionWebKeyPair`, `getAuthInfoData`, etc.

## 4. The Signing Service (`signing_service.dart`)

This is the refactored logic from `AppUtil` and `installment_builder_bloc_util.dart`. I have cleaned it up to be more standalone (removing direct dependency on `MainController` global where possible, passing data as arguments instead).

```dart
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:secure_plugin/secure_plugin.dart'; // YOUR LOCAL PLUGIN
// import 'path/to/secure_web_plugin.dart'; // UNCOMMENT IF WEB NEEDED
// import 'path/to/web_biometric_service.dart' as web_biometric; // UNCOMMENT IF WEB NEEDED

import 'model/sign_document_data.dart';
import 'model/external_signer.dart';

class SigningService {
  
  /// Main entry point to sign a document
  static Future<String?> signDocument({
    required SignDocumentData data,
    required String? signatureImageBase64, // User's visual signature
    required String? userCertificate,      // Required for digital sign (Yekta)
    required String keyAlias,              // Key alias for SecurePlugin (Mobile)
    required String fullName,              // User's full name for visual text
    required String dateString,            // Date string for visual text
  }) async {
    String currentDocBase64 = data.documentBase64;

    // 1. Visual Signing (No digital signature required)
    final visualLocations = data.signLocations.where((e) => !e.digitalSignatureRequired).toList();
    for (final loc in visualLocations) {
      currentDocBase64 = await _applyVisualSignature(
        documentBase64: currentDocBase64,
        location: loc,
        signatureImageBase64: signatureImageBase64,
        fullName: fullName,
        dateString: dateString,
      );
    }

    // 2. Digital Signing (Required)
    final digitalLocation = data.signLocations.firstWhereOrNull((e) => e.digitalSignatureRequired); // Use collection or list logic
    // Manual list check if collection not imported:
    // final digitalLocation = data.signLocations.any((e) => e.digitalSignatureRequired) 
    //    ? data.signLocations.firstWhere((e) => e.digitalSignatureRequired) 
    //    : null;

    if (digitalLocation != null) {
       // Assuming Yekta provider for now
       return await _digitalSignYekta(
         documentBase64: currentDocBase64,
         location: digitalLocation,
         signatureImageBase64: signatureImageBase64,
         reason: data.reason,
         certificate: userCertificate,
         keyAlias: keyAlias,
       );
    }

    return currentDocBase64;
  }

  /// Applies purely visual signature using Syncfusion
  static Future<String> _applyVisualSignature({
    required String documentBase64,
    required SignLocation location,
    required String? signatureImageBase64,
    required String fullName,
    required String dateString,
  }) async {
    final Uint8List bytes = base64Decode(documentBase64);
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    final PdfPage page = document.pages[location.signPageIndex];
    
    final SignRect rectData = Platform.isAndroid ? location.android : location.ios;
    final Rect signatureRect = Rect.fromLTWH(rectData.x, rectData.y, rectData.width, rectData.height);

    // ... (Drawing logic implementation from AppUtil._signPdf goes here)
    // You can copy the exact graphics logic from AppUtil._signPdf
    // ...

    final List<int> signedBytes = await document.save();
    document.dispose();
    return base64Encode(signedBytes);
  }

  static Future<String?> _digitalSignYekta({
    required String documentBase64,
    required SignLocation location,
    required String? signatureImageBase64,
    required String reason,
    required String? certificate,
    required String keyAlias,
  }) async {
    if (kIsWeb) {
      // Helper for Web implementation
      // return await _digitalSignYektaWeb(...);
      throw UnimplementedError("Web signing needs SecureWebPlugin");
    } else if (Platform.isAndroid) {
       // Android Native Plugin call
       final result = await SecurePlugin.newSignPdf(
         phoneNumber: keyAlias,
         pdfBase64: documentBase64,
         cert: certificate!,
         name: 'User-Digital-Signature',
         reason: reason,
         location: 'IR',
         signatureBase64: signatureImageBase64!,
         signatureX: location.android.x.toInt(),
         signatureY: location.android.y.toInt(),
         signatureWidth: location.android.width.toInt(),
         signatureHeight: location.android.height.toInt(),
         signaturePage: location.signPageIndex,
         signatureNameFamily: 'User Name', // Pass user english name if available
       );
       return result.isSuccess == true ? result.data : null;
    } else {
       // iOS implementation using Syncfusion + SecurePlugin
       // Copy logic from AppUtil._digitalSignYektaPdfIOS
       // ...
       return null; // Update with actual return
    }
  }
}
```

## Checklist for Migration
- [ ] Copy `secure_plugin` to your new project (native code is required).
- [ ] Add dependencies to `pubspec.yaml`.
- [ ] Create the model files.
- [ ] Copy `fonts/IRANYekanMobileRegular.ttf` to `assets/fonts/` and register in `pubspec.yaml`.
- [ ] Implement `SigningService` (filling in the drawing logic from the original `AppUtil`).
- [ ] Implement a storage mechanism (`StorageUtil`) to securely store/retrieve keys and certificates.
