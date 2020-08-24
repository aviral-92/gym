class AdtUsers {
  int id;
  String name;
  final String userName;
  final String password;
  final List<String> authorties;
  String mobile;
  int enabled;

  AdtUsers(this.name, this.userName, this.password, this.authorties,
      this.mobile, this.enabled);

  factory AdtUsers.fromMap(Map<String, dynamic> json) {
    return AdtUsers(
      //json['id'],
      json['name'],
      json['userName'],
      json['password'],
      json['mobile'],
      json['authorties'],
      json['enabled'],
      //json['userId'],
    );
  }

  Map toJson() => {
        'name': name,
        'userName': userName,
        'password': password,
        'enabled': enabled,
        'authorties': authorties,
        'mobile': mobile,
      };
}
