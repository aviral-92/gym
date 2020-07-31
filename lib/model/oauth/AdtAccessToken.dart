class AdtAccessToken {
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final int expiresIn;
  final String scope;
  final String jti;

  AdtAccessToken(this.accessToken, this.tokenType, this.refreshToken,
      this.expiresIn, this.scope, this.jti);

  factory AdtAccessToken.fromMap(Map<String, dynamic> json) {
    return AdtAccessToken(
      json['access_token'],
      json['token_type'],
      json['refresh_token'],
      json['expires_in'],
      json['scope'],
      json['jti'],
    );
  }
}
