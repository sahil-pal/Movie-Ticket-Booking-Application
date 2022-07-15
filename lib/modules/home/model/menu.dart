import 'dart:convert';

class Menu {
  final String name;
  final String asset;

  Menu({
    required this.name,
    required this.asset,
  });

  Menu copyWith({
    String? name,
    String? asset,
  }) {
    return Menu(
      name: name ?? this.name,
      asset: asset ?? this.asset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'asset': asset,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      name: map['name'] ?? '',
      asset: map['asset'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));

  @override
  String toString() => 'MenuModel(name: $name, asset: $asset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menu && other.name == name && other.asset == asset;
  }

  @override
  int get hashCode => name.hashCode ^ asset.hashCode;
}