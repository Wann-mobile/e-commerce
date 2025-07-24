import 'package:country_picker/country_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/input_field.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/vertical_label_field.dart';
import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/widgets/cart_header.dart';
import 'package:e_triad/src/checkout/checkout_presentation_view/adapter/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.cartProducts});
  final List<dynamic> cartProducts;

  static const path = '/checkout';
  static const deliveryFee = 2000;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final phoneCountryController = TextEditingController();
  final phoneController = TextEditingController();
  final countryNotifier = ValueNotifier<String?>(null);
  final phoneCountryNotifier = ValueNotifier<Country?>(null);
  final cityNotifier = ValueNotifier<String?>(null);
  final stateNotifier = ValueNotifier<String?>(null);

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (country) {
        if (country != phoneCountryNotifier.value) {
          phoneCountryNotifier.value = country;
          phoneCountryController.text = '+${country.phoneCode}';
        }
      },
    );
  }

  int getSubTotalPrices() {
    int subtotal = 0;
    for (dynamic cartItem in widget.cartProducts) {
      final productPrice =
          (cartItem.productPrice.toInt()) * (cartItem.quantity ?? 0);
      subtotal += productPrice as int;
    }
    return subtotal;
  }

  int getTotalPrices() {
    return getSubTotalPrices() + CheckoutScreen.deliveryFee;
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneCountryController.dispose();
    phoneController.dispose();
    countryNotifier.dispose();
    phoneCountryNotifier.dispose();
    cityNotifier.dispose();
    stateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state case StateCheckoutError(:final message)) {
            CoreUtils.showSnackBar(context, message: message);
          }
          if (state is StateCheckoutSuccessful) {
            CoreUtils.showSnackBar(context, message: 'Checkout successful!');
            final map = state.transactionResponse;
            final url = map['url'] as String;
            _launchUrl(url);
          }
        },
        builder: (context, state) {
          debugPrint('Checkout state: $state');
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CartHeader(
                      title: 'Cart Items',
                      content: '${widget.cartProducts.length}',
                    ),
                    SizedBox(height: 1),
                    CartHeader(
                      title: 'Subtotal',
                      content: 'NGN ${getSubTotalPrices()}',
                    ),
                    CartHeader(
                      title: 'Delivery Fee',
                      content: 'NGN ${CheckoutScreen.deliveryFee}',
                    ),
                    CartHeader(
                      title: 'Total',
                      content: 'NGN ${getTotalPrices()}',
                    ),
                    Gap(20),
                    CartHeader(title: 'Shipping Address', content: ''),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SelectState(
                              onCountryChanged: (country) {
                                if (country != countryNotifier.value) {
                                  countryNotifier.value = country;
                                }
                              },
                              onStateChanged: (state) {
                                if (state != stateNotifier.value) {
                                  stateNotifier.value = state;
                                }
                              },
                              onCityChanged: (city) {
                                if (city != cityNotifier.value) {
                                  cityNotifier.value = city;
                                }
                              },
                            ),
                            Gap(7),
                            VerticalLabelField(
                              label: 'Address',
                              controller: addressController,
                              hintText: 'Enter your address',
                              keyboardType: TextInputType.text,
                            ),
                            Gap(6),
                            ValueListenableBuilder(
                              valueListenable: phoneCountryNotifier,
                              builder: (_, phoneCountry, __) {
                                return VerticalLabelField(
                                  label: 'Phone',
                                  controller: phoneController,
                                  enabled: phoneCountry != null,
                                  hintText: 'Enter your phone number',
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (!isPhoneValid(
                                      value!,
                                      defaultCountryCode:
                                          phoneCountry?.countryCode,
                                    )) {
                                      return 'Invalid phone number';
                                    }
                                    return null;
                                  },
                                  inputFormatter: [
                                    PhoneInputFormatter(
                                      defaultCountryCode:
                                          phoneCountry?.countryCode,
                                    ),
                                  ],
                                  mainFieldFlex: 2,
                                  prefix: InputField(
                                    controller: phoneCountryController,
                                    readOnly: true,
                                    defaultValidation: false,
                                    contentPadding: const EdgeInsets.only(
                                      left: 10,
                                    ),

                                    suffixIcon: GestureDetector(
                                      onTap: pickCountry,
                                      child: const Icon(Icons.arrow_drop_down),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ).loading(isLoading: state is StateCheckoutLoading),
                    ),
                  ],
                ),
              ),

              Gap(16),
              Center(
                child: RoundedButton(
                  text: 'Proceed to Payment',
                  textStyle: context.theme.textTheme.bodyLarge!.copyWith(
                    color: context.textColor,
                    fontSize: 18,
                  ),

                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        countryNotifier.value != null &&
                        stateNotifier.value != null &&
                        cityNotifier.value != null &&
                        phoneCountryNotifier.value != null) {
                      final country = countryNotifier.value!;
                      final selectedState = stateNotifier.value!;
                      final city = cityNotifier.value!;
                      final phone = phoneController.text.trim();
                      final address = addressController.text.trim();
                      final phoneCountry = phoneCountryNotifier.value!;

                      final formattedPhone =
                          '${phoneCountry.phoneCode}${toNumericString(phone)}';

                      context.read<CheckoutCubit>().startCheckingOut(
                        cartProducts: widget.cartProducts,
                        city: selectedState,
                        country: country,
                        phone: formattedPhone,
                        address: '$city -- $address',
                      );
                    } else {
                      CoreUtils.showSnackBar(
                        context,
                        message: 'Please fill all required fields',
                      );
                    }
                  },

                  width: context.width * 0.85,
                  height: context.height * 0.075,
                ),
              ),
              Gap(10),
            ],
          );
        },
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
