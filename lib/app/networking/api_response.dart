class ApiResponse<T> {
  late int status;
  late String error;
  late T data;

  ApiResponse(this.status, this.error, this.data);

  ApiResponse.empty();

  ApiResponse.fromJson(Map<String, dynamic> json) {
    //print(json);
    error = json['error'];
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['data'] = data;
    return data;
  }

  @override
  String toString() {
    return "$error";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
