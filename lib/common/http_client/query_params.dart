class QueryParams {
  final Map<String, dynamic> params = {};

  void setParam(String key, dynamic value) {
    this.params[key] = value;
  }

  dynamic getParam(String key) {
    return this.params[key];
  }

  Map<String, dynamic> getParams() {
    return this.params;
  }
}