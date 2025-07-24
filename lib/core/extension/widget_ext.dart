import 'package:e_triad/core/common/widgets/dynamic_loader.dart';
import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget loading({required bool isLoading}) {
    return DynamicLoader(originalWidget: this, isLoading: isLoading);
  }
}
