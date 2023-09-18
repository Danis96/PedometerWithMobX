class ApiResponse<T> {
  ApiResponse.loading(this.message) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

  Status status;
  T? data;
  String? message;

  @override
  String toString() {
    return 'Status: $status \n Message : $message \n Data: $data';
  }
}

enum Status { loading, completed, error }
