import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:woomam/components/control_panel/control_panels.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  /// variables
  late ScrollController _scrollController;

  final _settingItems = [
    {
      'name': Text(
        '내 정보 변경',
        style: bodyTextStyle(),
      ),
      'leading': const Icon(FeatherIcons.user, color: primaryColor,)
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: paddingHV(24, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // blankBoxH(height: 60),
            /// title of the tap
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '설정',
                style: largeTitleTextStyle(),
              ),
            ),
    
            blankBoxH(height: 20),
    
            /// use [Expanded] to make it scrollable
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    leading: _settingItems[index]['leading'],
                    title: _settingItems[index]['name'],
                  ),
                  separatorBuilder: (context, index) => blankBoxH(height: 10),
                  itemCount: _settingItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
