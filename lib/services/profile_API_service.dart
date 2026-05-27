import 'dart:math';

class ProfileApiService {
  static String generateRandomProfile() {
    final randomNumber = Random().nextInt(999999);

    return 'https://api.dicebear.com/7.x/adventurer/png?seed=$randomNumber';
  }
}