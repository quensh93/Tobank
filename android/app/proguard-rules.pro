# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.**

# Prevent R8 from crashing on missing PDFBox classes
-dontwarn com.gemalto.jp2.**
-dontwarn com.tom_roush.pdfbox.**
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# Keep secure_plugin models/APIs stable in release.
# The plugin serializes Kotlin objects with Gson and parses them in Dart by exact key names.
# If R8 shrinks/obfuscates/merges these classes, signing responses can break only in release.
-keep class com.gardeshpay.secure_plugin.ResponseDataModel { *; }
-keep class com.gardeshpay.secure_plugin.SecurePlugin { *; }
-keep class com.gardeshpay.secure_plugin.SecurityImplementation { *; }
-keep class com.gardeshpay.secure_plugin.** { *; }
