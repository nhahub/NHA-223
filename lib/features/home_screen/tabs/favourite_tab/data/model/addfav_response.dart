class AddFavResponse {
  final String status;
  final String message;
  final List<String> data;

  AddFavResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddFavResponse.fromJson(Map<String, dynamic> json) {
    return AddFavResponse(
      status: json['status'],
      message: json['message'],
      data: List<String>.from(json['data']),
    );
  }
}
