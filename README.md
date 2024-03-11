# Assets Downloader Example

This project showcases various approaches I've created throughout my career, using clean Flutter without external dependencies.

The main feature is to download, cache, and use app assets from the backend. This functionality is reflected in the project's name, Assets Downloader Example.

Table of Contents:
- [Use Case](#use-case)

## Use Case {#use-case}

I implement Use Case as a mixin that later can be used to create module-specific use cases that are inside a module/service subfolder or a common use case that is inside use_case subfolders by categories.
Module-specific use cases are primarily used to initialize the module's interface (contract) with its concrete implementation. Common use cases have a more general purpose.

The generics P stands for Parameter, and R stands for Result.

``` dart
mixin IUseCase<P, R> {
  Future<R> execute({required P params});
}
```

