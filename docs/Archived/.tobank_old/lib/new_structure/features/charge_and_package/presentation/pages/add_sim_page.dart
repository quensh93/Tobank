import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../util/snack_bar_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/services/network/failures/api_failure/api_failure.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../../core/theme/main_theme.dart';
import '../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../core/widgets/buttons/main_button.dart';
import '../../../../core/widgets/buttons/main_text_field.dart';
import '../../../../core/widgets/dialogs/dialog_handler.dart';
import '../bloc/charge_and_package_list_bloc/charge_and_package_list_bloc.dart';
import '../widgets/get_amount/get_amount_bottom_sheet.dart';
import '../widgets/select_operator/select_operator_bottom_sheet.dart';
import 'package_list_page.dart';

class AddSimPage extends StatefulWidget {
  final ChargeAndPackageType type;

  const AddSimPage({
    required this.type,
    super.key,
  });

  @override
  State<AddSimPage> createState() => _AddSimPageState();
}

class _AddSimPageState extends State<AddSimPage> {
  final TextEditingController textController = TextEditingController();
  final ChargeAndPackageListBloc _chargeAndPackageListBloc = getIt<ChargeAndPackageListBloc>();
  late List<ChargeAndPackageListDataEntity> loanPaymentList = [];
  bool isDisable = true;
  String? errorText;

  void getListData() {
    _chargeAndPackageListBloc
        .add(ChargeAndPackageListEvent.getChargeAndPackageList(ChargeAndPackageListParams(
      mobile: textController.text,
      serviceType: widget.type,
    )));
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Text(
                  widget.type == ChargeAndPackageType.CHARGE
                      ? locale.enter_credit_sim_card_number
                      : locale.enter_sim_card_number,
                  style: MainTheme.of(context)
                      .textTheme
                      .titleMedium
                      .copyWith(color: MainTheme.of(context).surfaceContainerHigh),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),

            MainTextField(
                textController: textController,
                onChanged: () {
                  _checkPhoneAndValidate();
                },
                hintText: locale.like_09125848484,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                maxLength: 11,
                errorText: errorText,
                hasError: errorText != null,
                suffixIcon: InkWell(
                  onTap: () async {
                    _accessPermission(context);
                    // final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();
                    // final Contact? contact = await _contactPicker.selectContact();
                    // if(contact!=null && contact.phoneNumbers!=null && contact.phoneNumbers!.isNotEmpty){
                    //   String mobile = contact.phoneNumbers![0].replaceAll(' ', '');
                    //
                    //   if(mobile.startsWith('+')){
                    //     mobile = mobile.replaceFirst('+', '00');
                    //   }
                    //
                    //   if(mobile.startsWith('0098')){
                    //     mobile = mobile.replaceFirst('0098', '0');
                    //   }
                    //
                    //   if(!mobile.startsWith('09')){
                    //     return;
                    //   }
                    //   textController.text = mobile;
                    //   _checkPhoneAndValidate();
                    // }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SvgIcon(
                      SvgIcons.icPickContact,
                    ),
                  ),
                )),

