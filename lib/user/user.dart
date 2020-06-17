import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:email_validator/email_validator.dart';

part 'user_repo.dart';
part 'user_service.dart';

class User {
  final int id;

  User({
    @required this.id,
  }) : assert(id != null);
}
