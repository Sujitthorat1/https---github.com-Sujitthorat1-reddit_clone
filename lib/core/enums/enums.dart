enum ThemeMode {
  light,
  dark,
}

class UserKarma {
  static const UserKarma comment = UserKarma(1);
  static const UserKarma textPost = UserKarma(2);
  static const UserKarma linkPost = UserKarma(3);
  static const UserKarma imagePost = UserKarma(3);
  static const UserKarma awardPost = UserKarma(5);
  static const UserKarma deletePost = UserKarma(-1);
  final int karma;
  const UserKarma(this.karma);
}
