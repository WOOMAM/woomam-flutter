import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../components.dart';

class HomeSearchBar extends StatefulWidget {
  final Function(String)? onQueryChanged;
  final void Function() onSeachButtonTapped;
  const HomeSearchBar({ Key? key , this.onQueryChanged, required this.onSeachButtonTapped}) : super(key: key);

  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {

  late FloatingSearchBarController _controller;

  @override
  void initState() { 
    super.initState();
    _controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
          /// settings
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          onQueryChanged: widget.onQueryChanged,
          hint: '가까운 지역명을 검색해보세요',

          /// style
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          borderRadius: BorderRadius.circular(20.0),
          openAxisAlignment: 0.0,
          iconColor: primaryColor,

          /// animations
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          transition: CircularFloatingSearchBarTransition(),
          debounceDelay: const Duration(milliseconds: 500),

          // Specify a custom transition to be used for
          // animating between opened and closed stated.
          actions: [
            FloatingSearchBarAction.icon(
              icon: const Icon(FeatherIcons.search),
              onTap: widget.onSeachButtonTapped,
              showIfOpened: false,
            ),
            FloatingSearchBarAction.icon(
              icon: const Icon(FeatherIcons.xCircle),
              onTap: () => _controller.clear(),
              showIfOpened: true,
              showIfClosed: false,
            )
          ],
          
          /// leading for back tap
          leadingActions: [
            FloatingSearchBarAction.icon(
              icon: const Icon(FeatherIcons.chevronLeft),
              onTap: () => _controller.close(),
              showIfOpened: true,
              showIfClosed: false,
            )
          ],

          /// suggestions
          builder: (context, transition) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: Colors.accents.map((color) {
                  return Container(height: 112, color: color);
                }).toList(),
              ),
            ),
          ),
        );
  }
}