import 'package:flutter/material.dart';

import '../../components.dart';
import 'home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// builds under the [Scaffold's body]
  @override
  Widget build(BuildContext context) {
    return Stack(
      /// display search bar at the top
      /// and then display map at the behind of search bar
      children: [
        /// map 
        Container(
          color: backgroundColor,
        ),
        /// search bar
        HomeSearchBar(
          onSeachButtonTapped: () {},
        ),
      ],
    );
  }
}
