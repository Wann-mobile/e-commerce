import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/orders/orders_presentation_view.dart/adapter/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});
  static const path = '/orders';

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchUserOrders(
      UserProvider.instance.currentUser?.id ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      backgroundColor: context.backgroundColor,
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (OrdersLoaded):
              final loadedState = state as OrdersLoaded;
              if (loadedState.orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }
              return ListView.builder(
                itemCount: loadedState.orders.length,
                itemBuilder: (_, index) {
                  final order = loadedState.orders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    color: Colours.classicAdaptiveBgCardColor(context),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: Image.network(
                        order.orderItems.first.productImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                      ),
                      title: Text(
                        'NGN ${order.totalPrice} - ${order.status.toUpperCase()}',
                        style: context.theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Ordered on: ${order.dateOrdered.split('T').first}',
                            style: context.theme.textTheme.bodyMedium!.copyWith(
                              color: context.textColor.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            'Items: ${order.orderItems.length}',
                            style: context.theme.textTheme.bodyMedium!.copyWith(
                              color: context.textColor.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            'Product: ${order.orderItems.first.productName}',
                            style: context.theme.textTheme.bodyMedium!.copyWith(
                              color: context.textColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).loading(isLoading: state is OrdersLoading);
            case const (OrdersError):
              final errorState = state as OrdersError;
              return Center(child: Text('Error: ${errorState.message}'));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
