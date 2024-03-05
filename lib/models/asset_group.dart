abstract class AssetGroup {
  String get groupName;
  String get baseUrl;
  Iterable<String> get assets;
  Iterable<String> get urls;
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
