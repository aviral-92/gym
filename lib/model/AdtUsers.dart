class AdtUsers {
  int id;
  final String userName;
  final String password;
  final List<String> authorties;
  int enabled;

  AdtUsers(this.userName, this.password, this.authorties, this.enabled);

  Map toJson() => {
        //'id': id,
        'userName': userName,
        'password': password,
        'enabled': enabled,
        'authorties': authorties,
      };
}
