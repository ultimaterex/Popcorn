import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



mixin PostFrameMixin<T extends ConsumerStatefulWidget> on State<T> {
  void postFrame(void Function() callback) =>
      WidgetsBinding.instance.addPostFrameCallback(
            (_) {
          // Execute callback if page is mounted
          if (mounted) callback();
        },
      );
}