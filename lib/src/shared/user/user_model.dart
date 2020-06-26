import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;

  UserModel({this.email, this.id = 0, this.name});

  @override
  List<Object> get props => [id, name, email];
}
