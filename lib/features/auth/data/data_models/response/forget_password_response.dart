// features/auth/data/data_models/response/forget_password_response.dart
/// Model class representing the response from a forget password API.
class ForgetPasswordResponse {
  /// Message returned by the API, usually indicating success or failure.
  final String? message;

  /// Numeric status code returned by the API.
  final num? code;

  /// Additional info or description about the response.
  final String? info;

  /// Constructor for [ForgetPasswordResponse].
  const ForgetPasswordResponse({
    this.message,
    this.code,
    this.info,
  });

  /// Factory constructor to create an instance of [ForgetPasswordResponse] from JSON.
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      message: json['message'] as String?,
      code: json['code'] as num?,
      info: json['info'] as String?,
    );
  }

  /// Converts the [ForgetPasswordResponse] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'info': info,
    };
  }

  /// Creates a new instance of [ForgetPasswordResponse] with updated values.
  /// If a value is not provided, it retains the existing value.
  ForgetPasswordResponse copyWith({
    String? message,
    num? code,
    String? info,
  }) {
    return ForgetPasswordResponse(
      message: message ?? this.message,
      code: code ?? this.code,
      info: info ?? this.info,
    );
  }

  /// Returns a string representation of the [ForgetPasswordResponse] object.
  @override
  String toString() {
    return 'ForgetPasswordResponse(message: $message, code: $code, info: $info)';
  }

  /// Checks equality between two [ForgetPasswordResponse] objects.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ForgetPasswordResponse &&
        other.message == message &&
        other.code == code &&
        other.info == info;
  }

  /// Generates a hash code for the object, useful for collections like HashSet.
  @override
  int get hashCode => message.hashCode ^ code.hashCode ^ info.hashCode;
}
