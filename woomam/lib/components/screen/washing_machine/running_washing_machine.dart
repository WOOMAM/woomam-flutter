import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woomam/components/components.dart';

class RunningWashingMachineScreen extends StatelessWidget {
  const RunningWashingMachineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '작동중',
          style: titleTextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Hero(
          tag: 'washing-machine-hero-animation',
          child: Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  /// running
                  Align(
                    child: Text('Running...',
                        style: titleTextStyle(color: Colors.white)),
                  ),
                  blankBoxH(30),

                  /// flaticon of washing machine is here
                  SvgPicture.asset(
                    'images/washing-machine.svg',
                    width: width / 2,
                    height: width / 2,
                  ),
                  blankBoxH(30),

                  /// percentage
                  Align(
                    child: Text(
                      '89%',
                      style: largeTitleTextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
