import 'dart:convert';

class Contact {
  final String name;
  Contact({
    this.name,
  });

  Contact copyWith({
    String name,
  }) {
    return Contact(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Contact(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));
}
