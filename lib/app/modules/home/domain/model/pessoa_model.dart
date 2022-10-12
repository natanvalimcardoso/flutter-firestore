import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PessoaModel {
  final String id;
  final String name;
  final String email;
  final int age;
  PessoaModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'age': age,
    };
  }

  factory PessoaModel.fromMap(Map<String, dynamic> map) {
    return PessoaModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PessoaModel.fromJson(String source) => PessoaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PessoaModel(id: $id, name: $name, email: $email, age: $age)';
  }
}
