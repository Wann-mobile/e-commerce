import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/orders/domain/entity/orders.dart';

abstract class OrderRepository {
  ResultFuture<List<OrderEntity>> getUserOrders(String userId);
}