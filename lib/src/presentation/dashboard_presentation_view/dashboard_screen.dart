import 'package:collection/collection.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_triad/core/common/widgets/e_comm.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/cart_view.dart';
import 'package:e_triad/src/presentation/dashboard_presentation_view/presentation_utils/dashboard_drawer.dart';
import 'package:e_triad/src/presentation/dashboard_presentation_view/presentation_utils/dashboard_utils.dart';
import 'package:e_triad/src/presentation/dashboard_presentation_view/presentation_utils/dashboard_state.dart';
import 'package:e_triad/src/presentation/explore_presentation_view/explore_view.dart';
import 'package:e_triad/src/presentation/home_presentation_view/home_view.dart';
import 'package:e_triad/src/presentation/profile_presentation/profile_view.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final activeIndex = DashboardUtils.activeIndex(state);
    return Scaffold(
      key: DashboardUtils.scaffoldKey,
      appBar: AppBar(
        title: ECommLogo(
          context: context,
          style: context.theme.textTheme.headlineSmall!.copyWith(
            color: context.adaptiveColor(
              lightColor: Colours.darkSurface,
              darkColor: Colours.lightSurface,
            ),
          ),
          style2: context.theme.textTheme.headlineSmall!.copyWith(
            color: Colours.classicAdaptiveButtonOrIconColor(context),
          ),
        ),
        actions: [
          Icon(IconlyBroken.buy),
          SizedBox(width: 10),
          Icon(IconlyBold.scan),
          SizedBox(width: 12),
        ],
      ),
      drawer: DashboardDrawer(),
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: DashboardState.instance.indexNotifier,
        builder: (_, currentIndex, __) {
          return CurvedNavigationBar(
            index: currentIndex,
            backgroundColor: context.adaptiveColor(
              lightColor: Colours.lightTintBackground,
              darkColor: Colours.darkTintBackground,
            ),
            color: context.backgroundColor,

            buttonBackgroundColor: context.adaptiveColor(
              lightColor: Colours.darkButtonPrimary,
              darkColor: Colours.darkButtonSecondary,
            ),

            items:
                DashboardUtils.iconList.mapIndexed((index, icon) {
                  final isActive = activeIndex == index;
                  return Icon(
                    isActive ? icon.active : icon.idle,
                    size: 30,
                    color:
                        isActive
                            ? context.adaptiveColor(
                              lightColor: Colors.white,
                              darkColor: Colours.brandPrimary,
                            )
                            : Colors.grey,
                  );
                }).toList(),
            onTap: (index) async {
              final currentIndex = activeIndex;
              DashboardState.instance.changeIndex(index);
              switch (index) {
                case 0:
                  context.go(HomeView.path);
                case 1:
                  context.go(ExploreView.path);
                case 2:
                  await context.push(CartView.path);
                  DashboardState.instance.changeIndex(currentIndex);
                case 3:
                  context.go(WishlistView.path);
                case 4:
                  await context.push(ProfileView.path);
                  DashboardState.instance.changeIndex(currentIndex);
              }
            },
          );
        },
      ),
    );
  }
}
