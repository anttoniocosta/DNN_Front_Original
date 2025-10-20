import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextFieldCustom extends StatefulWidget {
  const OTPTextFieldCustom({
    super.key,
    required this.onSaved,
    this.canGoBack = true,
    this.hasAutoFocus = false,
    required this.textController,
    this.onKey,
  });
  final Function(String?) onSaved;
  final bool? canGoBack;
  final bool? hasAutoFocus;
  final TextEditingController textController;
  final VoidCallback? onKey;

  @override
  State<OTPTextFieldCustom> createState() => _OTPTextFieldCustomState();
}

class _OTPTextFieldCustomState extends State<OTPTextFieldCustom> {
  bool hasValue = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: RawKeyboardListener(
            onKey: (val) {
              if (val.data.logicalKey.keyLabel == "Backspace") {
                widget.onKey!();
                setState(() {
                  hasValue = false;
                });
                if (widget.canGoBack!) {
                  FocusScope.of(context)
                      .focusInDirection(TraversalDirection.left);
                }
              }
            },
            focusNode: FocusNode(canRequestFocus: false),
            child: TextFormField(
              controller: widget.textController,
              autofocus: widget.hasAutoFocus!,
              cursorColor: AppColors.blueColor,
              onChanged: (value) {
                widget.onSaved(value);
                if (value.length == 1) {
                  setState(() {
                    hasValue = true;
                  });
                  FocusScope.of(context).nextFocus();
                } else {
                  setState(() {
                    hasValue = false;
                  });
                  if (widget.canGoBack!) {
                    FocusScope.of(context)
                        .focusInDirection(TraversalDirection.left);
                  }
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: hasValue
                      ? Colors.blueAccent
                      : Colors.grey.withOpacity(0.4),
                  width: 2,
                )),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 1,
                )),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.4),
                  width: 1,
                )),
              ),
              textAlignVertical: TextAlignVertical.top,
              style: Fonts.titleMedium(context),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ),
      ),
    );
  }
}
