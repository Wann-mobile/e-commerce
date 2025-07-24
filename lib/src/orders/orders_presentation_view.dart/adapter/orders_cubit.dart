import 'package:e_triad/src/orders/domain/entity/orders.dart';
import 'package:e_triad/src/orders/domain/use_case/get_user_orders.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetUserOrdersUseCase getUserOrdersUseCase;

  OrdersCubit(this.getUserOrdersUseCase) : super(OrdersInitial());

  Future<void> fetchUserOrders(String userId) async {
    emit(OrdersLoading());

    final result = await getUserOrdersUseCase(userId);

    result.fold(
      (failure) => emit(OrdersError(failure.errorMessage)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
