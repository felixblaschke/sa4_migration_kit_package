// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/timeline_tween/timeline_tween.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

// #begin

// You can continue using an enum for property names...
enum Props { width, color }

// ...but you can also use a string or `MultiTweenProperty`, e.g:
const width = 'width';
final color = MovieTweenProperty<Color?>();

void main() {
  final timelineTween = TimelineTween<Props>()
    ..addScene(
            begin: const Duration(seconds: 0), end: const Duration(seconds: 1))
        .animate(Props.width,
            tween: Tween(begin: 0.0, end: 100.0), curve: Curves.easeIn)
    ..addScene(
            begin: const Duration(seconds: 1), end: const Duration(seconds: 3))
        .animate(Props.width,
            tween: Tween(begin: 100.0, end: 200.0), curve: Curves.easeOut)
    ..addScene(
            begin: const Duration(seconds: 0), end: const Duration(seconds: 3))
        .animate(Props.color,
            tween: ColorTween(begin: Colors.red, end: Colors.blue));

  final movieTween = MovieTween()
    ..scene(begin: const Duration(seconds: 0), end: const Duration(seconds: 1))
        .tween(Props.width, Tween(begin: 0.0, end: 100.0), curve: Curves.easeIn)
    ..scene(begin: const Duration(seconds: 1), end: const Duration(seconds: 3))
        .tween(Props.width, Tween(begin: 100.0, end: 200.0),
            curve: Curves.easeOut)
    ..scene(begin: const Duration(seconds: 0), end: const Duration(seconds: 3))
        .tween(Props.color, ColorTween(begin: Colors.red, end: Colors.blue));

  // Animation value now has type `Movie`
  TimelineValue<Props> timelineTweenValue = timelineTween.transform(0.5);
  Movie movieTweenValue = movieTween.transform(0.5);

  // Accessing value stays the same
  final value1 = timelineTweenValue.get<double>(Props.width);
  final value2 = movieTweenValue.get<double>(Props.width);

  // If using `MovieTweenProperty` you can use it's API for type-safe access, e.g.:
  final value3 = color.from(movieTweenValue);
}
// #end