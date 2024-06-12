import 'package:healthforecast/data/models/diegnose_model.dart';

class MedicalRecord {
    String? recordId;
    DiagnoseModel? diagnose;
    String? title;
     DateTime? date;

  MedicalRecord({
     this.recordId,
     required this.title,
    required this.diagnose,
    required this.date,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      recordId: json['recordId'],
       title: json['title'],
      diagnose: DiagnoseModel.fromJson(json['diagnose']),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recordId': recordId,
       'title': title,
       'date': date?.toIso8601String(),
      'diagnose': diagnose?.toJson(),

    };
  }
}