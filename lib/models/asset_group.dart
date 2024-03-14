abstract class AssetGroup {
  /// Each group must have a unique and descriptive name for identification.
  String get groupName;

  /// Base URL: The concrete implementation's constructor must provide a base
  /// URL. This can be a domain address or a path prefix used to construct the
  /// complete download URLs for the assets within the group.
  String get baseUrl;

  /// List of Assets: This property exposes a list of asset names or relative
  /// paths within the group.
  /// This list serves as the source for generating download URLs
  /// and managing the assets associated with this group.
  Iterable<String> get assets;

  /// Download URLs: This property provides a collection of URLs
  /// derived from the `assets` list and
  /// potentially combined with the `baseUrl`.
  /// These URLs represent the locations from
  /// where the assets can be downloaded.
  Iterable<String> get urls;
}

class ImageAssetGroup extends DefaultAssetGroup {
  ImageAssetGroup({
    required super.groupName,
    required super.baseUrl,
    required super.assets,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
}

class DefaultAssetGroup implements AssetGroup {
  DefaultAssetGroup({
    required this.groupName,
    required this.baseUrl,
    required this.assets,
  }) {
    for (final asset in assets) {
      _urls.add('$baseUrl/$asset');
    }
  }

  @override
  final String groupName;
  @override
  final String baseUrl;
  @override
  final List<String> assets;

  final List<String> _urls = [];

  @override
  Iterable<String> get urls => _urls;
}
