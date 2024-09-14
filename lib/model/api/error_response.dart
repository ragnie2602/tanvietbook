class ErrorResponse {
  String? status;
  ErrorResponse({this.status});
  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}
