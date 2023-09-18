
enum Flavor {
  dev,
  production,
}

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
    required this.appName,
  });
  final String baseUrl;
  final String appName;
}

class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString(), values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance?.flavor == Flavor.production;
  static bool isDevelopment() => _instance?.flavor == Flavor.dev;
  static String returnBaseUrl() => _instance!.values.baseUrl;
}
