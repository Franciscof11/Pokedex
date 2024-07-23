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
      type: map['types'][0]['type']['name'] ?? '',
      imageLink: map['sprites']['other']['dream_world']['front_default'] ?? '',
      hp: map['stats'][0]['base_stat']?.toInt() ?? 0,
      attack: map['stats'][1]['base_stat']?.toInt() ?? 0,
      defense: map['stats'][2]['base_stat']?.toInt() ?? 0,
      speed: map['stats'][5]['base_stat']?.toInt() ?? 0,
    );
  }

  factory Pokemon.empty() {
    return Pokemon(
      id: 0,
      name: '',
      type: '',
      imageLink: '',
      hp: 0,
      attack: 0,
      defense: 0,
      speed: 0,
    );
  }

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, type: $type, imageLink: $imageLink, hp: $hp, attack: $attack, defense: $defense, speed: $speed)';
  }
}
