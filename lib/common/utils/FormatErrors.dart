class FormatErrors{
  static Map<String, String> replaceName(Map<String, String> messages, Map<String, String> names){
    return messages.map((key, value) {
      String replacer = names[key] != null ? names[key]! : key;
      String newValue = value.replaceAll(key, replacer);
      return MapEntry(key, newValue);
    });
  }
}