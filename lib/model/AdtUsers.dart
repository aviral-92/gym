class AdtUsers {
  int id;
  String name;
  final String userName;
  final String password;
  final List<String> authorties;
  final String mobile;
  int enabled;

  AdtUsers(this.name, this.userName, this.password, this.authorties,
      this.mobile, this.enabled);

  factory AdtUsers.fromMap(Map<dynamic, dynamic> json) {
    return AdtUsers(
      json['name'],
      json['userName'],
      json['password'],
      json['authorties'],
      json['mobile'],
      json['enabled'],
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

  @override
  String toString() =>
      '{name:$name, userName:$userName, password:$password, authorties:$authorties, mobile:$mobile, enabled:$enabled}';
}
