import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/model/model.dart';

/// import control panel
import '../../control_panel/control_panels.dart';

/// use bloc to fecth data
import '../../../bloc/bloc.dart';

class ReservationBottomSheet extends StatefulWidget {
  final String userPhoneNumber;
  final Store store;
  const ReservationBottomSheet(
      {Key? key, required this.store, required this.userPhoneNumber})
      : super(key: key);

  @override
  _ReservationBottomSheetState createState() => _ReservationBottomSheetState();
}

class _ReservationBottomSheetState extends State<ReservationBottomSheet> {
  /// handle reserve button
  _handleReserveButtonOnTap(
      {required bool isReserved,
      required WashingMachine reservedWashingMachine}) {
    if (!isReserved) {
      /// emit event
      BlocProvider.of<WashingMachineBloc>(context).add(
        ReserveWashingMachineEvent(
          currentUserPhoneNumber: widget.userPhoneNumber,
          reservedWashingMachine: reservedWashingMachine,
        ),
      );
      Navigator.pop(context);

      /// show toast
      showCustomSnackbar(context: context, msg: '신청이 완료됐어요 😄');
    }
  }

  @override
  void initState() {
    super.initState();
    log(widget.store.storeUID, name: 'StoreBottomSheet');

    /// fetch washing machine data from server
    BlocProvider.of<WashingMachineBloc>(context)
        .add(GetStatsOfWashingMachineEvent(storeUID: widget.store.storeUID));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<WashingMachineBloc, WashingMachineState>(
        builder: (context, state) {
      if (state is WashingMachineEmpty) {
        return emptyWidget;
      } else if (state is WashingMachineLoading) {
        return loadingWidget;
      } else if (state is WashingMachineError) {
        log(state.msg, name: 'StoreBottomSheet');
        return errorWidget;
      } else if (state is WashingMachineLoaded) {
        final washingMachines = state.washingMachines;
        final reservedWashingMachine = state.reservedWashingMachine;
        log(reservedWashingMachine
            ?.getLeftDuration(DateTime.now())
            .toString() ?? 'none', name: 'StoreBottomSheet');
        if (reservedWashingMachine == null) {
          return Container(
            height: height,
            padding: paddingHV(16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// storename is displayed here
                Text(
                  widget.store.storeName,
                  style: titleTextStyle(),
                ),
                blankBoxH(height: 20),
                washingMachines.isNotEmpty
                    ? Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final isReserved = washingMachines[index]
                                .isWashingMachineReserved(
                                    DateTime.now());
                    
                            return ListTile(
                              title: Text(
                                '${index + 1} 번째 세탁기',
                                style: headlineTextStyle(),
                              ),
                    
                              /// emit event when the button is clicked
                              trailing: TextButton(
                                onPressed: () => _handleReserveButtonOnTap(
                                  isReserved: isReserved,
                                  reservedWashingMachine: washingMachines[index],
                                ),
                                child: Text(
                                  isReserved ? '사용중' : '신청',
                                  style: bodyTextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      isReserved ? secondaryColor : primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              blankBoxH(height: 10),
                          itemCount: washingMachines.length,
                        ),
                    )
                    : Expanded(
                        child: Center(
                          child: Text(
                            '아직 설치된 세탁기가 없어요 😭',
                            style: bodyTextStyle(),
                          ),
                        ),
                      )
              ],
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: paddingHV(24, 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: '이미 예약하신 내역이 있어요 😀\n\n\n',
                      style: bodyTextStyle(color: primaryColor)),
                  TextSpan(
                      text: '<예약한 내역 보는 방법>\n\n', style: headlineTextStyle()),
                  TextSpan(
                      text:
                          "'왼쪽에서 오른쪽 쓸기/왼쪽 상단 위 ☰ 누르기' \n>\n '예약 탭으로 가기' \n>\n '예약정보 확인'",
                      style: callOutTextStyle(color: primaryColor)),
                ]),
              ),
            ),
          );
        }
      }

      /// shouldn't be reached here
      return blankBoxH();
    });
  }
}
