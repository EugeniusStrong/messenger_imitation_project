import 'dart:convert';
import 'package:uuid/uuid.dart';

class Result {
  List<Person> persons;

  Result({required this.persons});

  factory Result.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List<dynamic> personsJson = json['results'];
    final List<Person> personsList =
        personsJson.map((person) => Person.fromJson(person)).toList();
    return Result(persons: personsList);
  }
}

// TODO: Сделать переменные финальными.
class Person {
  String id;
  String gender;
  Name name;
  String email;
  String phone;
  String cell;
  Picture picture;
  String nat;


  Person({
    required this.id,
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.nat,

  });

  factory Person.fromJson(Map<String, dynamic> json) {
    const uuid = Uuid();
    String id = uuid.v4();
    return Person(
      id: id,
      gender: json['gender'],
      name: Name.fromJson(json['name']),
      email: json['email'],
      phone: json['phone'],
      cell: json['cell'],
      picture: Picture.fromJson(json['picture']),
      nat: json['nat'],

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


