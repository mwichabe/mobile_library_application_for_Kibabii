class UserModelOne{
  String? uid;
  String? school;
  String? programme;
  String? firstName;
  String? surName;
  String? registrationNumber;
  String? email;
  int? phoneNumber;

  UserModelOne({this.uid,this.school,this.programme,this.firstName,
    this.surName,this.registrationNumber,this.email,this.phoneNumber});
  // data from server
  factory UserModelOne.fromMap(map)
  {
    return UserModelOne(
        uid:  map['uid'],
        school: map['school'],
        programme: map['programme'],
        firstName: map['firstName'],
        surName: map['surName'],
        registrationNumber: map['registrationNumber'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
    );
  }
// sending data to server
  Map<String,dynamic> toMap()
  {
    return
      {
        'uid': uid,
        'school': school,
        'programme': programme,
        'firstName': firstName,
        'surName':surName,
        'registrationNumber': registrationNumber,
        'email':email,
        'phoneNumber': phoneNumber,
      };
  }
}
