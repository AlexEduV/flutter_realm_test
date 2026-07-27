class JsonUtil {
  static Map<String, String> flattenJson(Map<String, dynamic> json, [String prefix = '']) {
    final Map<String, String> result = {};
    json.forEach((key, value) {
      final newKey = prefix.isEmpty ? key : '$prefix.$key';
      if (value is Map<String, dynamic>) {
        result.addAll(flattenJson(value, newKey));
      } else {
        result[newKey] = value.toString();
      }
    });
    return result;
  }
}
