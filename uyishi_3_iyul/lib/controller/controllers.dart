import 'package:uyishi_3_iyul/models/models.dart';

class UserController {
  User user;

  UserController(this.user);

  void updateUser(
      String name, String surname, String phoneNumber, String imageUrl) {
    user.name = name;
    user.surname = surname;
    user.phoneNumber = phoneNumber;
    user.imageUrl = imageUrl;
  }
}
