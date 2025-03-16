class User {
  String imagePath;
  String name;
  String email;
  String bio;
  bool isDarkMode;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.bio,
    required this.isDarkMode,
  });

  User copyWith({
    String? imagePath,
    String? name,
    String? email,
    String? bio,
    bool? isDarkMode,
  }) {
    return User(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
