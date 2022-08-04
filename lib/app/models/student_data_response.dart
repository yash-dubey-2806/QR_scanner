class StudentDataResponce {
  late bool isStudent;
  late String id;
  late String name;
  late String position;

  StudentDataResponce({
   required this.isStudent, 
   required this.id,required this.name,required this.position});

  StudentDataResponce.fromJson(Map<String, dynamic> json) {
    isStudent = json['isStudent'];
    id = json['id'];
    name = json['name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isStudent'] = this.isStudent;
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    return data;
  }
}
