import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:healthforecast/Features/Patient/Medical_Records/presentation/view/Reports.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Core/Utils/Core Components.dart';
import '../../../Account_Settings/presentation/view/account_screen.dart';
import 'MedicalRecordsScreen.dart';
import '../../../Medicine_screen/presentation/view/MedicineScreen.dart';
import '../manger/tabs_cubit.dart';
import 'home_view.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TabsCubit()),
      ],
      child: BlocBuilder<TabsCubit, TabsState>(
        builder: (context, state) {
          return Scaffold(
            body: LazyIndexedStack(
              index: state.index,
              children: const [
                HomeScreen(),
                ReportsScreen(),
                AccountScreen(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              selectedIndex: state.index,
              onTap: (index) {
                context.read<TabsCubit>().changeTab(index);
              },
              items: [
                CustomBottomNavigationBarItem(
                  selected: state.index == 0,
                  label: 'Home',
                  icon: Iconsax.home,
                  coloredIcon: Iconsax.home1,
                ),
                CustomBottomNavigationBarItem(
                  selected: state.index == 1,
                  label: 'Medical Articles',
                  icon: Iconsax.activity,
                  coloredIcon: Iconsax.activity5,
                ),

                CustomBottomNavigationBarItem(
                  selected: state.index == 2,
                  label: 'Settings',
                  icon: Iconsax.setting,
                  coloredIcon: Iconsax.setting5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
