class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  Result._(this.data, this.error, this.isSuccess);

  factory Result.success(T data) => Result._(data, null, true);

  factory Result.failure(String error) => Result._(null, error, false);
}
