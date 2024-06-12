import 'package:flutter_bloc/flutter_bloc.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(TabsInitial());

  void changeTab(int index) {
    if (index == state.index) return;

    emit(TabChanged(index));
  }
}
