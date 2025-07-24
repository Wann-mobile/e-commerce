import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/orders/domain/entity/orders.dart';
import 'package:e_triad/src/orders/domain/repos/order_repos.dart';

class GetUserOrdersUseCase {
  final OrderRepository repository;
  GetUserOrdersUseCase(this.repository);

  ResultFuture<List<OrderEntity>> call(String userId) {
    return repository.getUserOrders(userId);
  }
}
