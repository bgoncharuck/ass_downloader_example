late final Environment env;

abstract class Environment {
  void operator []=(String name, String? value);
  String operator [](String name);
  Map<String, String> get asMap;
  Future<bool> load(List<String> variables);
}
