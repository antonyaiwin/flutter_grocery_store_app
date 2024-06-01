import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliSeconds;

  Timer? _timer;

  Debouncer({required this.milliSeconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSeconds), action);
  }

  void cancel() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
