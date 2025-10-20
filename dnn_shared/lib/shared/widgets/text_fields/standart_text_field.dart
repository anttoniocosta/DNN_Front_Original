import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StandartTextField extends StatefulWidget {
  const StandartTextField({
    super.key,
    this.labelText,
    this.prefixText,
    this.prefixIcon,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.isSecret = false,
    this.maxLength,
    this.maxLines,
    this.isEnabled = true,
    this.keyboardType,
    this.onTap,
    this.textInputAction,
    this.hintText,
    this.onChanged,
  });

  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool isSecret;
  final bool? isEnabled;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Function(String)? onChanged;
  @override
  State<StandartTextField> createState() => _StandartTextFieldState();
}

class _StandartTextFieldState extends State<StandartTextField> {
  bool isObscure = false;

  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.labelText != null
        ? _textFieldWithLabel(context)
        : _textField(context);
  }

  Widget _textFieldWithLabel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText ?? '',
            style: Fonts.bodyLarge(context).copyWith(
              fontFamily: Fonts.poppins,
            )),
        10.heightGap,
        _textField(context),
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onTap: widget.onTap,
        onEditingComplete: () {},
        cursorColor: AppColors.blueColor,
        controller: widget.controller,
        enabled: widget.isEnabled,
        obscureText: isObscure,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        style: Fonts.bodyLarge(context).copyWith(
            color: !widget.isEnabled!
                ? Fonts.bodyLarge(context).color!.withOpacity(0.4)
                : null),
        decoration: InputDecoration(
          contentPadding: AppConstants.contentPadding,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: widget.hintText,
          prefixIcon: widget.prefixText != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 15.0,
                    bottom: 15.0,
                    right: 5.0,
                  ),
                  child: Text(
                    '${widget.prefixText}:',
                    style: Fonts.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            Fonts.bodyLarge(context).color!.withOpacity(0.6)),
                  ),
                )
              : widget.prefixIcon,
          hintStyle: Fonts.bodyLarge(context).copyWith(
              color: Fonts.bodyLarge(context).color!.withOpacity(0.4)),
          labelStyle: Fonts.titleMedium(context),
          errorStyle:
              Fonts.bodyMedium(context).copyWith(color: AppColors.redColor),
          suffixIcon: widget.isSecret
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Fonts.bodyMedium(context).color!,
                      size: 18,
                    ),
                  ),
                )
              : null,
          fillColor:
              Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.darkGreyColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.darkGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.blueColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.blueColor),
          ),
        ),
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class DropdownStandard extends StatelessWidget {
  const DropdownStandard({
    super.key,
    this.isEnabled = true,
    required this.controller,
    required this.listOptions,
    required this.hintText,
    this.labelText,
    this.prefixText,
    this.onChanged,
    this.validator,
  });

  final bool? isEnabled;
  final TextEditingController controller;
  final List<String> listOptions;
  final String hintText;
  final String? labelText;
  final String? prefixText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return labelText != null ? _dropDownWithLabel(context) : _dropDown(context);
  }

  Widget _dropDownWithLabel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? '',
            style: Fonts.bodyLarge(context).copyWith(
              fontFamily: Fonts.poppins,
            )),
        10.heightGap,
        _dropDown(context),
      ],
    );
  }

  Widget _dropDown(BuildContext context) {
    return GetBuilder<ProvidersController>(builder: (_) {
      return DropdownSearch<String>(
        validator: validator,
        items: listOptions,
        selectedItem: controller.text == '' ? null : controller.text,
        popupProps:
            const PopupProps.menu(constraints: BoxConstraints(maxHeight: 280)),
        enabled: isEnabled!,
        dropdownButtonProps: DropdownButtonProps(
          icon: RotatedBox(
            quarterTurns: 3,
            child: Icon(Icons.arrow_back_ios_new,
                size: Responsive.doubleSizes(
                    mobile: 28, tablet: 18, desktop: 18)),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: Fonts.bodyLarge(context).copyWith(
            color: !isEnabled!
                ? Fonts.bodyMedium(context).color!.withOpacity(0.4)
                : null,
          ),
          dropdownSearchDecoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            hintStyle: Fonts.bodyLarge(context).copyWith(
                color: Fonts.bodyMedium(context).color!.withOpacity(0.4)),
            isCollapsed: false,
            isDense: false,
            contentPadding: AppConstants.contentPadding,
            prefixIcon: prefixText != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 15.0,
                      bottom: 15.0,
                      right: 5.0,
                    ),
                    child: Text(
                      '$prefixText:',
                      style: Fonts.bodyLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              Fonts.bodyLarge(context).color!.withOpacity(0.6)),
                    ),
                  )
                : null,
            fillColor: Get.isDarkMode && isEnabled!
                ? AppColors.midBlackColor
                : AppColors.whiteColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.darkGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.blueColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.blueColor),
            ),
          ),
        ),
        onChanged: onChanged,
      );
    });
  }
}
