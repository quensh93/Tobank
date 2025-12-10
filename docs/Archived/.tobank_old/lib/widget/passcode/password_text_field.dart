import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../new_structure/core/theme/main_theme.dart';
import '../../util/app_theme.dart';
import '../../util/app_util.dart';
import '../svg/svg_icon.dart';

enum Screen { settings, newScreen, enter }

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    required this.screen,
    required this.hintText,
    required this.errorText,
    required this.isValid,
    required this.isNumerical,
    super.key,
    this.hasNext,
    this.controller,
    this.currentFocusNode,
    this.nextFocusNode,
    this.onchanged
  });

  final String hintText;
  final String errorText;
  final bool isValid;
  final Screen screen;
  final bool? hasNext;
  final TextEditingController? controller;
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;
  final bool isNumerical;
  final Function(String)? onchanged;

  @override
  PasswordTextFieldState createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool _passwordVisible = false;

  bool? _hasNext = false;
  FocusNode? _currentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (widget.hasNext != null) {
      _hasNext = widget.hasNext;
    }
    if (widget.currentFocusNode != null) {
      _currentFocusNode = widget.currentFocusNode;
    }

    return TextField(
      onSubmitted: (text) {
        if (widget.nextFocusNode != null) {
          AppUtil.fieldFocusChange(context, _currentFocusNode!, widget.nextFocusNode);
        } else {
          AppUtil.hideKeyboard(context);
        }
      },
      obscureText: !_passwordVisible,
      obscuringCharacter: '*',
      controller: widget.controller,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      focusNode: _currentFocusNode,
      textInputAction: _hasNext! ? TextInputAction.next : TextInputAction.done,
      keyboardType: widget.isNumerical ? TextInputType.number : TextInputType.text,
      inputFormatters: widget.isNumerical
          ? <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ]
          : [],
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
      onChanged: (value) {
        if( widget.onchanged != null){
          widget.onchanged!(value);
        }
        setState(() {
          widget.controller;
        });
      },

      decoration: InputDecoration(
        filled: false,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        errorText: !widget.isValid ? widget.errorText : null,
        border: OutlineInputBorder(
          borderSide:
          widget.screen != Screen.enter ? BorderSide.none : const BorderSide(color: AppTheme.buttonBorderColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        suffixIcon: widget.controller!.text.isNotEmpty
            ? InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SvgIcon(
              _passwordVisible ? SvgIcons.showPassword : SvgIcons.hidePassword,
              colorFilter: ColorFilter.mode(MainTheme.of(context).surfaceContainer, BlendMode.srcIn),
              size: 24.0,
            ),
          ),
        )
            : Container(
          width: 16.0,
        ),
      ),
    );
  }
}
