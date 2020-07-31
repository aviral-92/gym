class OauthToken {
  final String username;
  final String password;
  final String grantType;
  String clientId;
  String clientSecret;

  OauthToken(this.username, this.password, this.grantType);

  void setClientId(String clientId) {
    this.clientId = clientId;
  }

  String get getClientId {
    return this.clientId;
  }

  void setClientSecret(String secret) {
    this.clientSecret = secret;
  }

  String get getClientSecret {
    return this.clientSecret;
  }

  factory OauthToken.fromMap(Map<String, dynamic> json) {
    return OauthToken(
      json['username'],
      json['password'],
      json['grant_type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'grant_type': grantType,
      'username': username,
      'password': password,
    };
  }
}
