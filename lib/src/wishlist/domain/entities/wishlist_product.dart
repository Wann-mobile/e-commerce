import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  const Wishlist({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productExists,
    required this.productOutOfStock,
  });

  const Wishlist.empty()
    : productId = 'Test ProductId',
      productName = 'Test Product Name',
      productImage = 'https://example.com/test-product-image.jpg',
      productPrice = 1.0,
      productExists = true,
      productOutOfStock = true;

  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final bool productExists;
  final bool productOutOfStock;

  @override
  List<Object?> get props => [
    productId,
    productName,
    productImage,
    productPrice,
    productExists,
    productOutOfStock,
  ];
}
