import 'package:app_links/app_links.dart';
import 'package:e_triad/core/common/widgets/dynamic_loader.dart';
import 'package:e_triad/src/presentation/home_presentation_view/home_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class LinkRouterPage extends StatefulWidget {
  const LinkRouterPage({super.key});

  @override
  State<LinkRouterPage> createState() => _LinkRouterPageState();
}

class _LinkRouterPageState extends State<LinkRouterPage> {
  final _appLink = AppLinks();
  @override
  void initState() {
    super.initState();
    _handleDeepLink();
  }

  void _handleDeepLink() async {
    final uri = await _appLink.getInitialLink();
    if (uri != null &&
        _isPaymentSuccess(uri, uri.queryParameters['reference'] ?? '')) {
      _navigateWithFlag(uri);
      return;
    }
  }

  bool _isPaymentSuccess(Uri uri, String ref) {
    return uri.host == 'etriad://payment-result?reference=$ref&status=success';
  }

  void _navigateWithFlag(Uri uri) {
    final ref = uri.queryParameters['reference'];
    context.go(
      HomeView.path,
      extra: {'paymentSuccess': true, 'reference': ref},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DynamicLoader(originalWidget: Container(), isLoading: true),
    );
  }
}
