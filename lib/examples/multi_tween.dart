// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/multi_tween/multi_tween.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

void main(List<String> args) {
  // #begin
  final multiTween = MultiTween<String>()
    ..add('width', Tween(begin: 0.0, end: 100.0), const Duration(seconds: 1),
        Curves.easeIn)
    ..add('width', Tween(begin: 100.0, end: 200.0), const Duration(seconds: 2),
        Curves.easeOut)
    ..add('color', ColorTween(begin: Colors.red, end: Colors.blue),
        const Duration(seconds: 3));

  final movieTween = MovieTween()
    ..tween('width', Tween(begin: 0.0, end: 100.0),
            duration: const Duration(seconds: 1), curve: Curves.easeIn)
        .thenTween('width', Tween(begin: 100.0, end: 200.0),
            duration: const Duration(seconds: 2), curve: Curves.easeOut)
    ..tween('color', ColorTween(begin: Colors.red, end: Colors.blue),
        duration: const Duration(seconds: 3));

  // Animation value now has type `Movie`
  MultiTweenValues<String> multiTweenValue = multiTween.transform(0.5);
  Movie movieTweenValue = movieTween.transform(0.5);

  // Accessing value stays the same
  final value1 = multiTweenValue.get<double>('width');
  final value2 = movieTweenValue.get<double>('width');
  // #end
}
