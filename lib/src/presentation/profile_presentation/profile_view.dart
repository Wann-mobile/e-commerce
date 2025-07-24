import 'package:e_triad/core/extension/context_ext.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

static const path = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Placeholder(
        child: Center(
          child: Text('Profile', style: context.theme.textTheme.displaySmall),
        ),
      ),
    );
  }
}