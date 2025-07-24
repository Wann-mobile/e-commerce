import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';
import 'package:equatable/equatable.dart';

class AddToCart extends UseCaseWithParams<void, AddToCartParam> {
  const AddToCart(this._repos);

  final CartRepos _repos;
  @override
  ResultFuture<void> call(AddToCartParam params) => _repos.addToCart(
    params.productId,
    params.userId,
    params.quantity,
    params.selectedSize,
  );
}

class AddToCartParam extends Equatable {
  const AddToCartParam({
    required this.productId,
    required this.userId,
    this.quantity = 1,
    required this.selectedSize,
  });

  final String productId;
  final String userId;
  final int? quantity;
  final String selectedSize;

  @override
  List<Object?> get props => [productId, userId, quantity, selectedSize];
}
