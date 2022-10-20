import 'package:equatable/equatable.dart';

class UserFilter extends Equatable {
  int userId;
  String name;
  bool isStructure;
  UserFilter(
      {required this.userId, required this.name, required this.isStructure});

  @override
  List<Object?> get props => [userId, name, isStructure];
}
