class Sound {
  final int id;
  final String name;
  final MetaData metadata;

  Sound({required this.id, required this.name, required this.metadata});

  factory Sound.fromJson(item) => Sound(
      id: item['id'],
      name: item['name'],
      metadata: MetaData.fromJson(item['metadata']));

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'metadata': metadata};
}

class MetaData {
  final String description;
  final List<String> tags;
  final String author;

  MetaData(
      {required this.description, required this.tags, required this.author});

  factory MetaData.fromJson(item) => MetaData(
      description: item['description'],
      tags: List<String>.from(item['tags']),
      author: item['author']);

  Map<String, dynamic> toJson() =>
      {'description': description, 'tags': tags, 'author': author};
}
