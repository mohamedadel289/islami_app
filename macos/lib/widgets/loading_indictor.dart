import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class LoadingIndictor extends StatelessWidget {
 Color color;
 LoadingIndictor([this.color=AppTheme.primary]);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color),);
  }
}