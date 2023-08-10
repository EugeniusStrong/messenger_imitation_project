import 'dart:convert';

class PersonModel {
  List<Result> results;

  PersonModel({required this.results});

  factory PersonModel.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List<dynamic> resultsJson = json['results'];
    final List<Result> resultsList =
        resultsJson.map((result) => Result.fromJson(result)).toList();
    return PersonModel(results: resultsList);
  }
}

class Result {
  String gender;
  Name name;
  String email;
  String phone;
  String cell;
  Picture picture;
  String nat;
  MessageModel message;

  Result({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.nat,
    required List<String> messages,
  }) : message =
            MessageModel(messages: messages, receivingTime: DateTime.now());

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      gender: json['gender'],
      name: Name.fromJson(json['name']),
      email: json['email'],
      phone: json['phone'],
      cell: json['cell'],
      picture: Picture.fromJson(json['picture']),
      nat: json['nat'],
      messages: [],
    );
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({required this.title, required this.first, required this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class Picture {
  String large;
  String medium;
  String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}

class MessageModel {
  String? id;
  List<String> messages;
  DateTime receivingTime;

  MessageModel({
    this.id,
    required this.messages,
    required this.receivingTime,
  });

  MessageModel copyWith({
    String? id,
    List<String>? messages,
    DateTime? receivingTime,
  }) {
    return MessageModel(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      receivingTime: receivingTime ?? this.receivingTime,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      messages: List<String>.from(map['messages']),
      receivingTime: DateTime.parse(map['receivingTime']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messages': messages,
      'receivingTime': receivingTime.toIso8601String(),
    };
  }
}
