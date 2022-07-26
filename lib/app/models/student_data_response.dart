// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

class StudentDataResponce {
late  bool isStudent;
late  Data data;

  StudentDataResponce({
    required this.isStudent,
    required this.data});

  StudentDataResponce.fromJson(Map<String, dynamic> json) {
    isStudent = json['isStudent'];
    data = (json['data'] != null ?  Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['isStudent'] = isStudent;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late String stdId;
  late String masterDataId;
  late String firstName;
  late String lastName;
  late String photo;
  late String currentYear;
  late String joinBatch;
  late String branch;
  late String isActive;
  late String ssismGroup;
  late var enrollmentNo;
  late String fathersName;
  late String dob;
  late int mobile;
  late int fatherContactNumber;
  late var email;
  late var schoolName;
  late var school12Sub;
  late var persentage12;
  late var rollNumber12;
  late var persentage10;
  late var rollNumber10;
  late int aadharNo;
  late var fatherOccupation;
  late var fatherIncome;
  late String category;
  late String gender;
  late String regBy;
  late var pincode;
  late String trackName;
  late var address;
  late String village;
  late var tehsil;
  late var district;
  late String createdBy;
  late var updatedBy;
  late String createdAt;
  late var updatedAt;

  Data(
      {required this.stdId,
      required this.masterDataId,
      required this.firstName,
      required this.lastName,
      required this.photo,
      required this.currentYear,
      required this.joinBatch,
      required this.branch,
      required this.isActive,
      required this.ssismGroup,
      required this.enrollmentNo,
      required this.fathersName,
      required this.dob,
      required this.mobile,
      required this.fatherContactNumber,
      required this.email,
      required this.schoolName,
      required this.school12Sub,
      required this.persentage12,
      required this.rollNumber12,
      required this.persentage10,
      required this.rollNumber10,
      required this.aadharNo,
      required this.fatherOccupation,
      required this.fatherIncome,
      required this.category,
      required this.gender,
      required this.regBy,
      required this.pincode,
      required this.trackName,
      required this.address,
      required this.village,
      required this.tehsil,
      required this.district,
      required this.createdBy,
      required this.updatedBy,
      required this.createdAt,
      required this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    stdId = json['stdId'];
    masterDataId = json['masterDataId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photo = json['photo'];
    currentYear = json['currentYear'];
    joinBatch = json['joinBatch'];
    branch = json['branch'];
    isActive = json['isActive'];
    ssismGroup = json['ssismGroup'];
    enrollmentNo = json['enrollmentNo'];
    fathersName = json['fathersName'];
    dob = json['dob'];
    mobile = json['mobile'];
    fatherContactNumber = json['fatherContactNumber'];
    email = json['email'];
    schoolName = json['schoolName'];
    school12Sub = json['school12Sub'];
    persentage12 = json['persentage12'];
    rollNumber12 = json['rollNumber12'];
    persentage10 = json['persentage10'];
    rollNumber10 = json['rollNumber10'];
    aadharNo = json['aadharNo'];
    fatherOccupation = json['fatherOccupation'];
    fatherIncome = json['fatherIncome'];
    category = json['category'];
    gender = json['gender'];
    regBy = json['regBy'];
    pincode = json['pincode'];
    trackName = json['trackName'];
    address = json['address'];
    village = json['village'];
    tehsil = json['tehsil'];
    district = json['district'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['stdId'] = stdId;
    data['masterDataId'] = masterDataId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['photo'] = photo;
    data['currentYear'] = currentYear;
    data['joinBatch'] = joinBatch;
    data['branch'] = branch;
    data['isActive'] = isActive;
    data['ssismGroup'] = ssismGroup;
    data['enrollmentNo'] = enrollmentNo;
    data['fathersName'] = fathersName;
    data['dob'] = dob;
    data['mobile'] = mobile;
    data['fatherContactNumber'] = fatherContactNumber;
    data['email'] = email;
    data['schoolName'] = schoolName;
    data['school12Sub'] = school12Sub;
    data['persentage12'] = persentage12;
    data['rollNumber12'] = rollNumber12;
    data['persentage10'] = persentage10;
    data['rollNumber10'] = rollNumber10;
    data['aadharNo'] = aadharNo;
    data['fatherOccupation'] = fatherOccupation;
    data['fatherIncome'] = fatherIncome;
    data['category'] = category;
    data['gender'] = gender;
    data['regBy'] = regBy;
    data['pincode'] = pincode;
    data['trackName'] = trackName;
    data['address'] = address;
    data['village'] = village;
    data['tehsil'] = tehsil;
    data['district'] = district;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
