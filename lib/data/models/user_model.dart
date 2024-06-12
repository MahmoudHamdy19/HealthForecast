class UserModel {
  String? email;
  String? name;
  String? uid;
  String? age;
  bool isAdmin = false;
  PersonalInfo? personalInfo = PersonalInfo();
  HealthInfo? healthInfo = HealthInfo();

  UserModel({this.email, this.name, this.uid, this.age,this.personalInfo,this.healthInfo});
  UserModel.fromJson(Map<String, dynamic>? json) {
    json = json??{};
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    age = json['age'];
    personalInfo = PersonalInfo.fromJson(json['personalInfo']);
    healthInfo = HealthInfo.fromJson(json['healthInfo']);
    isAdmin = json['isAdmin'] ?? false;
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'uid': uid,
      'age': age,
      'isAdmin': isAdmin,
      'personalInfo': personalInfo?.toJson(),
      'healthInfo': healthInfo?.toJson()
    };
  }
}

class PersonalInfo {
  String? name;
  String? idNumber;
  DateTime? dateOfBirth;
  PersonalInfo({this.name, this.idNumber, this.dateOfBirth});
  PersonalInfo.fromJson(Map<String, dynamic>? json) {
    json = json??{};
    name = json['name'];
    idNumber = json['idNumber'];
    dateOfBirth =json['dateOfBirth']!=null? DateTime.parse(json['dateOfBirth']):null;
  }

  toJson() {
    return {
      'name': name,
      'idNumber': idNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String()
    };
  }
}

class HealthInfo {
  String? bloodType;
  String? height;
  String? weight;
  String? medicalAllergies;
  String? medicalDiseases;
  HealthInfo({this.bloodType, this.height, this.weight,this.medicalAllergies,this.medicalDiseases});
  HealthInfo.fromJson(Map<String, dynamic>? json) {
    json = json??{};
    bloodType = json['bloodType'];
    height = json['height'];
    weight = json['weight'];
    medicalAllergies = json['medicalAllergies'];
    medicalDiseases = json['medicalDiseases'];
  }
  toJson() {
    return {
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'medicalAllergies': medicalAllergies,
      'medicalDiseases': medicalDiseases
    };
  }
}
