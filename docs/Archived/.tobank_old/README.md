# برنامه توبانک

برای اجرای برنامه در لینوکس ابتدا باید فلاتر، دارت و اندروید استدیو را نصب کنید. لزوم نصب اندروید
استدیو این است که مجموعه فایل‌های مورد نیاز برای build برنامه را دانلود کند. برای نصب فلاتر به این
لینک مراجعه کنید:

```bash
https://flutter.dev/docs/get-started/install/linux
```

## اجرای برنامه در حالت توسعه

برای اجرای برنامه بر روی گوشی اندروید دستور:

```bash
flutter run --flavor development
```

را اجرا کنید. برنامه پس از ساخته شدن، بر روی گوشی اجرا خواهد شد.

برای اجرای برنامه از طریق اندروید استدیو، به تنظیمات مربوط به اجرای برنامه و بخش build flavor مقدار
development را اضافه کنید.

## اجرای برنامه در حالت تست

برای اجرای برنامه بر روی گوشی اندروید دستور:

```bash
flutter run --flavor servertest
```

را اجرا کنید. برنامه پس از ساخته شدن، بر روی گوشی اجرا خواهد شد.

برای اجرای برنامه از طریق اندروید استدیو، به تنظیمات مربوط به اجرای برنامه و بخش build flavor مقدار
servertest را اضافه کنید.

در این حالت اپلیکیشن با application id و نام متفاوت اجرا شده و به سرور تست متصل خواهد بود.

## خروجی استورها

قبل از انجام اینکار نیاز است که فایل‌های مربوط به ساین اپ برای استورها، در پوشه android قرار گیرند.

برای امضای برنامه و تهیه خروجی appbundle برای انتشار در گوگل پلی و سایر استورها از دستور زیر استفاده
کنید:

```bash
flutter build appbundle --flavor production --dart-define=Store=play-store
```

برای خروجی گرفتن به صورت apk

```bash
flutter build apk --flavor production --dart-define=Store=play-store
```

را اجرا کنید. نسخه‌های مختلف apk در مسیر مشخص شده در دسترس خواهند بود.


جهت اضافه کردن استور مربوط به خروجی مقدار های env-type برای خروجی استور ها

[play-store, myket, cafe-bazaar, direct, anardoni, sibche, sibapp, iapps, unknown]

نکته: درصورتی که در env-type ارسال نشه مقدار استور unknown قرار میگیره

برای اجرا در اندروید استودیو این تکه کد رو در Edit configuration به Additional run args اضافه کنید

```bash
--dart-define=Store={env-type}
```

برای اجرای برنامه در Commandline از دستور زیر استفاده میکنیم

```bash
flutter run --flavor servertest --dart-define=Store={env-type}
```


### Android Emulator: Disable Web Security Quick Guide

## Connect to Local Server
```bash
# Enable port forwarding
adb reverse tcp:PORT tcp:PORT

# Try this first
adb shell "am start -n com.android.chrome/com.google.android.apps.chrome.Main -d 'about:blank' --ez \"disable_web_security\" true"

# If above fails, try this
adb shell "am start -a android.intent.action.VIEW -d 'chrome://flags/#disable-web-security' -n com.android.chrome/com.google.android.apps.chrome.Main"
```
https://ipg.gardeshpay.ir/v1/provider/payment/redirect/1403121807581998242
"https://appapi.tobank.ir/api/v2/wallets/charge/payment"



http://localhost:8000/
https://pwa-test.tobank.ir/callback?transaction=1159&amp;device=pwa&amp;token=5OSemtzJLPXW3dlzu8St4YwfSLkSXu6y
http://localhost:8000/callback?transaction=1159&amp;device=pwa&amp;token=bHAxXZLroukj95j64zh8rxZpUX99hG5M
