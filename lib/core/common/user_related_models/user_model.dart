import 'dart:convert';

import 'package:e_triad/core/common/user_related_entities/address.dart';
import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/core/common/user_related_models/address_model.dart';
import 'package:e_triad/src/wishlist/data/models/wishlist_product_model.dart';
import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:flutter/material.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.isAdmin = false,
    super.wishlist = const [],
    super.address,
    super.phone,
    super.cartProductIds,
  });

  const UserModel.empty()
    : this(
        id: 'Test Id',
        name: 'Test Name',
        email: 'Test Email',
        isAdmin: true,
        wishlist: const [],
        address: null,
        phone: null,
        cartProductIds : const []
      );
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAdmin,
    List<Wishlist>? wishlist,
    Address? address,
    String? phone,
    List<String>? cartProductIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      wishlist: wishlist ?? this.wishlist,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      cartProductIds: cartProductIds ?? this.cartProductIds,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'wishlist':
          wishlist
              .map((product) => (product as WishlistProductModel).toMap())
              .toList(),
      if (address != null) 'address': (address as AddressModel).toMap(),
      if (phone != null) 'phone': phone,
      'cart' : cartProductIds.map((cartProductId) => (cartProductId)).toList(),
    };
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromMap(DataMap map) {
    final address = AddressModel.fromMap({
      if (map case {'street': String street}) 'street': street,
      if (map case {'apartment': String apartment}) 'apartment': apartment,
      if (map case {'city': String city}) 'city': city,
      if (map case {'country': String country}) 'country': country,
      if (map case {'postalCode': String postalCode}) 'postalCode': postalCode,
    });
    return UserModel(
      id: map['id'] as String? ?? map['_id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      isAdmin: map['isAdmin'] as bool,
      wishlist: 
          List<DataMap>.from(
            map['wishlist'] as List,
          ).map(WishlistProductModel.fromMap).toList(),
      phone: map['phone'] as String?,
      address: address.isEmpty ? null : address,
      cartProductIds: _parseCartIds(map['cart'])
    //   List<DataMap>.from(
    //     map['cart'] as List<dynamic>,
    //   ).map(CartProductModel.fromMap).toList(),
     );
  }

  String toJson() => jsonEncode(toMap());

  static List<String> _parseCartIds(dynamic cartData) {
    if (cartData == null) {
      return <String>[];
    }
    
    if (cartData is String) {
      try {
        final parsed = json.decode(cartData);
        if (parsed is List) {
          return List<String>.from(parsed);
        }
      } catch (e) {
        debugPrint('Error parsing cart string: $e');
      }
      return <String>[];
    }
    
    if (cartData is List) {
      return List<String>.from(cartData);
    }
    
    return <String>[];
  }

}
