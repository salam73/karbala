import 'package:equatable/equatable.dart';

class Mohmmad extends Equatable {
  const Mohmmad({
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

  Mohmmad copyWith({
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
    return Mohmmad(
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

  factory Mohmmad.fromJson(Map<String, dynamic> json) {
    return Mohmmad(
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
    required this.pic,
    required this.video,
    required this.category,
    required this.date,
    required this.description,
    required this.number,
    required this.pdf,
    required this.title,
  });

  final Pic? pic;
  final Pdf? video;
  final Category? category;
  final PropertiesDate? date;
  final Description? description;
  final Number? number;
  final Pdf? pdf;
  final Title? title;

  Properties copyWith({
    Pic? pic,
    Pdf? video,
    Category? category,
    PropertiesDate? date,
    Description? description,
    Number? number,
    Pdf? pdf,
    Title? title,
  }) {
    return Properties(
      pic: pic ?? this.pic,
      video: video ?? this.video,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      number: number ?? this.number,
      pdf: pdf ?? this.pdf,
      title: title ?? this.title,
    );
  }

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      pic: json["pic"] == null ? null : Pic.fromJson(json["pic"]),
      video: json["video"] == null ? null : Pdf.fromJson(json["video"]),
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      date: json["date"] == null ? null : PropertiesDate.fromJson(json["date"]),
      description:
          json["description"] == null
              ? null
              : Description.fromJson(json["description"]),
      number: json["number"] == null ? null : Number.fromJson(json["number"]),
      pdf: json["pdf"] == null ? null : Pdf.fromJson(json["pdf"]),
      title: json["title"] == null ? null : Title.fromJson(json["title"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "pic": pic?.toJson(),
    "video": video?.toJson(),
    "category": category?.toJson(),
    "date": date?.toJson(),
    "description": description?.toJson(),
    "number": number?.toJson(),
    "pdf": pdf?.toJson(),
    "title": title?.toJson(),
  };

  @override
  List<Object?> get props => [
    pic,
    video,
    category,
    date,
    description,
    number,
    pdf,
    title,
  ];
}

class Category extends Equatable {
  const Category({required this.id, required this.type, required this.select});

  final String id;
  final String type;
  final Select? select;

  Category copyWith({String? id, String? type, Select? select}) {
    return Category(
      id: id ?? this.id,
      type: type ?? this.type,
      select: select ?? this.select,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
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

class PropertiesDate extends Equatable {
  const PropertiesDate({
    required this.id,
    required this.type,
    required this.date,
  });

  final String id;
  final String type;
  final DateDate? date;

  PropertiesDate copyWith({String? id, String? type, DateDate? date}) {
    return PropertiesDate(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  factory PropertiesDate.fromJson(Map<String, dynamic> json) {
    return PropertiesDate(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      date: json["date"] == null ? null : DateDate.fromJson(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "date": date?.toJson(),
  };

  @override
  List<Object?> get props => [id, type, date];
}

class DateDate extends Equatable {
  const DateDate({
    required this.start,
    required this.end,
    required this.timeZone,
  });

  final DateTime? start;
  final dynamic end;
  final dynamic timeZone;

  DateDate copyWith({DateTime? start, dynamic end, dynamic timeZone}) {
    return DateDate(
      start: start ?? this.start,
      end: end ?? this.end,
      timeZone: timeZone ?? this.timeZone,
    );
  }

  factory DateDate.fromJson(Map<String, dynamic> json) {
    return DateDate(
      start: DateTime.tryParse(json["start"] ?? ""),
      end: json["end"],
      timeZone: json["time_zone"],
    );
  }

  Map<String, dynamic> toJson() => {
    "start":
        start != null
            ? "${start?.year.toString().padLeft(4, '0')}-${start?.month.toString().padLeft(2, '0')}-${start?.day.toString().padLeft(2, '0')}"
            : null,
    "end": end,
    "time_zone": timeZone,
  };

  @override
  List<Object?> get props => [start, end, timeZone];
}

class Description extends Equatable {
  const Description({
    required this.id,
    required this.type,
    required this.richText,
  });

  final String id;
  final String type;
  final List<RichText> richText;

  Description copyWith({String? id, String? type, List<RichText>? richText}) {
    return Description(
      id: id ?? this.id,
      type: type ?? this.type,
      richText: richText ?? this.richText,
    );
  }

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
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
    dynamic href,
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

  Text copyWith({String? content, dynamic link}) {
    return Text(content: content ?? this.content, link: link ?? this.link);
  }

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(content: json["content"] ?? "", link: json["link"]);
  }

  Map<String, dynamic> toJson() => {"content": content, "link": link};

  @override
  List<Object?> get props => [content, link];
}

class Number extends Equatable {
  const Number({required this.id, required this.type, required this.number});

  final String id;
  final String type;
  final int number;

  Number copyWith({String? id, String? type, int? number}) {
    return Number(
      id: id ?? this.id,
      type: type ?? this.type,
      number: number ?? this.number,
    );
  }

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      number: json["number"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "type": type, "number": number};

  @override
  List<Object?> get props => [id, type, number];
}

class Pdf extends Equatable {
  const Pdf({required this.id, required this.type, required this.files});

  final String id;
  final String type;
  final List<PdfFile> files;

  Pdf copyWith({String? id, String? type, List<PdfFile>? files}) {
    return Pdf(
      id: id ?? this.id,
      type: type ?? this.type,
      files: files ?? this.files,
    );
  }

  factory Pdf.fromJson(Map<String, dynamic> json) {
    return Pdf(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      files:
          json["files"] == null
              ? []
              : List<PdfFile>.from(
                json["files"].map((x) => PdfFile.fromJson(x)),
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

class PdfFile extends Equatable {
  const PdfFile({required this.name, required this.type, required this.file});

  final String name;
  final String type;
  final FileFile? file;

  PdfFile copyWith({String? name, String? type, FileFile? file}) {
    return PdfFile(
      name: name ?? this.name,
      type: type ?? this.type,
      file: file ?? this.file,
    );
  }

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
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

class External extends Equatable {
  const External({required this.url});

  final String url;

  External copyWith({String? url}) {
    return External(url: url ?? this.url);
  }

  factory External.fromJson(Map<String, dynamic> json) {
    return External(url: json["url"] ?? "");
  }

  Map<String, dynamic> toJson() => {"url": url};

  @override
  List<Object?> get props => [url];
}

class Pic extends Equatable {
  const Pic({required this.id, required this.type, required this.files});

  final String id;
  final String type;
  final List<PicFile> files;

  Pic copyWith({String? id, String? type, List<PicFile>? files}) {
    return Pic(
      id: id ?? this.id,
      type: type ?? this.type,
      files: files ?? this.files,
    );
  }

  factory Pic.fromJson(Map<String, dynamic> json) {
    return Pic(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      files:
          json["files"] == null
              ? []
              : List<PicFile>.from(
                json["files"]!.map((x) => PicFile.fromJson(x)),
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

class PicFile extends Equatable {
  const PicFile({required this.name, required this.type, required this.file});

  final String name;
  final String type;
  final FileFile? file;

  PicFile copyWith({String? name, String? type, FileFile? file}) {
    return PicFile(
      name: name ?? this.name,
      type: type ?? this.type,
      file: file ?? this.file,
    );
  }

  factory PicFile.fromJson(Map<String, dynamic> json) {
    return PicFile(
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

class Title extends Equatable {
  const Title({required this.id, required this.type, required this.title});

  final String id;
  final String type;
  final List<RichText> title;

  Title copyWith({String? id, String? type, List<RichText>? title}) {
    return Title(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
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
