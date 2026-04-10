class JsonUtil {
  static Map<String, String> flattenJson(Map<String, dynamic> json, [String prefix = '']) {
    final Map<String, String> result = {};
    json.forEach((key, value) {
      final newKey = prefix.isEmpty ? key : '$prefix.$key';
      if (value is Map) {
        result.addAll(flattenJson(value as Map<String, dynamic>, newKey));
      } else {
        result[newKey] = value.toString();
      }
    });
    return result;
  }
}
