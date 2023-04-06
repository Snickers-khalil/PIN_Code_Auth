import 'package:android_test_task_master/buiznes/authentication_pin_bloc.dart';
import 'package:android_test_task_master/data/pin_repository.dart';
import 'package:android_test_task_master/ui/home_page.dart';
import 'package:android_test_task_master/ui/widget/button_of_numpad.dart';
import 'package:android_test_task_master/ui/widget/pin_sphere.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPIN extends StatelessWidget {
  static const String setupPIN = "Setup PIN";
  static const String useSixDigitsPIN = "Use 6-digits PIN";
  static const String authenticationSuccess = "Authentication success";
  static const String authenticationFailed = "Authentication failed";

  //static const String ok = "OK";

  const AuthenticationPIN({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (_) =>
              AuthenticationPinBloc(pinRepository: HivePINRepository()),
          child: BlocListener<AuthenticationPinBloc, AuthenticationPinState>(
            listener: (context, state) {
              if (state.pinStatus == AuthenticationPINStatus.equals) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Text(authenticationSuccess),
                    actionsAlignment: MainAxisAlignment.center,
                  ),
                );
                Future.delayed(
                  const Duration(seconds: 2),
                  () => Navigator.pushAndRemoveUntil(
                      context, Home.route(), (_) => false),
                );
              } else if (state.pinStatus == AuthenticationPINStatus.unequals) {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          title: Text(authenticationFailed),
                          actionsAlignment: MainAxisAlignment.center,
                        ));
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 2, child: _MainPart()),
                Expanded(flex: 3, child: _NumPad()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AuthenticationPIN());
  }
}

class _NumPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 0, 64, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "1",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 1)))),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "2",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 2)))),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "3",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 3)))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "4",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 4)))),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "5",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 5)))),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "6",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 6)))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: ButtonOfNumPad(
                        num: "7",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 7)))),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "8",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 8)))),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "9",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 9)))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(width: 64),
                Expanded(
                    child: ButtonOfNumPad(
                        num: "0",
                        onPressed: () =>
                            BlocProvider.of<AuthenticationPinBloc>(context).add(
                                const AuthenticationPinAddEvent(pinNum: 0)))),
                const SizedBox(width: 64),
                Expanded(
                    child: IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: () =>
                      BlocProvider.of<AuthenticationPinBloc>(context)
                          .add(const AuthenticationPinEraseEvent()),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MainPart extends StatelessWidget {
  static const String enterYourPIN = "Enter your PIN";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 0, 64, 0),
      child: BlocBuilder<AuthenticationPinBloc, AuthenticationPinState>(
        buildWhen: (previous, current) => previous.pin != current.pin,
        builder: (context, state) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Flexible(
              flex: 2,
              child: Text(enterYourPIN,
                  style: TextStyle(color: Color(0xFF687ea1), fontSize: 36)),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    4,
                    (index) =>
                        PinSphere(input: index < state.getCountsOfPIN())),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
