class UserProfile {
  final String name;
  final String phoneNumber;
  final String email;
  final String profileImage;

  UserProfile({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.profileImage = '',
  });

  factory UserProfile.defaultProfile() {
    return UserProfile(
      name: 'Ahmed Magdy',
      phoneNumber: '012-000-00-663',
      email: 'ahmed@paradigmegypt.com',
    );
  }
}

class MenuOption {
  final String title;
  final String icon;
  final bool hasArrow;
  final bool isDestructive;
  final bool? hasToggle;
  final bool? toggleValue;

  MenuOption({
    required this.title,
    required this.icon,
    this.hasArrow = true,
    this.isDestructive = false,
    this.hasToggle,
    this.toggleValue,
  });
}
