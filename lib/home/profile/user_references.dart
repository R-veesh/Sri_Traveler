import 'package:sri_traveler/home/profile/user.dart';

class UserReferences {
  static User myUser = User(
    imagePath: 'assets/5-250x250.jpg',
    name: 'Raveesha',
    email: 'test@gmail.com',
    bio: 'I’m an astronaut and traveler!',
    isDarkMode: false,
  );

  static void updateUser(User updatedUser) {
    myUser = updatedUser;
  }
}
