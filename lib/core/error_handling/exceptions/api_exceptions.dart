// core/error_handling/exceptions/api_exceptions.dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic response;

  ApiException({
    required this.message,
    this.statusCode,
    this.response,
  });

/// Returns a string representation of the exception including the message, status code, and response.
  @override
  String toString() {
    return 'ApiException: $message (Status Code: $statusCode, Response: ${formattedResponse})';
  }

/// Returns a string representation of the response, or 'No response' if the response is null.
  String get formattedResponse {
    if (response is Map || response is List) {
      return response.toString();
    }
    return response?.toString() ?? 'No response';
  }

//add named factory method for common errors this makes it easier to create exceptions for specific cases 
  factory ApiException.networkError() {
    return ApiException(message: 'Network error occurred', statusCode: null);
  }

  factory ApiException.fromResponse(int statusCode, dynamic response) {
    return ApiException(
      message: 'API Error: ${response?['message'] ?? 'Unknown error'}',
      statusCode: statusCode,
      response: response,
    );
  }
}
