# Assets Downloader Example

This project showcases various approaches I've created throughout my career, using clean Flutter without external dependencies.

The main feature is to download, cache, and use app assets from the backend. This functionality is reflected in the project's name, Assets Downloader Example.

## Use Case

I implement Use Case as a mixin that later can be used to create module-specific use cases that are inside a module/service subfolder or a common use case that is inside use_case subfolders by categories.
Module-specific use cases are primarily used to initialize the module's interface (contract) with its concrete implementation. Common use cases have a more general purpose.

The generics P stands for Parameter, and R stands for Result.

``` dart
mixin IUseCase<P, R> {
  Future<R> execute({required P params});
}
```

## Controller

I don't use any complex packages for logic controllers or state management.
A simple controller with init and dispose methods is sufficient for most situations.
You can then decide how to manage state within it, whether using the Reactive/Observable pattern or another approach.
It is important not to be dependent on single approach for all problems.
So you can use both Stream and ChangeNotifier as you find appropriate.

What I find useful for all controllers are initOnce and disposeOnce methods. These methods act as gatekeepers, ensuring code runs only once during initialization and cleanup, respectively.

```dart
 void init() {
    /// code that runs every time
    //---
    if (super.initOnce) {
      return;
    }
    //---
    /// code that runs once
  }
```

I also use a controller hierarchy:
```dart
class ScreenController extends LogicController

class ServiceController extends LogicController

ImageAssetGroupViewScreenController extends ScreenController
```

This hierarchy facilitates code reuse by allowing common logic to be shared across different controller types.

## Routing

Routing is simple and does not need any additional packages.
```dart
const String pathToScreenWithNoArguments = '/home';
const String pathToScreenWithSingleArgument = '/imageView';
const String pathToScreenWithMultipleArguments = '/searchResult';

Route<dynamic> generateRoute(RouteSettings settings) {
  final arguments = settings.arguments;

  Widget path;
  switch (settings.name) {
    case pathToScreenWithNoArguments:
    case '/':
          path = HomeScreenLocator(
            controller: HomeScreenController(),
            child: const HomeScreen(),
          );
    case pathToScreenWithSingleArgument:
      path = ImageViewScreenLocator(
        controller: ImageViewScreenController(
          // single argument
          assetGroups: arguments! as String,
        ),
        child: const ImageViewScreen(),
      );
    case pathToScreenWithMultipleArguments:
      path = SearchResultScreenLocator(
        controller: SearchResultScreenController(
          // first argument
          fromAssetGroups: (arguments! as List)[0] as Map<String, Filter>,
          // second argument
          assetGroupName: (arguments as List)[1] as String,
          // ... all other arguments needed
        ),
        child: const SearchResultScreen(),
      );
    default:
      throw const RouteException('Route not found');
  }

  return TransitionBuilder(
    route: path,
  );
}
```

That's all you need for routing with arguments using just a Flutter.
The usage is stupidly simple too:

```dart
Navigator.of(context).pushNamed(
  pathToScreenWithSingleArgument,
  arguments: 'assets/images...',
);
```

Or, if you don't like using context, you can create a global key:
```dart
late final GlobalKey<NavigatorState> navigatorKey;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    navigatorKey = GlobalKey<NavigatorState>();

    return CupertinoApp(
      //...
      navigatorKey: navigatorKey,
      //...
```

Then you can use it like this:
```dart
  navigatorKey.currentState!.pushNamed(
    pathToScreenWithSingleArgument,
    arguments: 'assets/images...',
  );
```