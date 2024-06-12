part of 'tabs_cubit.dart';

abstract class TabsState {
  final int index;

  const TabsState({required this.index});
}

class TabsInitial extends TabsState {
  TabsInitial() : super(index: 0);
}

class TabChanged extends TabsState {
  const TabChanged(int index) : super(index: index);
}
