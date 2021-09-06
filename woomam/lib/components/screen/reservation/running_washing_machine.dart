import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:woomam/components/components.dart';
import 'package:woomam/model/washing_machine.dart';

class RunningWashingMachineScreen extends StatefulWidget {
  final WashingMachine washingMachine;
  const RunningWashingMachineScreen({Key? key, required this.washingMachine})
      : super(key: key);

  @override
  _RunningWashingMachineScreenState createState() =>
      _RunningWashingMachineScreenState();
}

class _RunningWashingMachineScreenState
    extends State<RunningWashingMachineScreen> {
  /// display timer
  late Timer _timer;
  var _time = 0;

  @override
  void initState() {
    super.initState();

    /// tick timer
    _timer = Timer.periodic(
        const Duration(seconds: 1), (timer) => setState(() => _time += 1));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var currentPercentage =
        widget.washingMachine.getPercentageOfProcess(DateTime.now());
    
    var leftTime = widget.washingMachine.taskFrom!.difference(DateTime.now()).inMinutes;
    var leftTimeInHour = leftTime > 60 ? leftTime ~/ 60 : 0;
    var leftTimeInMinute = leftTimeInHour > 0 ? leftTime - leftTimeInHour * 60 : leftTime;

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
            tag: widget.washingMachine.washingMachineUID,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  /// flaticon of washing machine is here
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      /// background
                      SvgPicture.asset(
                        'images/washing-machine.svg',
                        width: width / 2,
                        height: width / 2,
                      ),

                      /// liquidProgressIndicator
                      SizedBox(
                        width: width / 3,
                        height: width / 3,
                        child: LiquidCircularProgressIndicator(
                          value: currentPercentage,
                          valueColor:
                              const AlwaysStoppedAnimation(secondaryColor),
                          backgroundColor: backgroundColor,
                          borderWidth: 15.0,
                          borderColor: primaryColor,
                          direction: Axis.vertical,
                          center: Text(
                            '${(currentPercentage * 100).toStringAsFixed(2)}%',
                            style: headlineTextStyle(color: secondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  blankBoxH(height: 30),

                 Align(
                    child: Text('$leftTimeInHour시간 $leftTimeInMinute분 남았어요',
                        style: titleTextStyle(color: Colors.white)),
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