            //new charge
            const Spacer(),
            MainButton(
              widget: BlocProvider(
                create: (BuildContext context) => _chargeAndPackageListBloc,
                child: BlocConsumer<ChargeAndPackageListBloc, ChargeAndPackageListState>(
                  listener: (context, state) {
                    state.maybeMap(
                        loading: (_) {},
                        orElse: () {},
                        loadFailure: (e) {
                          e.maybeWhen(
                              orElse: () {},
                              loadFailure: (AppFailure e) {
                                e.maybeWhen(
                                  orElse: () {
                                    return null;
                                  },
                                  apiFailureService: (ApiFailure e) {
                                    if (e.response != null &&
                                        e.response!['data'] != null &&
                                        !(e.response!['data'] is List) &&
                                        e.response!['data']['status'] == 10808) {
                                      showMainBottomSheet(
                                        context: context,
                                        bottomSheetWidget: SelectOperatorBottomSheet(
                                          phone: textController.text,
                                          chargeAndPackageType: widget.type,
                                        ),
                                      );
                                    } else {
                                      SnackBarUtil.showSnackBar(
                                        title: locale.error_occurred,
                                        message:
                                            e.response!['message'] ?? locale.cant_buy_charge_with_this_number,
                                      );
                                    }
                                  },
                                );
                              });
                        },
                        loadSuccess: (state) {
                          if (widget.type == ChargeAndPackageType.CHARGE) {
                            if (state.chargeAndPackageListResponse.findAllResponse!.content != null &&
                                state.chargeAndPackageListResponse.findAllResponse!.content!.isNotEmpty) {
                              showMainBottomSheet(
                                context: context,
                                bottomSheetWidget: GetAmountBottomSheet(
                                  data: state.chargeAndPackageListResponse,
                                  mobile: textController.text,
                                ),
                              );
                            } else {
                              SnackBarUtil.showSnackBar(
                                title: locale.error_occurred,
                                message: locale.cant_buy_charge_with_this_number,
                              );
                            }
                          } else {
                            Get.to(() => PackageListPage(
                                  chargeAndPackages: state.chargeAndPackageListResponse,
                                  phone: textController.text,
                                ));
                          }
                        });
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      loadSuccess: (_) {
                        return Text(
                          locale.continue_label,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                                color: MainTheme.of(context).staticWhite,
                              ),
                        );
                      },
                      loadFailure: (_) {
                        return Text(
                          locale.continue_label,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                                color: MainTheme.of(context).staticWhite,
                              ),
                        );
                      },
                      orElse: () {
                        return Text(
                          locale.continue_label,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                                color: MainTheme.of(context).staticWhite,
                              ),
                        );
                      },
                      loading: (_) {
                        return SpinKitFadingCircle(
                          itemBuilder: (_, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MainTheme.of(context).staticWhite,
                              ),
                            );
                          },
                          size: 24.0,
                        );
                      },
                    );
                  },
                ),
              ),
              onTap: () {
                if (textController.text.startsWith('09')) {
                  getListData();
                } else {
                  errorText = locale.mobile_number_is_invalid;
                  setState(() {});
                }
              },
              disable: isDisable,
            )
          ],
        ),
      ),
    );
  }

  void _checkPhoneAndValidate() {
    if (textController.text.length == 11) {
      isDisable = false;
    } else {
      isDisable = true;
    }

    if (errorText != null) {
      errorText = null;
    }
    setState(() {});
  }

  Future<void> _accessPermission(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    PermissionStatus status = await Permission.contacts.status;

    if (status.isGranted) {
      _pickContact();
      return;
    }

    DialogHandler.showDialogMessage(
      iconPath: SvgIcons.dialogAlert,
      buildContext: context,
      description: locale.access_to_contact_dialog_message,
      message: locale.access_permission,
      positiveMessage: locale.i_allow,
      negativeMessage: locale.not_yet,
      positiveFunction: () async {
        Get.back();
        status = await Permission.contacts.request();
        if (status.isGranted) {
          _pickContact();
        } else if (status.isPermanentlyDenied) {
          SnackBarUtil.showErrorSnackBar(locale.access_permission_erorr);
        }
      },
      negativeFunction: () async {
        Get.back();
      },
    );
  }

  Future<void> _pickContact() async {
    final FlutterNativeContactPicker contactPicker = FlutterNativeContactPicker();
    final Contact? contact = await contactPicker.selectContact();

    if (contact != null && contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty) {
      String mobile = contact.phoneNumbers![0].replaceAll(' ', '');

      if (mobile.startsWith('+')) {
        mobile = mobile.replaceFirst('+', '00');
      }

      if (mobile.startsWith('0098')) {
        mobile = mobile.replaceFirst('0098', '0');
      }

      if (!mobile.startsWith('09')) {
        return;
      }

      textController.text = mobile;
      _checkPhoneAndValidate();
    }
  }

// void _accessPermission(BuildContext context) async {
//   final locale = AppLocalizations.of(context)!;
//   PermissionStatus status = await Permission.contacts.status;
//
//
//   DialogHandler.showDialogMessage(
//     iconPath: SvgIcons.dialogAlert,
//     buildContext: context,
//     description: locale.access_to_contact_dialog_message ,
//     message: locale.access_permission,
//     positiveMessage: locale.i_allow,
//     negativeMessage: locale.not_yet,
//     positiveFunction: () async {
//
//       if (!status.isGranted) {
//         status = await Permission.contacts.request();
//
//         if (!status.isGranted) {
//
//           Get.back();
//           return;
//         }
//       }
//
//       final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();
//       final Contact? contact = await _contactPicker.selectContact();
//       if (contact != null &&
//           contact.phoneNumbers != null &&
//           contact.phoneNumbers!.isNotEmpty) {
//         String mobile = contact.phoneNumbers![0].replaceAll(' ', '');
//
//         if (mobile.startsWith('+')) {
//           mobile = mobile.replaceFirst('+', '00');
//         }
//
//         if (mobile.startsWith('0098')) {
//           mobile = mobile.replaceFirst('0098', '0');
//         }
//
//         if (!mobile.startsWith('09')) {
//           return;
//         }
//         textController.text = mobile;
//         _checkPhoneAndValidate();
//       }
//     },
//     negativeFunction: () async {
//       Get.back();
//     },
//   );
// }}
}
