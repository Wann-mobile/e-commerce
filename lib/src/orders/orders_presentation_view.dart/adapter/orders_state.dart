part  of 'orders_cubit.dart';


sealed class OrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;
  OrdersLoaded(this.orders);
  @override
  List<Object?> get props => [orders];
}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
  @override
  List<Object?> get props => [message];
}
