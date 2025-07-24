import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class VerticalLabelField extends StatelessWidget {
  const VerticalLabelField({
    super.key,
    required this.controller,
    required this.label,
    this.obsecureText = false,
    this.defaultValidation = true,
    this.enabled = true,
    this.readOnly = false,
    this.mainFieldFlex = 1,
    this.prefixFlex = 1,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatter,
    this.prefix,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
  });

  final String label;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefix;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final int mainFieldFlex;
  final int prefixFlex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.theme.textTheme.titleLarge),
        const Gap(10),
        Row(
          children: [
            if (prefix != null) ...[
              Expanded(flex: prefixFlex, child: prefix!),
              const Gap(8),
            ],
            Expanded(
              flex: mainFieldFlex,
              child: InputField(
                controller: controller,
                suffixIcon: suffixIcon,
                hintText: hintText,
                validator: validator,
                keyboardType: keyboardType,
                obsecureText: obsecureText,
                defaultValidation: defaultValidation,
                inputFormatter: inputFormatter,
                enabled: enabled,
                readOnly: readOnly,
                contentPadding: contentPadding,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
