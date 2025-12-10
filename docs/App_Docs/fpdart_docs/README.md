# fpdart - Functional Programming in Dart and Flutter

[![fpdart version](https://img.shields.io/pub/v/fpdart)](https://pub.dev/packages/fpdart)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/SandroMaglione/fpdart/blob/main/LICENSE.md)

**fpdart** is a functional programming package for Dart and Flutter that provides all the main functional programming types and patterns, fully documented, tested, and with examples.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Core Types](#core-types)
  - [Option](#option)
  - [Either](#either)
  - [IO](#io)
  - [Task](#task)
- [Utility Types](#utility-types)
- [Reader](#reader)
- [State](#state)
- [Do Notation](#do-notation)
- [Immutable Collections](#immutable-collections)
- [Examples](#examples)
- [Resources](#resources)
- [Comparison with dartz](#comparison-with-dartz)

## Introduction

**fpdart** is inspired by fp-ts, cats, and dartz. It aims to provide all the main types found in functional languages to Dart, including:

- **Option**: Handle missing values without null
- **Either**: Handle errors and error messages
- **Task**: Composable async computations
- And many more functional programming types

### Key Features

- ✅ Fully documented
- ✅ Completely null-safe
- ✅ Comprehensive examples
- ✅ Real-world use cases
- ✅ No previous FP experience needed
- ✅ Based on Dart 3
- ✅ Richer API than alternatives

## Installation

Add fpdart to your `pubspec.yaml`:

```yaml
dependencies:
  fpdart: ^1.1.1
```

Then run:

```bash
flutter pub get
```

## Core Types

### Option

Used when a return value can be missing. Similar to nullable types but more explicit and composable.

**Example:**

```dart
import 'package:fpdart/fpdart.dart';

// Create an instance of Some
final option = Option.of(10);

// Create an instance of None
final none = Option<int>.none();

// Map int to String
final map = option.map((a) => '$a');

// Extract the value from Option
final value = option.getOrElse(() => -1);

// Pattern matching
final match = option.match(
  () => print('None'),
  (a) => print('Some($a)'),
);

// Dart 3 pattern matching
final dartMatch = switch (option) {
  None() => 'None',
  Some(value: final a) => 'Some($a)',
};

// Convert to Either
final either = option.toEither(() => 'missing');

// Chain computations
final flatMap = option.flatMap((a) => Option.of(a + 10));

// Return None if the function throws an error
final tryCatch = Option.tryCatch(() => int.parse('invalid'));
```

### Either

Used to handle errors (instead of Exceptions). Represents a value that can be either a failure (Left) or a success (Right).

**Example:**

```dart
import 'package:fpdart/fpdart.dart';

// Create an instance of Right (success)
final right = Either<String, int>.of(10);

// Create an instance of Left (error)
final left = Either<String, int>.left('none');

// Map the right value to a String
final mapRight = right.map((a) => '$a');

// Map the left value to an int
final mapLeft = right.mapLeft((a) => a.length);

// Return Left if the function throws an error
final tryCatch = Either.tryCatch(
  () => int.parse('invalid'),
  (e, s) => 'Error: $e',
);

// Extract the value from Either
final value = right.getOrElse((l) => -1);

// Chain computations
final flatMap = right.flatMap((a) => Either.of(a + 10));

// Pattern matching
final match = right.match(
  (l) => print('Left($l)'),
  (r) => print('Right($r)'),
);

// Dart 3 pattern matching
final dartMatch = switch (right) {
  Left(value: final l) => 'Left($l)',
  Right(value: final r) => 'Right($r)',
};

// Convert to Option
final option = right.toOption();
```

### IO

Wrapper around a sync function. Allows composing synchronous functions that never fail.

**Example:**

```dart
import 'package:fpdart/fpdart.dart';

// Create instance of IO from a value
final IO<int> io = IO.of(10);

// Create instance of IO from a sync function
final ioRun = IO(() => 10);

// Map int to String
final IO<String> map = io.map((a) => '$a');

// Extract the value inside IO by running its function
final int value = io.run();

// Chain another IO based on the value of the current IO
final flatMap = io.flatMap((a) => IO.of(a + 10));
```

### Task

Wrapper around an async function (Future). Allows composing asynchronous functions that never fail.

**Example:**

```dart
import 'package:fpdart/fpdart.dart';

// Create instance of Task from a value
final Task<int> task = Task.of(10);

// Create instance of Task from an async function
final taskRun1 = Task(() async => 10);
final taskRun2 = Task(() => Future.value(10));

// Map int to String
final Task<String> map = task.map((a) => '$a');

// Extract the value inside Task by running its async function
final int value = await task.run();

// Chain another Task based on the value of the current Task
final flatMap = task.flatMap((a) => Task.of(a + 10));
```

## Utility Types

These types compose together the 4 above (Option, Either, IO, Task) to join their functionalities:

- **IOOption**: Sync function (IO) that may miss the return value (Option)
- **IOEither**: Sync function (IO) that may fail (Either)
- **TaskOption**: Async function (Task) that may miss the return value (Option)
- **TaskEither**: Async function (Task) that may fail (Either)

## Reader

Read values from a context without explicitly passing the dependency between multiple nested function calls. Useful for dependency injection.

## State

Used to store, update, and extract state in a functional way. Provides immutable state management.

## Do Notation

Version v0.6.0 introduced the Do notation in fpdart. Using the Do notation makes chaining functions easier and more readable.

**Example without Do notation:**

```dart
String goShopping() => goToShoppingCenter()
    .alt(goToLocalMarket)
    .flatMap(
      (market) => market.buyBanana().flatMap(
            (banana) => market.buyApple().flatMap(
                  (apple) => market.buyPear().flatMap(
                        (pear) => Option.of('Shopping: $banana, $apple, $pear'),
                      ),
                ),
          ),
    )
    .getOrElse(
      () => 'I did not find 🍌 or 🍎 or 🍐, so I did not buy anything 🤷‍♂️',
    );
```

**Example with Do notation:**

```dart
String goShoppingDo() => Option.Do(
      ($) {
        final market = $(goToShoppingCenter().alt(goToLocalMarket));
        final amount = $(market.buyAmount());

        final banana = $(market.buyBanana());
        final apple = $(market.buyApple());
        final pear = $(market.buyPear());

        return 'Shopping: $banana, $apple, $pear';
      },
    ).getOrElse(
      () => 'I did not find 🍌 or 🍎 or 🍐, so I did not buy anything 🤷‍♂️',
    );
```

⚠️ **Warning:** Avoid common pitfalls when using Do notation:
- Do not throw inside the Do() constructor
- Do not await without executing the $ function
- Do not use a nested Do() constructor inside another one
- Do not call the $ function inside another callback in the Do() constructor

## Immutable Collections

fpdart does not provide immutable collections directly. Instead, we strongly recommend using the **fast_immutable_collections** package for immutable collections (List, Set, Map).

fpdart provides extension methods on Iterable, List, and Map to extend the native Dart API with immutable methods:

```dart
// Dart: `1`
[1, 2, 3, 4].first;

// fpdart: `Some(1)`
[1, 2, 3, 4].head;

// Dart: Throws a [StateError] ⚠️
[].first;

// fpdart: `None()`
[].head;

final map = {'a': 1, 'b': 2};

// Dart: mutable ⚠️
map.updateAll((key, value) => value + 10);

// fpdart: immutable equivalent 🤝
final newMap = map.mapValue((value) => value + 10);
```

## fpdart + Retrofit Integration

For complete integration guide with Retrofit, see:
- [**fpdart + Retrofit Integration Guide**](./retrofit-integration.md)

This guide covers:
- How to integrate fpdart with Retrofit
- Error handling with TaskEither
- Working with Riverpod providers
- Complete examples and best practices

## Examples

### API Request with Validation

```dart
import 'package:fpdart/fpdart.dart';

// Validate API response
Either<String, User> validateUser(Map<String, dynamic> json) {
  try {
    final name = json['name'] as String?;
    if (name == null || name.isEmpty) {
      return Either.left('Name is required');
    }
    return Either.right(User(name: name));
  } catch (e) {
    return Either.left('Invalid user data: $e');
  }
}

// Parse JSON safely
Option<User> parseUser(Map<String, dynamic>? json) {
  if (json == null) return Option.none();
  return Option.tryCatch(() => User.fromJson(json))
    .toEither()
    .toOption();
}
```

### Error Handling with TaskEither

```dart
import 'package:fpdart/fpdart.dart';

// Create a TaskEither for async operations that may fail
TaskEither<String, List<User>> fetchUsers() {
  return TaskEither.tryCatch(
    () async {
      final response = await dio.get('/users');
      return (response.data as List)
        .map((json) => User.fromJson(json))
        .toList();
    },
    (error, stackTrace) => 'Failed to fetch users: $error',
  );
}

// Compose multiple operations
TaskEither<String, UserProfile> loadUserProfile(int userId) {
  return fetchUsers()
    .flatMap((users) {
      final userOption = users.firstWhereOrNull((u) => u.id == userId);
      return userOption.fold(
        () => TaskEither.left('User not found'),
        (user) => TaskEither.of(user.profile),
      );
    });
}
```

## Resources

### Official Documentation

- [Getting Started Guide](https://sandromaglione.com/getting-started-with-fpdart)
- [Full History of fpdart](https://sandromaglione.com/full-history-of-fpdart-and-functional-programming-in-dart)
- [Official GitHub Repository](https://github.com/SandroMaglione/fpdart)

### Blog Posts and Tutorials

- [Option type and Null Safety in dart](https://sandromaglione.com/option-type-null-safety-dart)
- [Either - Error Handling in Functional Programming](https://sandromaglione.com/either-error-handling-functional-programming)
- [Future & Task: asynchronous Functional Programming](https://sandromaglione.com/future-task-asynchronous-functional-programming)
- [How to use TaskEither in fpdart](https://sandromaglione.com/taskeither-fpdart)
- [How to map an Either to a Future in fpdart](https://sandromaglione.com/map-either-future-fpdart)
- [Pure Functional app in Flutter – Pokemon app](https://sandromaglione.com/pure-functional-app-flutter-pokemon-fpdart-functional-programming)

### Getting Started with Functional Programming

- [Functional Programming Option type – Introduction](https://sandromaglione.com/functional-programming-option-type-introduction)
- [Chain functions using Option type](https://sandromaglione.com/chain-functions-option-type-functional-programming)
- [Practical Functional Programming - Find repeated characters](https://sandromaglione.com/practical-functional-programming-find-repeated-characters)
- [Pure Functions - Practical Functional Programming](https://sandromaglione.com/pure-functions-practical-functional-programming)

### Example Projects

- **Pokeapi**: Flutter app that lets you search and view your favorite Pokemon
- **Open Meteo API**: Weather app using fpdart
- **Read/Write local file**: Example of file operations

## Comparison with dartz

**fpdart** is a rewrite based on fp-ts and cats. The main differences from dartz are:

| Feature | fpdart | dartz |
|---------|--------|-------|
| Documentation | Fully documented | Limited documentation |
| Dart Version | Based on Dart 3 | Based on Dart 1 |
| Null Safety | Completely null-safe | Not fully null-safe |
| API | Richer API | Simpler API |
| Higher-kinded types | Implemented using defunctionalization | Different approach |
| Missing types | Implements Reader, TaskEither, and others | Missing some types |
| Immutable Collections | Not provided (use fast_immutable_collections) | Provides ISet, IMap, IHashMap, AVLTree |

## Version History

- **v1.1.1** - 7 November 2024
- **v1.1.0** - 13 August 2023
- **v1.0.0** - 26 July 2023
- **v0.6.0** - 6 May 2023 (Introduced Do notation)

## Support

- Subscribe to the [Newsletter](https://sandromaglione.com/newsletter) for tutorials and updates
- Follow on [Twitter](https://twitter.com/SandroMaglione) or [BlueSky](https://bsky.app/profile/sandromaglione.com)
- Check the [GitHub Repository](https://github.com/SandroMaglione/fpdart) for issues and contributions

## License

MIT License. See the LICENSE.md file for details.
