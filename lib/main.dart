import 'package:e_triad/core/common/theme/app_theme.dart';
import 'package:e_triad/core/common/theme/theme_service.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/services/router_import.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/categories/presentation/categories_cubit.dart';
import 'package:e_triad/src/checkout/checkout_presentation_view/adapter/checkout_cubit.dart';
import 'package:e_triad/src/orders/orders_presentation_view.dart/adapter/orders_cubit.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:e_triad/src/users/presentation/app_adapter/user_cubit.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
   runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<UserCubit>()),
        BlocProvider(create: (_) => sl<ProductCubit>()),
        BlocProvider(create: (_) => sl<WishlistCubit>()), 
        BlocProvider.value(value: sl<CartCubit>()),     
        BlocProvider.value(value: sl<CategoryCubit>()),
        BlocProvider(create: (_) => sl<NewArrivalsCubit>()),
        BlocProvider(create: (_) => sl<CheckoutCubit>()),
        BlocProvider(create: (_) => sl<OrdersCubit>()),
      ],
      child: const MyApp(),
    ),
   );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E_triad',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: ThemeService.instance.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
