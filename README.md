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
## Dividing screen logic from its design

UI implementations are susceptible to frequent changes. This includes not only the visual design but also aspects like asset usage, adaptability, and accessibility, which continuously evolve. With advancements like code-push and server-driven UI, app design can become even more dynamic than previously anticipated.

Therefore,  separating the logic of each screen from its UI becomes crucial. This project demonstrates this concept using Screen Controllers and their Locators.

For example, if I know that we'll need to remove native splash no matter what design will be in the future, then I'm adding it into the LoadingScreenController:
```dart
  void init() {
    if (super.initOnce) {
      return;
    }
    const RemoveNativeSplash().execute();
  }
```

And using it in the LoadingScreen:
```dart
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      LoadingScreenLocator.of(context).init();
    }
```

Or if I know that asset groups will be displayed on the DownloadGroupScreen, I am adding them into DownloadGroupScreenController regardless of the current UI implementation. 
For now it's a SliverList builder, but in the future it can be a grid view or something more complex:
```dart
SliverList.builder(
                itemCount: screenController.assetGroups.length,
                itemBuilder: (_, index) {
                  final groupKey =
                      screenController.assetGroups.keys.elementAt(index);
```

Or if I use route navigation arguments extensively, it makes sense to put this logic into the controller:
```dart
  void selectAssetGroup(BuildContext context, String assetGroupName) {
    Navigator.of(context).pushNamed(
      pathGroup,
      arguments: [
        downloadGroup,
        assetGroupName,
      ],
    );
```

## .env

Environment variables are dynamic values used within an app to customize its behavior based on the environment it runs in (e.g., production, staging, development). They can also be used to differentiate releases based on factors like:

* **Country:** Different server URLs for Asia and Europe.
* **User groups:** Different API keys for different user groups.
* **Functionality:** Remove or add functionality based on legal requirements in certain countries.

Environment variables are typically stored inside a `.env` file, which is a plain text file containing key-value pairs. Each line in the file represents one variable and its corresponding value.

There are various plugins to work with `.env` files, both on the client (app) and server side.
On the app side, it's crucial to:

1. **Check for Missing Values:** Verify that all necessary environment variables have been added to the `.env` file.
2. **Validate Values:** Ensure the retrieved values are valid (not null or empty).
3. **Throw Exceptions:** If any variables are missing or invalid, throw an exception to prevent the app from running with potentially incorrect configurations.


```dart
  void _validateVar(String name, String? value) {
    if (value == null || value.isEmpty) {
      throw Exception('Missing or invalid .env: $name');
    }
  }
```

For most projects I've worked on, this Environment contract has proven sufficient:
```dart
abstract class Environment {
  void operator []=(String name, String? value);
  String operator [](String name);
  Map<String, String> get asMap;
  /// must validate every variable during the load
  Future<bool> load(List<String> variables);
}
```

(not used in this project example)
The other useful thing you can do with Environment is proxy:
```dart
  void operator []=(String name, String? value) {
    _validateVar(name, value);
    if (_canBeUpdated(name)) {
      _box.put(name, value!);
    }
  }
```

### .env for this project example

In this example, I've created an app asset `.env` with this content:
```shell
DOMAIN_URL=https://bazilodestar.com
# TODO
SECONDARY_DOMAIN_URL=https://bazilodestar.com
SENTRY_DSN=https://53350b430e17b2286ac56ad9ee41a293@o379920.ingest.us.sentry.io/4506893446414336
```
And used plugin [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) to load it with a wrapper in `lib/config/env/plugins/flutter_dotenv.dart`

@TODO:
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