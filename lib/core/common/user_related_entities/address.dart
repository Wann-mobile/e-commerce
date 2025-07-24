import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    this.street,
    this.apartment,
    this.city,
    this.country,
    this.postalCode,
  });
  const Address.empty()
    : street = 'Test Street',
      apartment = 'Test Apartment',
      city = 'Test City',
      country = 'Test Country',
      postalCode = 'Test Postal Code';

  final String? street;
  final String? apartment;
  final String? city;
  final String? country;
  final String? postalCode;

  bool get isEmpty =>
      street == null &&
      apartment == null &&
      city == null &&
      country == null &&
      postalCode == null;
  bool get isNotEmpty => !isEmpty;

  @override
  List<dynamic> get props => [street, apartment, city, country, postalCode];
}
