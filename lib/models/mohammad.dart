import 'package:equatable/equatable.dart';

class Mohammad extends Equatable {
  const Mohammad({
    required this.object,
    required this.id,
    required this.createdTime,
    required this.lastEditedTime,
    required this.createdBy,
    required this.lastEditedBy,
    required this.cover,
    required this.icon,
    required this.parent,
    required this.archived,
    required this.inTrash,
    required this.properties,
    required this.url,
    required this.publicUrl,
  });

  final String? object;
  final String? id;
  final DateTime? createdTime;
  final DateTime? lastEditedTime;
  final TedBy? createdBy;
  final TedBy? lastEditedBy;
  final dynamic cover;
  final dynamic icon;
  final Parent? parent;
  final bool? archived;
  final bool? inTrash;
  final Properties? properties;
  final String? url;
  final dynamic publicUrl;

  Mohammad copyWith({
    String? object,
    String? id,
    DateTime? createdTime,
    DateTime? lastEditedTime,
    TedBy? createdBy,
    TedBy? lastEditedBy,
    dynamic cover,
    dynamic icon,
    Parent? parent,
    bool? archived,
    bool? inTrash,
    Properties? properties,
    String? url,
    dynamic publicUrl,
  }) {
    return Mohammad(
      object: object ?? this.object,
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      lastEditedTime: lastEditedTime ?? this.lastEditedTime,
      createdBy: createdBy ?? this.createdBy,
      lastEditedBy: lastEditedBy ?? this.lastEditedBy,
      cover: cover ?? this.cover,
      icon: icon ?? this.icon,
      parent: parent ?? this.parent,
      archived: archived ?? this.archived,
      inTrash: inTrash ?? this.inTrash,
      properties: properties ?? this.properties,
      url: url ?? this.url,
      publicUrl: publicUrl ?? this.publicUrl,
    );
  }

  factory Mohammad.fromJson(Map<String, dynamic> json) {
    return Mohammad(
      object: json["object"],
      id: json["id"],
      createdTime: DateTime.tryParse(json["created_time"] ?? ""),
      lastEditedTime: DateTime.tryParse(json["last_edited_time"] ?? ""),
      createdBy:
          json["created_by"] == null
              ? null
              : TedBy.fromJson(json["created_by"]),
      lastEditedBy:
          json["last_edited_by"] == null
              ? null
              : TedBy.fromJson(json["last_edited_by"]),
      cover: json["cover"],
      icon: json["icon"],
      parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
      archived: json["archived"],
      inTrash: json["in_trash"],
      properties:
          json["properties"] == null
              ? null
              : Properties.fromJson(json["properties"]),
      url: json["url"],
      publicUrl: json["public_url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "object": object,
    "id": id,
    "created_time": createdTime?.toIso8601String(),
    "last_edited_time": lastEditedTime?.toIso8601String(),
    "created_by": createdBy?.toJson(),
    "last_edited_by": lastEditedBy?.toJson(),
    "cover": cover,
    "icon": icon,
    "parent": parent?.toJson(),
    "archived": archived,
    "in_trash": inTrash,
    "properties": properties?.toJson(),
    "url": url,
    "public_url": publicUrl,
  };

  @override
  String toString() {
    return "$object, $id, $createdTime, $lastEditedTime, $createdBy, $lastEditedBy, $cover, $icon, $parent, $archived, $inTrash, $properties, $url, $publicUrl, ";
  }

  @override
  List<Object?> get props => [
    object,
    id,
    createdTime,
    lastEditedTime,
    createdBy,
    lastEditedBy,
    cover,
    icon,
    parent,
    archived,
    inTrash,
    properties,
    url,
    publicUrl,
  ];
}

class TedBy extends Equatable {
  TedBy({required this.object, required this.id});

  final String? object;
  final String? id;

  TedBy copyWith({String? object, String? id}) {
    return TedBy(object: object ?? this.object, id: id ?? this.id);
  }

  factory TedBy.fromJson(Map<String, dynamic> json) {
    return TedBy(object: json["object"], id: json["id"]);
  }

  Map<String, dynamic> toJson() => {"object": object, "id": id};

  @override
  String toString() {
    return "$object, $id, ";
  }

  @override
  List<Object?> get props => [object, id];
}

class Parent extends Equatable {
  Parent({required this.type, required this.databaseId});

  final String? type;
  final String? databaseId;

  Parent copyWith({String? type, String? databaseId}) {
    return Parent(
      type: type ?? this.type,
      databaseId: databaseId ?? this.databaseId,
    );
  }

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(type: json["type"], databaseId: json["database_id"]);
  }

  Map<String, dynamic> toJson() => {"type": type, "database_id": databaseId};

  @override
  String toString() {
    return "$type, $databaseId, ";
  }

  @override
  List<Object?> get props => [type, databaseId];
}

class Properties extends Equatable {
  Properties({
    required this.tags,
    required this.image,
    required this.video,
    required this.name,
  });

