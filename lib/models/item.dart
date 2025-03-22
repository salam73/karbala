// ignore_for_file: unnecessary_question_mark

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class NotionItem {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? area;
  @HiveField(3)
  final num? price;
  @HiveField(4)
  final String? category;
  @HiveField(5)
  final List<String>? pictureUrls;
  @HiveField(6)
  final String? pageId;
  @HiveField(7)
  final String? lastEditedTime;
  @HiveField(8)
  final String? date;
  @HiveField(9)
  final num? number;
  @HiveField(10)
  final List<String>? pdfUrls;
  @HiveField(11)
  final List<String>? videoUrls; // Added videoUrls field

  NotionItem({
    this.object = '',
    this.id = '',
    this.createdTime,
    this.lastEditedTime,
    this.createdBy,
    this.lastEditedBy,
    this.cover,
    this.icon,
    this.parent,
    this.archived = false,
    this.inTrash = false,
    this.properties,
    this.url = '',
    this.publicUrl = '',
    this.title = '',
    this.description,
    this.area,
    this.price,
    this.category,
    this.pictureUrls,
    this.pageId,
    this.date,
    this.number,
    this.pdfUrls,
    this.videoUrls,
  });

  final String object;
  final String id;
  final DateTime? createdTime;
  final TedBy? createdBy;
  final TedBy? lastEditedBy;
  final dynamic cover;
  final dynamic icon;
  final Parent? parent;
  final bool archived;
  final bool inTrash;
  final Properties? properties;
  final String url;
  final String publicUrl;

  NotionItem copyWith({
    String? object,
    String? id,
    DateTime? createdTime,
    DateTime? lastEditedTime,
    TedBy? createdBy,
    TedBy? lastEditedBy,
    dynamic? cover,
    dynamic? icon,
    Parent? parent,
    bool? archived,
    bool? inTrash,
    Properties? properties,
    String? url,
    String? publicUrl,
  }) {
    return NotionItem(
      object: object ?? this.object,
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
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

  factory NotionItem.fromJson(Map<String, dynamic> json) {
    return NotionItem(
      object: json["object"] ?? "",
      id: json["id"] ?? "",
      createdTime: DateTime.tryParse(json["created_time"] ?? ""),
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
      publicUrl: json["public_url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "object": object,
    "id": id,
    "created_time": createdTime?.toIso8601String(),
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
  const TedBy({required this.object, required this.id});

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
  List<Object?> get props => [object, id];
}

class Parent extends Equatable {
  const Parent({required this.type, required this.databaseId});

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
  List<Object?> get props => [type, databaseId];
}

class Properties extends Equatable {
  const Properties({
    required this.myproduct,
    required this.description,
    required this.picture,
    required this.price,
    required this.subItem,
    required this.category,
    required this.parentItem,
    required this.products,
    required this.telefon,
    required this.address,
    required this.openshour,
    required this.area,
    required this.name,
  });

  final Address? myproduct;
  final Address? description;
  final Picture? picture;
  final Price? price;
  final ParentItem? subItem;
  final Area? category;
  final ParentItem? parentItem;
  final ParentItem? products;
  final Price? telefon;
  final Address? address;
  final Address? openshour;
  final Area? area;
  final Name? name;

  Properties copyWith({
    Address? myproduct,
    Address? description,
    Picture? picture,
    Price? price,
    ParentItem? subItem,
    Area? category,
    ParentItem? parentItem,
    ParentItem? products,
    Price? telefon,
    Address? address,
    Address? openshour,
    Area? area,
    Name? name,
  }) {
    return Properties(
      myproduct: myproduct ?? this.myproduct,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      price: price ?? this.price,
      subItem: subItem ?? this.subItem,
      category: category ?? this.category,
      parentItem: parentItem ?? this.parentItem,
      products: products ?? this.products,
      telefon: telefon ?? this.telefon,
      address: address ?? this.address,
      openshour: openshour ?? this.openshour,
      area: area ?? this.area,
      name: name ?? this.name,
    );
  }

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      myproduct:
          json["myproduct"] == null
              ? null
              : Address.fromJson(json["myproduct"]),
      description:
          json["description"] == null
              ? null
              : Address.fromJson(json["description"]),
      picture:
          json["picture"] == null ? null : Picture.fromJson(json["picture"]),
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
      subItem:
          json["Sub-item"] == null
              ? null
              : ParentItem.fromJson(json["Sub-item"]),
      category:
          json["category"] == null ? null : Area.fromJson(json["category"]),
      parentItem:
          json["Parent item"] == null
              ? null
              : ParentItem.fromJson(json["Parent item"]),
      products:
          json["products"] == null
              ? null
              : ParentItem.fromJson(json["products"]),
      telefon: json["telefon"] == null ? null : Price.fromJson(json["telefon"]),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      openshour:
          json["openshour"] == null
              ? null
              : Address.fromJson(json["openshour"]),
      area: json["area"] == null ? null : Area.fromJson(json["area"]),
      name: json["name"] == null ? null : Name.fromJson(json["name"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "myproduct": myproduct?.toJson(),
    "description": description?.toJson(),
    "picture": picture?.toJson(),
    "price": price?.toJson(),
    "Sub-item": subItem?.toJson(),
    "category": category?.toJson(),
    "Parent item": parentItem?.toJson(),
    "products": products?.toJson(),
    "telefon": telefon?.toJson(),
    "address": address?.toJson(),
    "openshour": openshour?.toJson(),
    "area": area?.toJson(),
    "name": name?.toJson(),
  };

  @override
  List<Object?> get props => [
    myproduct,
    description,
    picture,
    price,
    subItem,
    category,
    parentItem,
    products,
    telefon,
    address,
    openshour,
    area,
    name,
  ];
}

class Address extends Equatable {
  const Address({required this.id, required this.type, required this.richText});

  final String id;
  final String type;
  final List<RichText> richText;

  Address copyWith({String? id, String? type, List<RichText>? richText}) {
    return Address(
      id: id ?? this.id,
      type: type ?? this.type,
      richText: richText ?? this.richText,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
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
  List<Object?> get props => [id, type, richText];
}

class RichText extends Equatable {
  const RichText({
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
  final dynamic href;

  RichText copyWith({
    String? type,
    Text? text,
    Annotations? annotations,
    String? plainText,
    dynamic? href,
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
      href: json["href"],
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
  List<Object?> get props => [type, text, annotations, plainText, href];
}

class Annotations extends Equatable {
  const Annotations({
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
  const Text({required this.content, required this.link});

  final String content;
  final dynamic link;

  Text copyWith({String? content, dynamic? link}) {
    return Text(content: content ?? this.content, link: link ?? this.link);
  }

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(content: json["content"] ?? "", link: json["link"]);
  }

  Map<String, dynamic> toJson() => {"content": content, "link": link};

  @override
  List<Object?> get props => [content, link];
}

class Area extends Equatable {
  const Area({required this.id, required this.type, required this.select});

  final String id;
  final String type;
  final Select? select;

  Area copyWith({String? id, String? type, Select? select}) {
    return Area(
      id: id ?? this.id,
      type: type ?? this.type,
      select: select ?? this.select,
    );
  }

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      select: json["select"] == null ? null : Select.fromJson(json["select"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "select": select?.toJson(),
  };

  @override
  List<Object?> get props => [id, type, select];
}

class Select extends Equatable {
  const Select({required this.id, required this.name, required this.color});

  final String id;
  final String name;
  final String color;

  Select copyWith({String? id, String? name, String? color}) {
    return Select(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  factory Select.fromJson(Map<String, dynamic> json) {
    return Select(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      color: json["color"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "color": color};

  @override
  List<Object?> get props => [id, name, color];
}

class Name extends Equatable {
  const Name({required this.id, required this.type, required this.title});

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
  List<Object?> get props => [id, type, title];
}

class ParentItem extends Equatable {
  const ParentItem({
    required this.id,
    required this.type,
    required this.relation,
    required this.hasMore,
  });

  final String id;
  final String type;
  final List<Relation> relation;
  final bool hasMore;

  ParentItem copyWith({
    String? id,
    String? type,
    List<Relation>? relation,
    bool? hasMore,
  }) {
    return ParentItem(
      id: id ?? this.id,
      type: type ?? this.type,
      relation: relation ?? this.relation,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory ParentItem.fromJson(Map<String, dynamic> json) {
    return ParentItem(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      relation:
          json["relation"] == null
              ? []
              : List<Relation>.from(
                json["relation"]!.map((x) => Relation.fromJson(x)),
              ),
      hasMore: json["has_more"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "relation": relation.map((x) => x.toJson()).toList(),
    "has_more": hasMore,
  };

  @override
  List<Object?> get props => [id, type, relation, hasMore];
}

class Relation extends Equatable {
  const Relation({required this.id});

  final String id;

  Relation copyWith({String? id}) {
    return Relation(id: id ?? this.id);
  }

  factory Relation.fromJson(Map<String, dynamic> json) {
    return Relation(id: json["id"] ?? "");
  }

  Map<String, dynamic> toJson() => {"id": id};

  @override
  List<Object?> get props => [id];
}

class Picture extends Equatable {
  const Picture({required this.id, required this.type, required this.files});

  final String id;
  final String type;
  final List<FileElement> files;

  Picture copyWith({String? id, String? type, List<FileElement>? files}) {
    return Picture(
      id: id ?? this.id,
      type: type ?? this.type,
      files: files ?? this.files,
    );
  }

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      files:
          json["files"] == null
              ? []
              : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "files": files.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [id, type, files];
}

class FileElement extends Equatable {
  const FileElement({
    required this.name,
    required this.type,
    required this.file,
  });

  final String name;
  final String type;
  final FileFile? file;

  FileElement copyWith({String? name, String? type, FileFile? file}) {
    return FileElement(
      name: name ?? this.name,
      type: type ?? this.type,
      file: file ?? this.file,
    );
  }

  factory FileElement.fromJson(Map<String, dynamic> json) {
    return FileElement(
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      file: json["file"] == null ? null : FileFile.fromJson(json["file"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "file": file?.toJson(),
  };

  @override
  List<Object?> get props => [name, type, file];
}

class FileFile extends Equatable {
  const FileFile({required this.url, required this.expiryTime});

  final String url;
  final DateTime? expiryTime;

  FileFile copyWith({String? url, DateTime? expiryTime}) {
    return FileFile(
      url: url ?? this.url,
      expiryTime: expiryTime ?? this.expiryTime,
    );
  }

  factory FileFile.fromJson(Map<String, dynamic> json) {
    return FileFile(
      url: json["url"] ?? "",
      expiryTime: DateTime.tryParse(json["expiry_time"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "expiry_time": expiryTime?.toIso8601String(),
  };

  @override
  List<Object?> get props => [url, expiryTime];
}

class Price extends Equatable {
  const Price({required this.id, required this.type, required this.number});

  final String id;
  final String type;
  final int number;

  Price copyWith({String? id, String? type, int? number}) {
    return Price(
      id: id ?? this.id,
      type: type ?? this.type,
      number: number ?? this.number,
    );
  }

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      number: json["number"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "type": type, "number": number};

  @override
  List<Object?> get props => [id, type, number];
}
