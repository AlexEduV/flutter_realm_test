class ApiResponse<T> {
  final String status;
  final String message;
  final T? results;

  ApiResponse({required this.status, required this.message, this.results});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ApiResponse<T>(
      status: json['status'],
      message: json['message'],
      results: json['results'] != null ? fromJsonT(json['results']) : null,
    );
  }
}
