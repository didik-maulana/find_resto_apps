import 'package:find_resto/presentation/home/home_bloc.dart';
import 'package:find_resto/presentation/list/restaurant_list_screen.dart';
import 'package:find_resto/presentation/profile/profile_screen.dart';
import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.tabSelectedStream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final tabSelected = snapshot.data;

        return Scaffold(
          body: IndexedStack(
            children: [
              RestaurantListScreen(),
              ProfileScreen(),
            ],
            index: tabSelected,
          ),
          bottomNavigationBar: _buildBottomNavigationBar(tabSelected),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(int tabSelected) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          title: Text('Restaurant'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: tabSelected,
      unselectedItemColor: ColorPalette.gray400,
      selectedItemColor: ColorPalette.islamicGreen,
      showUnselectedLabels: false,
      onTap: (index) {
        bloc.setTabSelected(index);
      },
    );
  }
}
