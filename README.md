<!-- This file uses generated code. Visit https://pub.dev/packages/readme_helper for usage information. -->

# simple_animation v4 migration kit

This packages contains classes and documentation to help you migrate your code base from simple_animations v4 to v5.

Once migrated you can remove this package from your project.

<!-- #toc -->
## Table of Contents

[**Flutter classes**](#flutter-classes)

[**Migrations**](#migrations)
  - [PlayAnimation, CustomAnimation, LoopAnimation, MirrorAnimation](#playanimation,-customanimation,-loopanimation,-mirroranimation)
  - [MultiTween](#multitween)
  - [TimelineTween](#timelinetween)
<!-- // end of #toc -->

## Flutter classes

This package contains the following classes:

- `PlayAnimation`
- `CustomAnimation`
- `LoopAnimation`
- `MirrorAnimation`
- `MultiTween`
- `TimelineTween`

## Migrations

### PlayAnimation, CustomAnimation, LoopAnimation, MirrorAnimation

Those classes got a rename to better fit the Flutter naming convention.

- `PlayAnimation` -> `PlayAnimationBuilder`
- `CustomAnimation` -> `CustomAnimationBuilder`
- `LoopAnimation` -> `LoopAnimationBuilder`
- `MirrorAnimation` -> `MirrorAnimationBuilder`

Also the order of arguments of the `builder()` method has been aligned to Flutter builder methods.

- `build(context, child, animatedValue)` -> `build(context, animation, child)`

The `duration` property was optional (defaulted to 1 second) and is now mandatory.

Also lifecycle listener got renamed:

- `onStart` -> `onStarted`
- `onComplete` -> `onCompleted`

<!-- #code lib/examples/builder.dart -->
```dart
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
```
<!-- // end of #code -->

### MultiTween

Migrate your **MultiTween** to **MovieTween** as it offers a similar API.

<!-- #code lib/examples/multi_tween.dart -->
```dart
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
```
<!-- // end of #code -->

### TimelineTween

Migrate your **TimelineTween** to **MovieTween** as it offers a similar API.

<!-- #code lib/examples/timeline_tween.dart -->
```dart

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
```
<!-- // end of #code -->
