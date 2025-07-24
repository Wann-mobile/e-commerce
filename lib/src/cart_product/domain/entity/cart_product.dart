import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  const CartProduct({

    required this.id,
    this.quantity = 1,
    this.selectedSize = 'S',
    required this.product,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productExists,
    required this.productOutOfStock,
    this.reservationExpiryDate = '',
    this.isReserved = true,
    this.checkoutPending =false, 
  });
  const CartProduct.empty()
    :
    id ='',
      quantity = 0,
      selectedSize = 'Small',
      product= '',
      productName = '',
      productImage = '',
      productPrice = 0.0,
      productExists = true,
      productOutOfStock = false,
      reservationExpiryDate = '',
      isReserved = true,
      checkoutPending = false;
  final String id;
  final int? quantity;
  final String? selectedSize;
  final String product;
  final String productName;
  final String productImage;
  final double productPrice;
  final bool productExists;
  final bool productOutOfStock;
  final String? reservationExpiryDate;
  final bool isReserved;
  final bool checkoutPending;
  
  @override
  List<Object?> get props => [
    quantity,
    selectedSize,
    product,
    productName,
    productImage,
    productPrice,
    productExists,
    productOutOfStock,
    reservationExpiryDate,
    isReserved,
    checkoutPending, 
  ];
}
