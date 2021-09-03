import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woomam/components/components.dart';
import 'package:woomam/model/washing_machine.dart';

class RunningWashingMachineScreen extends StatelessWidget {
  final WashingMachine washingMachine;
  const RunningWashingMachineScreen({Key? key, required this.washingMachine}) : super(key: key);

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
        child: SizedBox(
          width: width,
          height: height,
          child: Hero(
            tag: washingMachine.washingMachineUID,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  /// running
                  Align(
                    child: Text('Running...',
                        style: titleTextStyle(color: Colors.white)),
                  ),
                  blankBoxH(height:30),

                  /// flaticon of washing machine is here
                  SvgPicture.asset(
                    'images/washing-machine.svg',
                    width: width / 2,
                    height: width / 2,
                  ),
                  blankBoxH(height:30),

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
