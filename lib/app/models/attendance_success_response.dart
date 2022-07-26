class AttendanceSuccessResponse {
late  int stId;
 late String stdId;
  late String stream;
  late String date;
  late String inTime;
  late String outTime;
 late int isPresent;
  late String year;
  late String createdBy;
  late String updatedAt;
  late String createdAt;

  AttendanceSuccessResponse(
      {required this.stId,
      required this.stdId,
      required this.stream,
      required this.date,
      required this.inTime,
      required this.outTime,
      required this.isPresent,
      required this.year,
      required this.createdBy,
      required this.updatedAt,
      required this.createdAt});

  AttendanceSuccessResponse.fromJson(Map<String, dynamic> json) {
    stId = json['st_id'];
    stdId = json['stdId'];
    stream = json['stream'];
    date = json['date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    isPresent = json['is_present'];
    year = json['year'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['st_id'] = stId;
    data['stdId'] = stdId;
    data['stream'] = stream;
    data['date'] = date;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['is_present'] = isPresent;
    data['year'] = year;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
