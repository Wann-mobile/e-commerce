part of 'injection_container_import.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheInit();
  await _authInit();
  await _userInit();
  await _productInit();
  await _categoryInit();
  await _reviewsInit();
  await _wishlistInit();
  await _cartInit();
  await _checkoutInit();
  await _ordersInit();
}

Future<void> _ordersInit() async{
  sl
    ..registerFactory(() => OrdersCubit(sl()))
    ..registerLazySingleton(() => GetUserOrdersUseCase(sl()))
    ..registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()))
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(sl()),
    );
}

Future <void> _checkoutInit() async {
  sl
    ..registerLazySingleton(
      () => CheckoutCubit(checkout: sl()),
    )
    ..registerLazySingleton<CheckoutRepos>(() => CheckoutRepoImpl(sl()))
    ..registerLazySingleton<CheckoutDataSrc>(
      () => CheckoutDataSrcImpl(sl()),
    )
    
    ..registerLazySingleton(() => Checkout(sl()));
}
Future<void> _cartInit() async {
  sl
    ..registerLazySingleton(
      () => CartCubit(
        addToCart: sl(),
        removeProductFromCart: sl(),
        updateProductQuantity: sl(),
        getUserCart: sl(),
        getUserCartCount: sl(),
        getCartProductById: sl(),
      ),
    )
    
  
    ..registerLazySingleton(() => CartProvider.instance)
    ..registerLazySingleton(() => AddToCart(sl()))
    ..registerLazySingleton(() => RemoveProductQuantity(sl()))
    ..registerLazySingleton(() => UpdateProductQuantity(sl()))
    ..registerLazySingleton(() => GetUserCart(sl()))
    ..registerLazySingleton(() => GetUserCartCount(sl()))
    ..registerLazySingleton(() => GetCartProductById(sl()))
    ..registerLazySingleton<CartRepos>(() => CartProductRepoImpl(sl()))
    ..registerLazySingleton<CartProductRemoteDataSrc>(
      () => CartProductRemoteDataSrcImpl(sl()),
    );
}

Future<void> _wishlistInit() async {
  sl
    ..registerLazySingleton(
      () => WishlistCubit(
        addToWishlist: sl(),
        getUserWishlist: sl(),
        removeFromWishlist: sl(),
      
      ),
    )
    ..registerLazySingleton(() => AddToWishlist(sl()))
    ..registerLazySingleton(() => GetUserWishlist(sl()))
    ..registerLazySingleton(() => RemoveFromWishlist(sl()))
    ..registerLazySingleton<WishlistRepo>(() => WishlistRepoImpl(sl()))
    ..registerLazySingleton<WishlistRemoteDataSrc>(
      () => WishlistRemoteDataSrcImpl(sl()),
    )
   ;
}

Future<void> _reviewsInit() async {
  sl
    ..registerFactory(
      () => ReviewsCubit(createReview: sl(), getProductReviews: sl()),
    )
    ..registerLazySingleton(() => CreateReview(sl()))
    ..registerLazySingleton(() => GetProductReviews(sl()))
    ..registerLazySingleton<ReviewRepos>(() => ReviewRepoImpl(sl()))
    ..registerLazySingleton<ReviewRemoteDataSrc>(
      () => ReviewRemoteDataScrImpl(sl()),
    );
}

Future<void> _categoryInit() async {
  sl
    ..registerLazySingleton(
      () => CategoryCubit(getCategories: sl(), getCategory: sl()),
    )
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetCategory(sl()))
    ..registerLazySingleton<CategoryRepos>(() => CategoryRepoImpl(sl()))
    ..registerLazySingleton<CategoryRemoteDataSrc>(
      () => CategoryRemoteDataSrcImpl(sl()),
    );
}

Future<void> _productInit() async {
  sl
    ..registerFactory(
      () => ProductCubit(
        getAllProducts: sl(),
        getPopularProducts: sl(),
        getProduct: sl(),
        getProductsByCategory: sl(),
        searchAllProducts: sl(),
        searchProductsByGenderAgeCategory: sl(),
        searchProductsByCategory: sl(),
        productProvider: sl(),
      ),
    )
    ..registerFactory(() => NewArrivalsCubit(getNewArrivalProducts: sl()))
    ..registerLazySingleton(() => GetAllProducts(sl()))
    ..registerLazySingleton(() => GetNewArrivalProducts(sl()))
    ..registerLazySingleton(() => GetPopularProducts(sl()))
    ..registerLazySingleton(() => GetProduct(sl()))
    ..registerLazySingleton(() => GetProductsByCategory(sl()))
    ..registerLazySingleton(() => SearchAllProducts(sl()))
    ..registerLazySingleton(() => SearchProductsByGenderAgeCategory(sl()))
    ..registerLazySingleton(() => SearchProductsByCategory(sl()))
    ..registerLazySingleton<ProductRepos>(() => ProductRepoImpl(sl()))
    ..registerLazySingleton<ProductRemoteDataSrc>(
      () => ProductRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton(() => ProductProvider.instance);
}

Future<void> _userInit() async {
  sl
    ..registerFactory(
      () => UserCubit(getUser: sl(), updateUser: sl(), userProvider: sl()),
    )
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<UserRepos>(() => UserRepoImpl(sl()))
    ..registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl()),
    );
}

Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();

  // Core
  sl
    ..registerLazySingleton(() => CacheHelper(sl()))
    ..registerLazySingleton(() => prefs);
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        forgotPassword: sl(),
        login: sl(),
        register: sl(),
        resetPassword: sl(),
        verifyOtp: sl(),
        verifyToken: sl(),
        userProvider: sl(),
      ),
    )
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => Register(sl()))
    ..registerLazySingleton(() => ResetPassword(sl()))
    ..registerLazySingleton(() => VerifyOtp(sl()))
    ..registerLazySingleton(() => VerifyToken(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepoImpol(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(sl()),
    )
    ..registerLazySingleton(() => UserProvider.instance)
    ..registerLazySingleton(http.Client.new);
}
