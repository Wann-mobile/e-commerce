import 'dart:convert';

import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';

class WishlistProductModel extends Wishlist {
  const WishlistProductModel({
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.productExists,
    required super.productOutOfStock,
  });

  const WishlistProductModel.empty()
    : this(
        productId: '',
        productName: '',
        productImage: '',
        productPrice: 0.0,
        productExists: true,
        productOutOfStock: false,
      );

  factory WishlistProductModel.fromJson(String source) =>
      WishlistProductModel.fromMap(jsonDecode(source) as DataMap);

  WishlistProductModel.fromMap(DataMap map)
    : this(
        productId: map['productId'] as String,
        productName: map['productName'] as String,
        productImage: map['productImage'] as String,
        productPrice: (map['productPrice'] as num).toDouble(),
        productExists: map['productExists'] as bool,
        productOutOfStock: map['productOutOfStock'] as bool,
      );

  WishlistProductModel copyWith({
    String? productId,
    String? productName,
    String? productImage,
    double? productPrice,
    bool? productExists,
    bool? productOutOfStock,
  }) {
    return WishlistProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      productExists: productExists ?? this.productExists,
      productOutOfStock: productOutOfStock ?? this.productOutOfStock,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productExists': productExists,
      'productOutOfStock': productOutOfStock,
    };
  }

  String toJson() => jsonEncode(toMap());
}
