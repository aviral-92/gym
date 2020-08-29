class AdtResponse {
  final String message;

  AdtResponse(this.message);

  factory AdtResponse.fromMap(Map<dynamic, dynamic> json) {
    return AdtResponse(
      json['message'],
    );
  }
}
