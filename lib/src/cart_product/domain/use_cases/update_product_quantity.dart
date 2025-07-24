import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';
import 'package:equatable/equatable.dart';

class UpdateProductQuantity
    extends UseCaseWithParams<CartProduct, UpdateProductQuantityParam> {
  const UpdateProductQuantity(this._repos);

  final CartRepos _repos;
  @override
  ResultFuture<CartProduct> call(UpdateProductQuantityParam params) =>
      _repos.updateProductQuantity(
        params.cartProductId,
        params.userId,
        params.quantity,
      );
}

class UpdateProductQuantityParam extends Equatable {
  const UpdateProductQuantityParam({
    required this.cartProductId,
    required this.userId,
    required this.quantity,
  });

  final String cartProductId;
  final String userId;
  final int quantity;

  @override
  List<Object?> get props => [cartProductId, userId, quantity];
}
