
abstract class MedicalStates {}

class MedicalInitialState extends MedicalStates {}
class MedicalLoadingState extends MedicalStates {}
class MedicalSuccessState extends MedicalStates {}
class MedicalErrorState extends MedicalStates {}

class MedicalLoadModelLoadingState extends MedicalStates {}
class MedicalLoadModelSuccessState extends MedicalStates {}
class MedicalLoadModelErrorState extends MedicalStates {}

class MedicalClassifyModelLoadingState extends MedicalStates {}
class MedicalClassifyModelSuccessState extends MedicalStates {}
class MedicalClassifyModelErrorState extends MedicalStates {}