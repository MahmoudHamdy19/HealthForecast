class DiagnoseModel {
  String label;
  int neg;
  int pos;
  DiagnoseModel({required this.label, required this.neg, required this.pos});

  factory DiagnoseModel.fromJson(Map<String, dynamic> json) {
    return DiagnoseModel(
      label: json['label'],
      neg: json['neg'],
      pos: json['pos'],
     );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['label'] = label;
    data['neg'] = neg;
    data['pos'] = pos;
    return data;
  }
}


class DiagnoseRequest{
   List<double> answers;
   String baseURl ;
   bool isDiabetes;

   DiagnoseRequest({required this.answers, required this.baseURl ,required this.isDiabetes});

   toMap() {
     final Map<String, dynamic> data =   <String, dynamic>{};
     data['answer'] = answers;
     return data;
   }
}