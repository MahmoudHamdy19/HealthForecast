part of 'patient_diagnosis_cubit.dart';

abstract class PatientDiagnosisState {
  final int index;

  const PatientDiagnosisState({required this.index});
}

class PatientDiagnosisInitial extends PatientDiagnosisState {
  PatientDiagnosisInitial() : super(index: 0);
}

class TabChanged extends PatientDiagnosisState {
  const TabChanged(int index) : super(index: index);
}