import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_diagnosis_state.dart';

class PatientDiagnosisCubit extends Cubit<PatientDiagnosisState> {
  PatientDiagnosisCubit() : super(PatientDiagnosisInitial());

}