import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/vertical_list_views/product_vert_view_all.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewArrivalProductViewAll extends StatelessWidget {
  const NewArrivalProductViewAll({super.key});
  static const path = '/new-arrival-view-all';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<NewArrivalsCubit>()),
        BlocProvider(create: (context) => sl<CartCubit>()),
      ],
      child: ProductVertViewAll(
        title: 'New Arrivals',
       isFetchPopularProducts: false,
      ),
    );
  }
}
