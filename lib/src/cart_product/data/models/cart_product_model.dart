import 'dart:convert';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';


class CartProductModel extends CartProduct {
  const CartProductModel({
    required super.id,
    required super.product,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.productExists,
    required super.productOutOfStock,
    super.quantity,
    super.selectedSize,
    super.isReserved,
    super.reservationExpiryDate,
    super.checkoutPending ,
  });

  const CartProductModel.empty()
    : this(
        id: '',
        product: '',
        productImage: '',
        productName: '',
        productExists: true,
        productPrice: 0.0,
        productOutOfStock: false,
        isReserved: true,
        quantity: 1,
        selectedSize: '',
        reservationExpiryDate: '',
        checkoutPending: false
      );

  CartProductModel copyWith({
    String? id,
    int? quantity,
    String? selectedSize,
    String? product,
    String? productName,
    String? productImage,
    double? productPrice,
    bool? productExists,
    bool? productOutOfStock,
    String? reservationExpiryDate,
    bool? isReserved,
    bool? checkoutPending,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      product: product ?? this.product,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      productExists: productExists ?? this.productExists,
      productOutOfStock: productOutOfStock ?? this.productOutOfStock,
      isReserved: isReserved ?? this.isReserved,
      quantity: quantity ?? this.quantity,
      reservationExpiryDate:
          reservationExpiryDate ?? this.reservationExpiryDate,
      selectedSize: selectedSize ?? this.selectedSize,
      checkoutPending: checkoutPending ?? this.checkoutPending,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'product': product,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productExists': productExists,
      'productOutOfStock': productOutOfStock,
      'reservationExpiry': reservationExpiryDate,
      'reserved': isReserved,
      'checkoutPending': checkoutPending,
    };
  }

  factory CartProductModel.fromJson(String source) =>
      CartProductModel.fromMap(jsonDecode(source));

  factory CartProductModel.fromMap(DataMap map) {
    return CartProductModel(
      id: map['id'] as String? ?? map['_id'] as String? ?? '',
      product: map['product'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      productImage: map['productImage'] as String? ?? '',
      productPrice: (map['productPrice'] as num?)?.toDouble() ?? 0.0,
      productExists: map['productExists'] as bool? ?? true,
      productOutOfStock: map['productOutOfStock'] as bool? ?? false,
      isReserved: map['reserved'] as bool? ?? false,
      quantity: map['quantity'] as int? ?? 1,
      selectedSize: map['selectedSize'] as String? ?? '',
      reservationExpiryDate: map['reservationExpiry'] as String? ?? '',
      checkoutPending: map['checkoutPending'] as bool? ?? false,
    );
  }

  String toJson() => jsonEncode(toMap());
}
