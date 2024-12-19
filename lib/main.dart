import 'package:f_player/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_player/core/di/di.dart';

void main() {
  setup();
  runApp(const ProviderScope(child: Main()));
}

class Main extends ConsumerWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
