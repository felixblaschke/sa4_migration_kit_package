// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/sa4_migration_kit.dart';
import 'package:simple_animations/simple_animations.dart';

void main(List<String> args) {
  // #begin
  final from = PlayAnimation<double>(
    tween: Tween(begin: 0.0, end: 100.0),
    // duration is optional
    onStart: () => debugPrint('onStart'),
    onComplete: () => debugPrint('onComplete'),
    builder: (context, child, value) {
      return Container(width: value, height: value, color: Colors.red);
    },
  );

  final to = PlayAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 100.0),
    duration: const Duration(seconds: 1), // duration is mandatory
    onStarted: () => debugPrint('onStart'), // got renamed
    onCompleted: () => debugPrint('onComplete'), // got renamed
    // order changed -> child is last argument
    builder: (context, value, child) {
      return Container(width: value, height: value, color: Colors.red);
    },
  );
  // #end
}
