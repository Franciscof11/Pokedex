class Pokemon {
  int id;
  String name;
  String type;
  String imageLink;
  int hp;
  int attack;
  int defense;
  int speed;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.imageLink,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
  });

  Pokemon copyWith({
    int? id,
    String? name,
    String? type,
    String? imageLink,
    int? hp,
    int? attack,
    int? defense,
    int? speed,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      imageLink: imageLink ?? this.imageLink,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      speed: speed ?? this.speed,
    );
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      imageLink: map['imageLink'] ?? '',
      hp: map['hp']?.toInt() ?? 0,
      attack: map['attack']?.toInt() ?? 0,
      defense: map['defense']?.toInt() ?? 0,
      speed: map['speed']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, type: $type, imageLink: $imageLink, hp: $hp, attack: $attack, defense: $defense, speed: $speed)';
  }
}
