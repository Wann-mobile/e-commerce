import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class DynamicLoader extends StatelessWidget {
  const DynamicLoader({
    super.key,
    required this.originalWidget,
    required this.isLoading,
    this.loadingWidget,
  });

  final Widget originalWidget;
  final bool isLoading;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ??
          Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colours.classicAdaptiveButtonOrIconColor(context),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colours.classicAdaptiveButtonOrIconColor(context),
              ),
            ),
          );
    }
    return originalWidget;
  }
}
