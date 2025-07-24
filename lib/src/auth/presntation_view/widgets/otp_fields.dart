import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({super.key, required this.controller});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      appContext: context,
      autoFocus: true,
      length: 4,
      backgroundColor: context.backgroundColor,
      dialogConfig: DialogConfig(
        dialogContent: 'Do yur want to paste',
        dialogTitle: 'Paste Otp',
      ),
      textStyle: context.theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      cursorColor: Colours.classicAdaptiveSecondaryTextColor(context),
      pinTheme: PinTheme(
        inactiveColor: const Color(0xFFEEEEEE),
        selectedColor: Colours.classicAdaptiveButtonOrIconColor(context),
        activeColor: Colours.classicAdaptiveButtonOrIconColor(context),

        shape: PinCodeFieldShape.box,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 59,
        fieldWidth: 70,
        activeFillColor: const Color(0xFFFAFBFA),
        inactiveFillColor: const Color(0xFFFAFBFA),
      ),
      onChanged: (_) {},
      onCompleted: (pin) => controller.text = pin,
      beforeTextPaste: (value) {
        return value != null &&
            value.isNotEmpty &&
            value.length == 4 &&
            int.tryParse(value) != null;
      },
    );
  }
}
