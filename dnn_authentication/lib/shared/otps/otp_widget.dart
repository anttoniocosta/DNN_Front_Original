import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

import 'otp_text_field.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({
    super.key,
    required this.onComplete,
    this.child,
    this.isOnLoading,
  });

  final Function(String?) onComplete;
  final Widget? child;
  final bool? isOnLoading;

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  TextEditingController a = TextEditingController(),
      b = TextEditingController(),
      c = TextEditingController(),
      d = TextEditingController(),
      e = TextEditingController(),
      f = TextEditingController();
  bool isValid() {
    return a.text != "" &&
        b.text != "" &&
        c.text != "" &&
        d.text != "" &&
        e.text != "" &&
        f.text != "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            OTPTextFieldCustom(
              onSaved: (val) => setState(() => a.text = val!),
              canGoBack: false,
              hasAutoFocus: true,
              textController: a,
              onKey: () => setState(() => a.clear()),
            ),
            OTPTextFieldCustom(
              onSaved: (val) => setState(() => b.text = val!),
              textController: b,
              onKey: () => setState(() => b.clear()),
            ),
            OTPTextFieldCustom(
              onSaved: (val) => setState(() => c.text = val!),
              textController: c,
              onKey: () => setState(() => c.clear()),
            ),
            OTPTextFieldCustom(
              onSaved: (val) => setState(() => d.text = val!),
              textController: d,
              onKey: () => setState(() => d.clear()),
            ),
            OTPTextFieldCustom(
              onSaved: (val) => setState(() => e.text = val!),
              textController: e,
              onKey: () => setState(() => e.clear()),
            ),
            OTPTextFieldCustom(
              onSaved: (val) => setState(() => f.text = val!),
              textController: f,
              onKey: () => setState(() => f.clear()),
            ),
          ],
        ),
        const SizedBox(height: 35),
        PrimaryButtonWidget(
          isLoading: widget.isOnLoading!,
          onTap: !isValid()
              ? null
              : () {
                  String otpNumbers =
                      a.text + b.text + c.text + d.text + e.text + f.text;
                  if (otpNumbers.length == 6) {
                    widget.onComplete(otpNumbers);
                  }
                },
          titleButtom: 'Confirmar',
        ),
      ],
    );
  }
}
