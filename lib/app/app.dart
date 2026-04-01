import 'package:flutter/material.dart';

import '../features/shell/main_shell.dart';
import 'theme.dart';

class SpurenwegeApp extends StatelessWidget {
  const SpurenwegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spurenwege',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const MainShell(),
    );
  }
}
