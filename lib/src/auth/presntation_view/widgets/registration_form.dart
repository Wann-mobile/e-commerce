import 'package:country_picker/country_picker.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/input_field.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/vertical_label_field.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  final obscurePaswordNotifier = ValueNotifier(true);
  final obscureConfirmPaswordNotifier = ValueNotifier(true);
  final countryNotifier = ValueNotifier<Country?>(null);

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (country) {
        if (country != countryNotifier.value) countryNotifier.value = country;
        // countryController.text = '+${country.phoneCode}';
      },
    );
  }

  @override
  void initState() {
    super.initState();
    countryNotifier.addListener(() {
      if (countryNotifier.value == null) {
        countryController.clear();
        phoneController.clear();
      } else {
        countryController.text = '+${countryNotifier.value!.phoneCode}';
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePaswordNotifier.dispose();
    confirmPasswordController.dispose();
    obscureConfirmPaswordNotifier.dispose();
    fullNameController.dispose();
    countryController.dispose();
    phoneController.dispose();
    countryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state case AuthStateError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is AuthStateRegistered) {
          CoreUtils.showSnackBar(context, message: 'Registration Sucessful');
          context.go('/');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              VerticalLabelField(
                label: 'Full Name',
                controller: fullNameController,
                hintText: 'Enter your full name',
                keyboardType: TextInputType.name,
              ),
              const Gap(20),
              VerticalLabelField(
                label: 'Email',
                controller: emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: countryNotifier,
                builder: (_, country, __) {
                  return VerticalLabelField(
                    label: 'Phone',
                    controller: phoneController,
                    enabled: country != null,
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (!isPhoneValid(
                        value!,
                        defaultCountryCode: country?.countryCode,
                      )) {
                        return 'Invalid phone number';
                      }
                      return null;
                    },
                    inputFormatter: [
                      PhoneInputFormatter(
                        defaultCountryCode: country?.countryCode,
                      ),
                    ],
                    mainFieldFlex: 2,
                    prefix: InputField(
                      controller: countryController,
                      readOnly: true,
                      defaultValidation: false,
                      contentPadding: const EdgeInsets.only(left: 10),
                      suffixIcon: GestureDetector(
                        onTap: pickCountry,
                        child: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obscurePaswordNotifier,
                builder: (_, obsecurePassword, _) {
                  return VerticalLabelField(
                    controller: passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    obsecureText: obsecurePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obscurePaswordNotifier.value =
                            !obscurePaswordNotifier.value;
                      },
                      child: Icon(
                        obsecurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obscureConfirmPaswordNotifier,
                builder: (_, obscureConfirmPassword, _) {
                  return VerticalLabelField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Re-Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    obsecureText: obscureConfirmPassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obscureConfirmPaswordNotifier.value =
                            !obscureConfirmPaswordNotifier.value;
                      },
                      child: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text.trim()) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  );
                },
              ),
              const Gap(20),

              RoundedButton(
                text: 'Sign Up',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final name = fullNameController.text.trim();
                    final phone = phoneController.text.trim();
                    final country = countryNotifier.value!;
                    final formattedPhoneNumber =
                        '${country.phoneCode}${toNumericString(phone)}';
                    context.read<AuthBloc>().add(
                      EventRegisterRequested(
                        email: email,
                        password: password,
                        name: name,
                        phone: formattedPhoneNumber,
                      ),
                    );
                  }
                },
              ).loading(isLoading: false),
            ],
          ),
        );
      },
    );
  }
}
