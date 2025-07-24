import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.obsecureText = false,
    this.defaultValidation = false,
    this.readOnly = false,
    this.expandable = false,
    this.enabled = true,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatter,
    this.prefix,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
  });

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
  //final bool? isDense;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool expandable;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colours.classicAdaptiveButtonOrIconColor(context),
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obsecureText,
      enabled: enabled,

      readOnly: readOnly,
      maxLines: expandable ? 5 : 1,
      minLines: expandable ? 1 : null,
      style: context.theme.textTheme.bodyLarge,
      onTap: onTap,
      decoration: InputDecoration(
        errorMaxLines: 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.theme.primaryColor),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: context.theme.textTheme.labelLarge,
        suffixIconColor: context.theme.primaryColor,

        prefix: prefix,
        prefixIcon: prefixIcon,
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        filled: true,
        fillColor: context.theme.inputDecorationTheme.fillColor,
      ),
      inputFormatters: inputFormatter,
      validator:
          defaultValidation
              ? (value) {
                if (value == null || value.isEmpty) return 'Required field';
                return validator?.call(value);
              }
              : validator,
    );
  }
}
