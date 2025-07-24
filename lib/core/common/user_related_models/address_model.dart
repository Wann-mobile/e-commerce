import 'dart:convert';

import 'package:e_triad/core/common/user_related_entities/address.dart';
import 'package:e_triad/core/utils/typedefs.dart';

class AddressModel extends Address {
  const AddressModel({
    super.street,
    super.apartment,
    super.city,
    super.country,
    super.postalCode,
  });

  const AddressModel.empty()
    : this(
        street: 'Test Street',
        apartment: 'Test Apartment',
        city: 'Test City',
        country: 'Test Country',
        postalCode: 'Test Postal Code',
      );

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(jsonDecode(source) as DataMap);

  AddressModel.fromMap(DataMap map)
    : this(
        street: map['street'] as String?,
        apartment: map['apartment'] as String?,
        city: map['city'] as String?,
        country: map['country'] as String?,
        postalCode: map['postalCode'] as String?,
      );

  AddressModel copyWith({
    String? street,
    String? apartment,
    String? city,
    String? country,
    String? postalCode,
  }) {
    return AddressModel(
      street: this.street,
      apartment: this.apartment,
      city: this.city,
      country: this.country,
      postalCode: this.postalCode,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'street': street,
      'apartment': apartment,
      'city': city,
      'postalCode': postalCode,
      'country': country,
    };
  }

  String toJson() => jsonEncode(toMap());
}
