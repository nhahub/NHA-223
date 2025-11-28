class RemoveFavResponse {
  final String status;
  final String message;
  final List<String> data;

  RemoveFavResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RemoveFavResponse.fromJson(Map<String, dynamic> json) {
    return RemoveFavResponse(
      status: json['status'],
      message: json['message'],
      data: List<String>.from(json['data']),
    );
  }
}
