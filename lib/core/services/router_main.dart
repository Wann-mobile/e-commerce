part of 'router_import.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
 
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        if (state.extra == 'home') return HomeView.path;

        return null;
      },
      builder: (_, _) {
        final cacheHelper = sl<CacheHelper>();

        if (cacheHelper.isFirstTime()) {
          return const OnBoardingScreen();
        }
        return const SplashScreen();
      },
    ),
    GoRoute(path: LoginScreen.path, builder: (_, __) => const LoginScreen()),
    GoRoute(
      path: RegistrationScreen.path,
      builder: (_, __) => const RegistrationScreen(),
    ),
    GoRoute(
      path: ForgotPasswordScreen.path,
      builder: (_, __) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: ResetPasswordScreen.path,
      builder: (_, state) => ResetPasswordScreen(email: state.extra as String),
    ),
    GoRoute(
      path: VerifyOtpScreen.path,
      builder: (_, state) => VerifyOtpScreen(email: state.extra as String),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DashboardScreen(state: state, child: child);
      },
      routes: [
        GoRoute(path: HomeView.path, builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return HomeView(
            paymentSuccess: extra?['paymentSuccess'] ?? false,
            reference: extra?['reference'] as String?,
          );
        }),
        GoRoute(
          path: ExploreView.path,
          builder:
              (_, __) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<ProductCubit>()),
                  BlocProvider.value(value: sl<CategoryCubit>()),
                  BlocProvider(create: (_) => IndexCubit()),
                  //BlocProvider(create: (_) => sl<WishlistCubit>()..getUserWishlist(userId)),
                ],
                child: ExploreView(),
              ),
        ),
        GoRoute(
          path: WishlistView.path,
          builder: (_, __) => const WishlistView(),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: CartView.path,
      builder: (_, __) => const CartView(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: ProfileView.path,
      builder: (_, __) => const ProfileView(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: MyOrdersView.path,
      builder: (_, __) => const MyOrdersView(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: CategoryViewAll.path,
      builder:
          (_, __) => const CategoryViewAll(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: NewArrivalProductViewAll.path,
      builder: (_, __) => const NewArrivalProductViewAll(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: PopularProductViewAll.path,
      builder: (_, __) => const PopularProductViewAll(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: ProductDetailView.path,
      builder:
          (_, state) => ProductDetailView(productId: state.extra as String),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: CategoryGridDetailView.path,
      builder:
          (_, state) =>
              CategoryGridDetailView(category: state.extra as dynamic),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: CheckoutScreen.path,
      builder:
          (_, state) =>
              CheckoutScreen(cartProducts: state.extra as List<dynamic>,),
    ),
  ],
);
