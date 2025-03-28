import 'package:equatable/equatable.dart';

class Temu extends Equatable {
  Temu({
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

  final String object;
  final String id;
  final DateTime? createdTime;
  final DateTime? lastEditedTime;
  final TedBy? createdBy;
  final TedBy? lastEditedBy;
  final dynamic cover;
  final dynamic icon;
  final Parent? parent;
  final bool archived;
  final bool inTrash;
  final Properties? properties;
  final String url;
  final dynamic publicUrl;

  Temu copyWith({
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
    return Temu(
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

  factory Temu.fromJson(Map<String, dynamic> json) {
    return Temu(
      object: json["object"] ?? "",
      id: json["id"] ?? "",
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
      archived: json["archived"] ?? false,
      inTrash: json["in_trash"] ?? false,
      properties:
          json["properties"] == null
              ? null
              : Properties.fromJson(json["properties"]),
      url: json["url"] ?? "",
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

  final String object;
  final String id;

  TedBy copyWith({String? object, String? id}) {
    return TedBy(object: object ?? this.object, id: id ?? this.id);
  }

  factory TedBy.fromJson(Map<String, dynamic> json) {
    return TedBy(object: json["object"] ?? "", id: json["id"] ?? "");
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

  final String type;
  final String databaseId;

  Parent copyWith({String? type, String? databaseId}) {
    return Parent(
      type: type ?? this.type,
      databaseId: databaseId ?? this.databaseId,
    );
  }

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      type: json["type"] ?? "",
      databaseId: json["database_id"] ?? "",
    );
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
    required this.categories,
    required this.image,
    required this.video,
    required this.name,
  });

  final Categories? categories;
  final Image? image;
  final Image? video;
  final Name? name;

  Properties copyWith({
    Categories? categories,
    Image? image,
    Image? video,
    Name? name,
  }) {
    return Properties(
      categories: categories ?? this.categories,
      image: image ?? this.image,
      video: video ?? this.video,
      name: name ?? this.name,
    );
  }

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      categories:
          json["Categories"] == null
              ? null
              : Categories.fromJson(json["Categories"]),
      image: json["Image"] == null ? null : Image.fromJson(json["Image"]),
      video: json["Video"] == null ? null : Image.fromJson(json["Video"]),
      name: json["Name"] == null ? null : Name.fromJson(json["Name"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "Categories": categories?.toJson(),
    "Image": image?.toJson(),
    "Video": video?.toJson(),
    "Name": name?.toJson(),
  };

  @override
  String toString() {
    return "$categories, $image, $video, $name, ";
  }

  @override
  List<Object?> get props => [categories, image, video, name];
}

class Categories extends Equatable {
  Categories({required this.id, required this.type, required this.multiSelect});

  final String id;
  final String type;
  final List<MultiSelect> multiSelect;

  Categories copyWith({
    String? id,
    String? type,
    List<MultiSelect>? multiSelect,
  }) {
    return Categories(
      id: id ?? this.id,
      type: type ?? this.type,
      multiSelect: multiSelect ?? this.multiSelect,
    );
  }

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      multiSelect:
          json["multi_select"] == null
              ? []
              : List<MultiSelect>.from(
                json["multi_select"]!.map((x) => MultiSelect.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "multi_select": multiSelect.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$id, $type, $multiSelect, ";
  }

  @override
  List<Object?> get props => [id, type, multiSelect];
}

class MultiSelect extends Equatable {
  MultiSelect({required this.id, required this.name, required this.color});

  final String id;
  final String name;
  final String color;

  MultiSelect copyWith({String? id, String? name, String? color}) {
    return MultiSelect(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  factory MultiSelect.fromJson(Map<String, dynamic> json) {
    return MultiSelect(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      color: json["color"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "color": color};

  @override
  String toString() {
    return "$id, $name, $color, ";
  }

  @override
  List<Object?> get props => [id, name, color];
}

class Image extends Equatable {
  Image({required this.id, required this.type, required this.richText});

  final String id;
  final String type;
  final List<RichText> richText;

  Image copyWith({String? id, String? type, List<RichText>? richText}) {
    return Image(
      id: id ?? this.id,
      type: type ?? this.type,
      richText: richText ?? this.richText,
    );
  }

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      richText:
          json["rich_text"] == null
              ? []
              : List<RichText>.from(
                json["rich_text"]!.map((x) => RichText.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "rich_text": richText.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$id, $type, $richText, ";
  }

  @override
  List<Object?> get props => [id, type, richText];
}

class RichText extends Equatable {
  RichText({
    required this.type,
    required this.text,
    required this.annotations,
    required this.plainText,
    required this.href,
  });

  final String type;
  final Text? text;
  final Annotations? annotations;
  final String plainText;
  final String href;

  RichText copyWith({
    String? type,
    Text? text,
    Annotations? annotations,
    String? plainText,
    String? href,
  }) {
    return RichText(
      type: type ?? this.type,
      text: text ?? this.text,
      annotations: annotations ?? this.annotations,
      plainText: plainText ?? this.plainText,
      href: href ?? this.href,
    );
  }

  factory RichText.fromJson(Map<String, dynamic> json) {
    return RichText(
      type: json["type"] ?? "",
      text: json["text"] == null ? null : Text.fromJson(json["text"]),
      annotations:
          json["annotations"] == null
              ? null
              : Annotations.fromJson(json["annotations"]),
      plainText: json["plain_text"] ?? "",
      href: json["href"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "text": text?.toJson(),
    "annotations": annotations?.toJson(),
    "plain_text": plainText,
    "href": href,
  };

  @override
  String toString() {
    return "$type, $text, $annotations, $plainText, $href, ";
  }

  @override
  List<Object?> get props => [type, text, annotations, plainText, href];
}

class Annotations extends Equatable {
  Annotations({
    required this.bold,
    required this.italic,
    required this.strikethrough,
    required this.underline,
    required this.code,
    required this.color,
  });

  final bool bold;
  final bool italic;
  final bool strikethrough;
  final bool underline;
  final bool code;
  final String color;

  Annotations copyWith({
    bool? bold,
    bool? italic,
    bool? strikethrough,
    bool? underline,
    bool? code,
    String? color,
  }) {
    return Annotations(
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      strikethrough: strikethrough ?? this.strikethrough,
      underline: underline ?? this.underline,
      code: code ?? this.code,
      color: color ?? this.color,
    );
  }

  factory Annotations.fromJson(Map<String, dynamic> json) {
    return Annotations(
      bold: json["bold"] ?? false,
      italic: json["italic"] ?? false,
      strikethrough: json["strikethrough"] ?? false,
      underline: json["underline"] ?? false,
      code: json["code"] ?? false,
      color: json["color"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "bold": bold,
    "italic": italic,
    "strikethrough": strikethrough,
    "underline": underline,
    "code": code,
    "color": color,
  };

  @override
  String toString() {
    return "$bold, $italic, $strikethrough, $underline, $code, $color, ";
  }

  @override
  List<Object?> get props => [
    bold,
    italic,
    strikethrough,
    underline,
    code,
    color,
  ];
}

class Text extends Equatable {
  Text({required this.content, required this.link});

  final String content;
  final Link? link;

  Text copyWith({String? content, Link? link}) {
    return Text(content: content ?? this.content, link: link ?? this.link);
  }

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(
      content: json["content"] ?? "",
      link: json["link"] == null ? null : Link.fromJson(json["link"]),
    );
  }

  Map<String, dynamic> toJson() => {"content": content, "link": link?.toJson()};

  @override
  String toString() {
    return "$content, $link, ";
  }

  @override
  List<Object?> get props => [content, link];
}

class Link extends Equatable {
  Link({required this.url});

  final String url;

  Link copyWith({String? url}) {
    return Link(url: url ?? this.url);
  }

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(url: json["url"] ?? "");
  }

  Map<String, dynamic> toJson() => {"url": url};

  @override
  String toString() {
    return "$url, ";
  }

  @override
  List<Object?> get props => [url];
}

class Name extends Equatable {
  Name({required this.id, required this.type, required this.title});

  final String id;
  final String type;
  final List<RichText> title;

  Name copyWith({String? id, String? type, List<RichText>? title}) {
    return Name(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      title:
          json["title"] == null
              ? []
              : List<RichText>.from(
                json["title"]!.map((x) => RichText.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$id, $type, $title, ";
  }

  @override
  List<Object?> get props => [id, type, title];
}
