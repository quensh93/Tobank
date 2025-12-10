import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/security/security_controller.dart';
import '../common/custom_app_bar.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SecurityController>(
        init: SecurityController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.test_sign_plugin,
              context: context,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  controller.generateKeys();
                                },
                                child: Text(
                                 locale.generate_key,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16.0,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.checkIsEnroll();
                                },
                                child:  Text(
                                  locale.check_key_existence,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.signText();
                                },
                                child:  Text(
                                  locale.sign_text,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.verifyData();
                                },
                                child: Text(
                                  locale.verify_signature,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.signBytes();
                                },
                                child: Text(
                                  locale.sign_bytes,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.verifyBytes();
                                },
                                child: Text(
                                  locale.verify_signature_bytes,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.removeKey();
                                },
                                child: Text(
                                  locale.remove_key,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.signPDF();
                                },
                                child: Text(
                                 locale.sign_pdf,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.getPublicKey();
                                },
                                child: Text(
                                  locale.get_key,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              minLines: 4,
                              maxLines: 20,
                              keyboardType: TextInputType.multiline,
                              controller: controller.textFieldController,
                              textDirection: TextDirection.ltr,
                              decoration: const InputDecoration(
                                filled: false,
                                hintText: '',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
