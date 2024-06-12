import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:healthforecast/Features/Admin/AddItemsScreen/presentation/view/setting_screen.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Core/Utils/Core Components.dart';

import '../../../AdminMedicationScreen/presentation/view/AdminMedicationScreen.dart';
import '../../../AdminArticlesScreen/presentation/view/AdminArticlesScreen.dart';
import '../manger/tabs_cubit.dart';

class TabsAdminScreen extends StatelessWidget {
  const TabsAdminScreen({super.key});

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
                AdminArticlesScreen(),
                AdminMedicationScreen(),
                SettingScreen(),
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
                  label: 'Articles',
                  icon: Icons.article_outlined,
                  coloredIcon: Iconsax.home1,
                ),
                CustomBottomNavigationBarItem(
                  selected: state.index == 1,
                  label: 'Medication',
                  icon: Icons.medication_liquid_sharp,
                  coloredIcon: Iconsax.activity5,
                ),
                CustomBottomNavigationBarItem(
                  selected: state.index == 2,
                  label: 'Settings',
                  icon: Icons.settings,
                  coloredIcon: Iconsax.activity5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
