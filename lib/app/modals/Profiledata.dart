class ProfileState {
  String? name;
  String? email;
  String? education;
  String? experience;
  String? skills;
  String? address;
  String? github;
  ProfileState(
      {this.name,
      this.education,
      this.experience,
      this.address,
      this.github,
      this.skills});

  ProfileState.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['Name'];

    skills = json['Skills'];
    experience = json['Experience'];
    address = json['Address'];
    github = json['Github'];
  }
}
