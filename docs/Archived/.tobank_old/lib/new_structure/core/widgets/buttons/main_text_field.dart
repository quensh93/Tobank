import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../util/digit_to_word.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../formaters/thousand_separator_input_formatter.dart';
import '../../theme/main_theme.dart';

class MainTextField extends StatefulWidget {
  final TextEditingController textController;
  final Function onChanged;
  final String hintText;
  final Color? borderColor;
  final bool? hasSeparator;
  final bool? hasRialBadge;
  final bool? hasPersianAmount;
  final bool? hasError;
  final bool? isDigit;
  final String? errorText;
  final FocusNode? focusNode;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool isShowCounter;
  final TextAlign? textAlign;
  final TextDirection? textDirection;


  const MainTextField({
    required this.textController,
    required this.onChanged,
    required this.hintText,
    this.hasSeparator,
    this.hasRialBadge,
    this.borderColor,
    this.hasPersianAmount,
    this.hasError,
    this.errorText,
    this.isDigit,
    this.focusNode,
    this.maxLength,
    this.suffixIcon,
    this.textAlign,
    this.textDirection,

    this.isShowCounter = false,
    super.key,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (text) {
            widget.onChanged();
          },
          focusNode: widget.focusNode,
          controller: widget.textController,
          textAlign: widget.textAlign?? TextAlign.center,
          textDirection: widget.textDirection ??TextDirection.ltr,
          keyboardType: widget.isDigit??true?TextInputType.number:null,
          maxLength: widget.maxLength,
          inputFormatters: <TextInputFormatter>[
            if(widget.isDigit??true) FilteringTextInputFormatter.digitsOnly,
            if (widget.hasSeparator ?? false) ThousandSeparatorInputFormatter(),
          ],
          style: MainTheme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(

            counterText: widget.isShowCounter ? '${widget.maxLength!.toStringAsFixed(0)}/${widget.textController.text.length.toStringAsFixed(0)}' : '',
            suffix: (widget.hasRialBadge ?? false)
                ? Text(locale.rial, style: MainTheme.of(context).textTheme.titleLarge)
                : null,
            hintText: widget.hintText,
            hintStyle: MainTheme.of(context).textTheme.titleSmall.copyWith(color: MainTheme.of(context).surfaceContainerLowest),
            suffixIcon: widget.suffixIcon,
            suffixIconConstraints: const BoxConstraints(
                minHeight: 30,
                minWidth: 30
            ),
            // errorText: (widget.hasError ?? false) ? 'مبلغ وارد شده بیش از سقف تسهیلات می‌باشد' : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ??
                    ((widget.hasError ?? false)
                        ? MainTheme.of(context).primary
                        : MainTheme.of(context).surfaceContainer),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ??
                    ((widget.hasError ?? false)
                        ? MainTheme.of(context).primary
                        : MainTheme.of(context).surfaceContainer),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ??
                    ((widget.hasError ?? false)
                        ? MainTheme.of(context).primary
                        : MainTheme.of(context).surfaceContainer),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
              color: widget.borderColor ??
              ((widget.hasError ?? false)
              ? MainTheme.of(context).primary
                  : MainTheme.of(context).surfaceContainerLowest),
              ),
              borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
          ),
        ),
        if ((widget.hasPersianAmount ?? false) || (widget.hasError ?? false))
          const SizedBox(
            height: 8,
          ),
        if ((widget.hasPersianAmount ?? false) || (widget.hasError ?? false))
          Row(
            children: [
              if (widget.hasError ?? false)
                SvgIcon(
                  SvgIcons.loanListItemAlert,
                  size: 12.0,
                  color: MainTheme.of(context).primary,
                ),
              if (widget.hasError ?? false) const SizedBox(width: 8),
              Text(
                getSubTitleText(),
                style: MainTheme.of(context).textTheme.labelSmall.copyWith(
                    color: (widget.hasError ?? false)
                        ? MainTheme.of(context).primary
                        : MainTheme.of(context).surfaceContainer),
              ),
            ],
          )
      ],
    );
  }

  String getSubTitleText() {
    if ((widget.hasError ?? false)) {
      return widget.errorText ?? 'provide error text';
    } else if (widget.textController.text != '') {
      return DigitToWord.toWord(
              widget.textController.text.replaceAll('.', '').substring(
                  0, widget.textController.text.replaceAll('.', '').length - 1),
              StrType.numWord,
              isMoney: true)
          .replaceAll('  ', ' ');
    } else {
      return '';
    }
  }
}
