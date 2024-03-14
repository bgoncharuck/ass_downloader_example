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

## Native Splash Preservation

Native splash screen preservation is a technique that maintains the display of the native splash screen until the Flutter application has fully initialized. This ensures a smoother and more cohesive user experience.

**Why**

* **Smooth transition:** Users experience a consistent visual transition from the native splash screen to the Flutter UI, enhancing the app's perceived polish and readiness.
* **Faster load time perception:** Displaying the native splash screen creates the impression of a quicker launch, even if background initialization tasks are ongoing. Users often perceive faster loading times with visual feedback like a splash screen, compared to a blank screen during the loading process.

Several plugins implement this technique, both natively on Android and iOS and as flutter plugins. In this project, I use the [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) package.

The plugin utilizes `widgetBinding` for its functionality. Therefore, it's recommended to create an extension for this purpose:
```dart
bool _splashScreenStopped = false;

extension NativeSplashPreservation on WidgetsBinding {
  void preserveSplashScreen() {
    FlutterNativeSplash.preserve(widgetsBinding: this);
  }

  void removeSplashScreen() {
    /// native splash can be removed only once
    if (_splashScreenStopped) {
      return;
    }
    FlutterNativeSplash.remove();
    _splashScreenStopped = true;
  }
}
```

Then call preserveSplashScreen() on widgetsBinding before the app runner and any services initialization/dependency injection tasks.
And removeSplashScreen() after the first app screen is fully initialized.

## Logger
Logs are essential for pinpointing the root cause of crashes, errors, and unexpected behavior in an application.

While using print statements to the console is a common practice for developers, it's not ideal for production environments due to:
* **Potential exposure of sensitive information**: Printing sensitive data to the console can be a security risk.
* **Performance impact**: Printing to the console adds overhead and can slow down the app's execution.

This is easily solved with `debugPrint` over `print` as it only runs in debug mode.

The other problem with printing into the console, is that you won't see prints inside the user app that runs on user's device.
This is why solutions like Firebase Crashlytics, Sentry and many other tools exist for this purpose.

They are also can watch for crashes in the real time and tell exactly where exception happened and it's stacktrace.

For small projects one such service is enough, but the more complex app becomes, the more services for debugging, other logs or even analytics SDKs you'll need to use.

The facade pattern provides a clean approach to manage multiple logging services starting from less in the start, and adding more in the future. 
Here's an example implementation:
```dart
/// contract
abstract class LoggingLibrary {
  Future<void> exception(Object e, StackTrace t);
  Future<void> message(String message);
}

/// implementations
//...
class DebugPrintLogging implements LoggingLibrary {
//...
class SentryLogging implements LoggingLibrary {
//...
class FirebaseLogging implements LoggingLibrary {
```

Then you can use facade composition to log into multiple libraries at once:
```dart
class MultipleLibrariesLogging implements LoggingLibrary {
  final Iterable<LoggingLibrary> libraries = [
    const SentryLogging(),
    if (kDebugMode) const DebugPrintLogging(),
  ];

  @override
  Future<void> exception(Object e, StackTrace t) async {
    for (final lib in libraries) {
      await lib.exception(e, t);
    }
  }

  @override
  Future<void> message(String message) async {
    for (final lib in libraries) {
      await lib.message(message);
    }
  }
}
```

