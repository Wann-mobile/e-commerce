import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/common/widgets/bottom_sheet_card.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/services/router_import.dart';
import 'package:e_triad/src/presentation/dashboard_presentation_view/presentation_utils/dashboard_state.dart';
import 'package:e_triad/src/presentation/dashboard_presentation_view/presentation_utils/dashboard_utils.dart';
import 'package:e_triad/src/orders/orders_presentation_view.dart/orders_view.dart';
import 'package:e_triad/src/presentation/profile_presentation/profile_view.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final signingOutNotifier = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    signingOutNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = sl<UserProvider>().currentUser!;
    return Drawer(
      
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: context.adaptiveColor(
                      lightColor: Colours.lightCardBackground,
                      darkColor: Colours.darkInputBorder,
                    ),
                    child: Text(
                      user.name.initials,

                      style: context.theme.textTheme.headlineMedium,
                    ),
                  ),
                  const Gap(15),

                  Text(
                    user.name.toUpperCase(),
                    style: context.theme.textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
              separatorBuilder:
                  (_, __) => Divider(color: Colors.grey, thickness: 0.3),
              itemCount: DashboardUtils.drawerItems.length,
              itemBuilder: (_, index) {
                final drawerItem = DashboardUtils.drawerItems[index];
                return ListTile(
                  leading: Icon(
                    drawerItem.icon,
                    color: Colours.classicAdaptiveSecondaryTextColor(context),
                  ),
                  title: Text(
                    drawerItem.title,
                    style: context.theme.textTheme.bodyLarge,
                  ),
                  onTap: () {
                    if (index != 1) Scaffold.of(context).closeDrawer();
                    switch (index) {
                      case 0:
                        context.push(ProfileView.path);

                      case 1:
                        DashboardState.instance.changeIndex(3);
                        context.go(WishlistView.path);
                      case 2:
                        context.push(MyOrdersView.path);
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(bottom: 20, top: 20),
            child: ValueListenableBuilder(
              valueListenable: signingOutNotifier,
              builder: (_, value, __) {
                return RoundedButton(
                  text: 'Sign out',
                  height: 50,
                  
                  onPressed: () async {
                    final result = await showModalBottomSheet<bool>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      isDismissible: false,
                      builder: (_) {
                        return BottomSheetCard(
                          title: 'Are you sure you want to Sign out?',
                          positiveButtonText: 'Yes',
                          negativeButtonText: 'Go Back',
                          positiveButtonColor:
                              Colours.classicAdaptiveButtonOrIconColor(context),
                        );
                      },
                    );
                    if (result ?? false) {
                      signingOutNotifier.value = true;
                      await sl<CacheHelper>().resetSession();
                      router.go('/');
                    }
                  },
                ).loading(isLoading: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
