class AdtUsers {
  int id;
  String name;
  final String userName;
  final String password;
  List<String> authorties;
  String mobile;
  int enabled;

  AdtUsers(this.name, this.userName, this.password, this.authorties,
      this.mobile, this.enabled);

  factory AdtUsers.fromMap(Map<dynamic, dynamic> json) {
    //print('json===> ${json['authorties'] == null}');
    return AdtUsers(
      //json['id'],
      json['name'],
      json['userName'],
      json['password'],
      json['authorties'],
      json['mobile'],
      json['enabled'],
      //json['userId'],
    );
  }

  Map toJson() => {
        'name': name,
        'userName': userName,
        'password': password,
        'enabled': enabled,
        //'authorties': authorties,
        'mobile': mobile,
      };
}
