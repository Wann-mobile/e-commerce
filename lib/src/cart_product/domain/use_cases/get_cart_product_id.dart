import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';
import 'package:equatable/equatable.dart';

class GetCartProductById
    extends UseCaseWithParams<CartProduct, GetCartProductIdParams> {
  const GetCartProductById(this._repos);

  final CartRepos _repos;
  @override
  ResultFuture<CartProduct> call(GetCartProductIdParams params) =>
      _repos.getCartProductById(params.cartProductId, params.userId);
}

class GetCartProductIdParams extends Equatable {
  const GetCartProductIdParams({
    required this.cartProductId,
    required this.userId,
  });

  final String cartProductId;
  final String userId;

  @override
  List<Object?> get props => [cartProductId, userId];
}
