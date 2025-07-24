

import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/orders/data/remote_data_src/orders_remote_data_src.dart';
import 'package:e_triad/src/orders/domain/entity/orders.dart';
import 'package:e_triad/src/orders/domain/repos/order_repos.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remote;
  OrderRepositoryImpl(this.remote);

  @override
  ResultFuture<List<OrderEntity>> getUserOrders(String userId) async {
   try {
      final results = await remote.getUserOrders(userId);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}