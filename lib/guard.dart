class Guard {
  final String id;
  final String name;
  Guard(this.id, this.name);
  static Guard? fromJson(final dynamic json) {
    if (json != null) {
      return Guard(json["auth_key"], json["name"]);
    } else {
      return null;
    }
  }
}
