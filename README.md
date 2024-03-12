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
// Define constants for route paths
const String pathToScreenWithNoArguments = '/home';
const String pathToScreenWithSingleArgument = '/imageView';
const String pathToScreenWithMultipleArguments = '/searchResult';

// Function to generate routes based on RouteSettings
Route<dynamic> generateRoute(RouteSettings settings) {
  // Extract arguments from settings
  final arguments = settings.arguments;

  // Define a variable to hold the constructed widget tree for the route
  Widget path;

  // Switch statement to handle different routes based on the name
  switch (settings.name) {
    case pathToScreenWithNoArguments:
    case '/':
      // Handle route with no arguments
      path = HomeScreenLocator(
        controller: HomeScreenController(),
        child: const HomeScreen(),
      );
      break;
    case pathToScreenWithSingleArgument:
      // Handle route with a single argument
      path = ImageViewScreenLocator(
        controller: ImageViewScreenController(
          assetGroups: arguments! as String, // Cast arguments to String
        ),
        child: const ImageViewScreen(),
      );
      break;
    case pathToScreenWithMultipleArguments:
      // Handle route with multiple arguments
      path = SearchResultScreenLocator(
        controller: SearchResultScreenController(
          fromAssetGroups: (arguments! as List)[0] as Map<String, Filter>,
          assetGroupName: (arguments as List)[1] as String,
          // ... other arguments parsing logic (if applicable)
        ),
        child: const SearchResultScreen(),
      );
      break;
    default:
      throw const RouteException('Route not found');
  }

  // Wrap the constructed route tree with a TransitionBuilder
  // for a beautiful animation
  return TransitionBuilder(
    route: path,
  );
}
```

This code demonstrates a simple routing implementation with arguments using only core Flutter functionalities.
Using this routing approach is straightforward as well:

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
@TODO:
## Dividing screen logic from its design

## .env

## Native Splash Preservation

## Logger

## App Initialization

## Internet Connection Check

## Path Manager

## Download Status

## Download Result

## Download Strategy

## Download Strategies

## Assets Manager

## Asset Group

## DownloadGroup

## Image Assets Group

## Precache Image into Context (No Blinks)