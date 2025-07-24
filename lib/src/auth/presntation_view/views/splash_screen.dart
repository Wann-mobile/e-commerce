import 'package:app_links/app_links.dart';
import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/common/widgets/e_comm.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/media.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:e_triad/src/auth/presntation_view/views/login_screen.dart';
import 'package:e_triad/src/presentation/home_presentation_view/home_view.dart';
import 'package:e_triad/src/users/presentation/app_adapter/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _checkDeepLinkThenSession();
    _listenToLiveDeepLinks();
  }

  void _listenToLiveDeepLinks() {
    _appLinks.uriLinkStream.listen(
      (uri) {
        if (!mounted) return;

        final ref = uri.queryParameters['reference'];
        if (uri.host ==
                'https://91e3b01c656b.ngrok-free.app/api/v1/payment-success?reference=$ref&status=success' &&
            ref != null) {
          context.go(
            HomeView.path,
            extra: {'paymentSuccess': true, 'reference': ref},
          );
        }
      },
      onError: (err) {
        debugPrint('Live deep link error: $err');
      },
    );
  }

  Future<void> _checkDeepLinkThenSession() async {
    try {
      final uri = await _appLinks.getInitialLink();
      final ref = uri?.queryParameters['reference'];
      if (uri != null &&
          uri.host ==
              'https://91e3b01c656b.ngrok-free.app/api/v1/payment-success?reference=$ref&status=success') {
        if (!mounted) return;

        context.go(
          HomeView.path,
          extra: {'paymentSuccess': true, 'reference': ref},
        );
        return;
      }
    } catch (e) {
      debugPrint('Deep link check failed: $e');
    }

    await _checkSessionStatus();
  }

  Future<void> redirectToLogin() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final router = GoRouter.of(context);
      router.go(LoginScreen.path);
    });
  }

  Future<void> _checkSessionStatus() async {
    final cacheHelper = sl<CacheHelper>();
    final token = cacheHelper.getSessionToken();
    final userId = cacheHelper.getUserId();

    if (token != null && userId != null) {
      context.read<AuthBloc>().add(EventVerifyTokenRequested());
    } else {
      await redirectToLogin();
    }
  }

  Future<void> redirectToIndex() async {
    final router = GoRouter.of(context);
    await sl<CacheHelper>().resetSession();
    router.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.scaffoldBackgroundColor;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is StateUserError) {
          await sl<CacheHelper>().resetSession();
          await redirectToLogin();
        } else if (state is StateFetchedUser) {
          context.go('/', extra: 'home');
        }
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateTokenVerified) {
            if (state.isValid) {
              context.read<UserCubit>().getUserById(Cache.instance.userId!);
            } else {
              await redirectToLogin();
            }
          } else if (state is AuthStateError) {
            await redirectToLogin();
          }
        },
        child: Scaffold(
          backgroundColor: colorScheme,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(Media.logoTransparent, width: 150, height: 150),
              
                ECommLogo(context: context),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