  final Tags? tags;
  final Image? image;
  final Image? video;
  final Name? name;

  Properties copyWith({Tags? tags, Image? image, Image? video, Name? name}) {
    return Properties(
      tags: tags ?? this.tags,
      image: image ?? this.image,
      video: video ?? this.video,
      name: name ?? this.name,
    );
  }

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      tags: json["Tags"] == null ? null : Tags.fromJson(json["Tags"]),
      image: json["Image"] == null ? null : Image.fromJson(json["Image"]),
      video: json["Video"] == null ? null : Image.fromJson(json["Video"]),
      name: json["Name"] == null ? null : Name.fromJson(json["Name"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "Tags": tags?.toJson(),
    "Image": image?.toJson(),
    "Video": video?.toJson(),
    "Name": name?.toJson(),
  };

  @override
  String toString() {
    return "$tags, $image, $video, $name, ";
  }

  @override
  List<Object?> get props => [tags, image, video, name];
}

class Image extends Equatable {
  Image({required this.id, required this.type, required this.richText});

  final String? id;
  final String? type;
  final List<dynamic> richText;

  Image copyWith({String? id, String? type, List<dynamic>? richText}) {
    return Image(
      id: id ?? this.id,
      type: type ?? this.type,
      richText: richText ?? this.richText,
    );
  }

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json["id"],
      type: json["type"],
      richText:
          json["rich_text"] == null
              ? []
              : List<dynamic>.from(json["rich_text"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "rich_text": richText.map((x) => x).toList(),
  };

  @override
  String toString() {
    return "$id, $type, $richText, ";
  }

  @override
  List<Object?> get props => [id, type, richText];
}

class Name extends Equatable {
  Name({required this.id, required this.type, required this.title});

  final String? id;
  final String? type;
  final List<dynamic> title;

  Name copyWith({String? id, String? type, List<dynamic>? title}) {
    return Name(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      id: json["id"],
      type: json["type"],
      title:
          json["title"] == null
              ? []
              : List<dynamic>.from(json["title"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title.map((x) => x).toList(),
  };

  @override
  String toString() {
    return "$id, $type, $title, ";
  }

  @override
  List<Object?> get props => [id, type, title];
}

class Tags extends Equatable {
  Tags({required this.id, required this.type, required this.multiSelect});

  final String? id;
  final String? type;
  final List<dynamic> multiSelect;

  Tags copyWith({String? id, String? type, List<dynamic>? multiSelect}) {
    return Tags(
      id: id ?? this.id,
      type: type ?? this.type,
      multiSelect: multiSelect ?? this.multiSelect,
    );
  }

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      id: json["id"],
      type: json["type"],
      multiSelect:
          json["multi_select"] == null
              ? []
              : List<dynamic>.from(json["multi_select"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "multi_select": multiSelect.map((x) => x).toList(),
  };

  @override
  String toString() {
    return "$id, $type, $multiSelect, ";
  }

  @override
  List<Object?> get props => [id, type, multiSelect];
}