You can do the same for any analytics services with a more complex [contract](https://github.com/bgoncharuck/use_cases/blob/main/services/analytics/facade.dart).

## App Initialization (Config) Module

While cramming all initialization logic into a single `main()` function might seem like a simpler initial approach, it leads to several critical issues down the road:

- **Circular Dependencies:** Services and configurations can become entangled, leading to situations where components rely on each other's initialization before they themselves are fully initialized. This creates a deadlock and prevents the app from starting.
- **Complicated Logic:** A single `main()` function quickly becomes cluttered and difficult to understand as the app grows. Complex initialization steps become interwoven, making maintenance and debugging a nightmare.
- **Spaghetti Code:** The lack of clear separation promotes messy and unstructured code. Refactoring or modifying functionalities becomes a significant challenge due to the interconnected nature of the codebase.
- **Main Maintainability:** Perhaps the most crucial aspect - a single, monolithic `main()` function significantly hinders long-term maintainability. Adding new features or modifying existing ones becomes a daunting task due to the difficulty of isolating changes and potential ripple effects.

To address these challenges and ensure a clean, maintainable, and scalable codebase, separating the initialization logic is essential. This involves creating a dedicated configuration layer responsible for initializing:

- **Individual Services:** Each service within the app should have its own initialization routine, allowing for independent setup and configuration.
- **App Dependencies:** Dependencies required by the application should also be explicitly initialized within the configuration layer.
- **App Itself:** Finally, the actual application initialization, including setting up widgets and routing, can be handled within a designated section.

Example of configuration routines:
```dart
/// params is `runApp` function
class InitializeApp with IUseCase<void Function(), void> {
  const InitializeApp();
  @override
  Future<void> execute({required void Function() params}) async {
    await const ConfigWidgetsBinding().execute();
    await const InitializeEnvironment().execute(
      params: [
        'DOMAIN_URL',
        'SECONDARY_DOMAIN_URL',
        'SENTRY_DSN',
      ],
    );
    await const InitializeLogger().execute();

    await const SetCrashWatcherOverAppRunner().execute(
      params: params,
    );
  }
}

Future<void> main() async {
  await const InitializeApp().execute(
    params: () => runApp(
      const App(),
    ),
  );
}
```

By separating initialization logic like this, you gain several advantages:
- **Improved Modularity**: Each configuration step becomes a discrete unit, promoting better code organization and easier comprehension.
- **Enhanced Maintainability**: Changes or additions to specific functionalities are isolated, making the codebase more manageable in the long run.
- **Scalability**: As the app grows in complexity, the configuration layer can be easily extended to accommodate new requirements.

In essence, separating initialization logic is an investment **in the future** of your application. It promotes cleaner code, simplifies maintenance, and paves the way for a more scalable and sustainable codebase.

## Internet Connection Check

Before initiating a download, it's crucial to verify that the user's device has an active internet connection. If no connection is detected, the application must inform the user and provide an option to retry the download once they are connected. This ensures a smooth user experience by preventing download attempts that would ultimately fail due to lack of internet access.

Maintaining high availability and reliability often involves utilizing multiple server domains. This strategy mitigates the potential impact of single-point failures. A domain can become unavailable for various reasons, such as expired payment or maintenance downtime.

For this exact reason we are checking the connection to our domains before downloading files.
Ideally, we choose what connection is the fastest but it's out of the scope of this example project.

In this project I use a simple HTTP ping strategy for checking server connection status. It sends HTTP GET requests to each provided URL and checks the response status code. If the status code is 200 (OK), it considers the server reachable:
```dart
final futures = <Future<String>>[];

for (final url in urls) {
  futures.add((url) {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200 ? url : '';
  });
}

final availableDomains = <String>[];
try {
  availableDomains.addAll(await Future.wait(futures));
} catch (e, t) {
  await log.exception(e, t);
}
return availableDomains.where((domain) => domain.isNotEmpty).toList();
```

## Path Manager

It's crucial to efficiently handle asset paths, where files will be downloaded, how to extract filename from url, how to know if file is already downloaded into the path.

Everything related to the path, file name, extracting file name from the url must be done in a separate module.

For most apps the simple checks of file existence in the app directory is enough.
But for some, this module evolves to the usage of [virtual file system](https://github.com/bgoncharuck/use_cases/tree/main/services/virtual_file_system), directory view models, complex path visitors and regex scripts.

For the general purpose the module can have this contract:
- Ability to check whether a file with a given name already exists.
- Retrieval of the directory where files will be downloaded to.
- Generation of file save paths based on file names.
- Mapping between file names and their respective paths.
- Extraction of file names from URLs for path retrieval.

```dart
abstract class AssetPath {
  Future<bool> exists(String fileName);

  /// directory where files can be downloaded to
  Future<String> get savePath;
  Future<String> fileSavePath(String fileName);
  String? getFilePath(String fileName);
  String getFileNameFromUrl(String url);
  String? getFilePathByUrl(String url);
  void put(String fileName, String filePath);
}
```
## Download Strategy

There are various ways to download a file.
From spawning isolates with [dedicated workers](https://github.com/bgoncharuck/use_cases/tree/main/services/isolate/modified_worker_pattern) and its IDs, creating [background services](https://github.com/bgoncharuck/use_cases/tree/main/services/isolate/producer_consumer_pattern) to simply downloading file using a future which is sufficient for small apps like this one:

```dart
try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        await log.message('Download failed, ${response.statusCode}, $path');
        return DownloadResult(
          status: const DownloadError(),
        );
      }

      final file = await File(path).create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
      return DownloadResult(
        status: const DownloadSuccess(),
      );
    } catch (e, t) {
      await log.exception(e, t);
    }
```

This code demonstrates a straightforward download implementation using a Future. It fetches the file from the provided URL, checks the response status code, creates the necessary file, and writes the downloaded data.

Despite utilizing a simpler approach for this project, it's valuable to acknowledge the potential need for a more flexible solution in the future. Introducing the Strategy pattern provides a foundation for implementing different download approaches based on the application or feature requirements.

```dart
abstract class DownloadStrategy {
  Future<DownloadResult> downloadFile({
    required String url,
    required String path,
    String? id,
  });
}
```

## Asset Group

The Asset Group concept serves a dual purpose within your application:
- It acts as a container for a collection of related files. These files are assigned clear and descriptive names, for best code readability and maintainability. This structure simplifies the process of locating and utilizing these assets within your project.
- It establishes a well-defined interface for downloading a specific set of app assets. This interface promotes flexibility and allows for the implementation of different download strategies based on the application's requirements.

Usage examples:
- GameLevelAssetGroup can represent the assets associated with a single level within a game. This could encompass textures, models, sound effects, and music specific to that particular level.
- ModuleAssetGroup can be used to group the assets belonging to each module. This facilitates efficient management and loading of assets relevant to each module's functionality.
- MenuScreenSoundsAssetGroup to organize assets like music and sound effects used specifically in the app's menu or home screen. This approach promotes better organization and simplifies the process of managing these distinct asset categories.

The core contract for the AssetGroup class, which has proven sufficient for most applications:
```dart
abstract class AssetGroup {
  /// Each group must have a unique and descriptive name for identification.
  String get groupName;

  /// Base URL: The concrete implementation's constructor must provide a base URL. This can be a domain address or a path prefix used to construct the complete download URLs for the assets within the group.
  String get baseUrl;

  /// List of Assets: This property exposes a list of asset names or relative paths within the group. This list serves as the source for generating download URLs and managing the assets associated with this group.
  Iterable<String> get assets;

  /// Download URLs: This property provides a collection of URLs derived from the `assets` list and potentially combined with the `baseUrl`. These URLs represent the locations from where the assets can be downloaded.
  Iterable<String> get urls;
}
```

Which can later be extended based on the category of asset group:
```dart
class ImageAssetGroup extends DefaultAssetGroup {
  /// Additional properties specific to image assets
  final double width;
  final double height;
}

class SoundsAssetGroup extends DefaultAssetGroup {
  /// Additional properties specific to sound assets
  final bool isLooped;
  final Order order; // Enum representing the playback order (e.g., sequential, random)
}

class CertificateAssetGroup extends DefaultAssetGroup {
  /// Additional properties specific to certificate assets
  final String issuedBy;
  final DateTime issueDate;
}
```

## Download Group

## Assets Manager

## Image Assets Group

## Precache Image into Context (No Blinks)