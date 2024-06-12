
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Account_States.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit() : super(GetAccountInitialState());

  static AccountCubit get(context) {
    return BlocProvider.of(context);
  }

}
