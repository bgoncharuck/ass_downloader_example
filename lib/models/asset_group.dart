abstract class AssetGroup {
  String get groupName;
  String get baseUrl;
  Iterable<String> get assets;
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
