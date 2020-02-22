import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserLogin extends Equatable {
  final String email;
  final String token;

  UserLogin({
    @required this.email,
    @required this.token
  }) : super([email, token]);
}