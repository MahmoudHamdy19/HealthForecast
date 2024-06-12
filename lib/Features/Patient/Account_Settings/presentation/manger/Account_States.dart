
abstract class AccountStates {}

class GetAccountInitialState extends AccountStates {}
class GetAccountLoadingState extends AccountStates {}
class GetAccountSuccessState extends AccountStates {
  String? uId;
  GetAccountSuccessState(this.uId);
}
class GetAccountErrorState extends AccountStates {
   String? error;
  GetAccountErrorState(this.error);
}
