import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';
import 'package:equatable/equatable.dart';

class RemoveProductQuantity extends UseCaseWithParams<void, RemoveProductQuantityParam> {
  const RemoveProductQuantity(this._repos);

  final CartRepos _repos;
  @override
  ResultFuture<void> call(RemoveProductQuantityParam params) =>
      _repos.removeProductFromCart(params.cartProductId,params.userId);
}

class RemoveProductQuantityParam extends Equatable{
  const RemoveProductQuantityParam({required this.cartProductId, required this.userId});

  final String cartProductId;
  final String userId;
  
  @override
  List<Object?> get props => [cartProductId, userId];
}
