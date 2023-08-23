class UserInfo {
  String id = '';
  String fname = '';
  String lname = '';
  DateTime dateOfBirth = DateTime(0, 0, 0);

  UserInfo(String id, String fname, String lname, DateTime dateOfBirth) {
    this.id = id;
    this.fname = fname;
    this.lname = lname;
    this.dateOfBirth = dateOfBirth;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname, 
      'lname': lname, 
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }

  UserInfo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fname = map['fname'];
    lname = map['lname'];
    dateOfBirth = DateTime.parse(map['dateOfBirth']);
  }
}
