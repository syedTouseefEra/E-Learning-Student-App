import 'package:e_learning/components/check_internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_learning/components/no_internet_view.dart';

class ConnectivityListener extends ConsumerWidget {
  final Widget child;
  static bool _dialogShown = false;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(connectionStatusProvider, (prev, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!next && !_dialogShown) {
          _dialogShown = true;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const NoInternetView(),
              fullscreenDialog: true,
            ),
          );
        } else if (next && _dialogShown) {
          _dialogShown = false;
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      });
    });

    return child;
  }
}
