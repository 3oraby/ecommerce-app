import 'dart:async';
import 'package:e_commerce_app/core/helpers/functions/check_connection_with_internet.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/widgets/custom_trigger_button.dart';
import 'package:e_commerce_app/core/widgets/vertical_gap.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CustomNoInternetConnectionBody extends StatefulWidget {
  const CustomNoInternetConnectionBody({
    super.key,
    required this.onTryAgainPressed,
  });

  final VoidCallback? onTryAgainPressed;

  @override
  State<CustomNoInternetConnectionBody> createState() =>
      _CustomNoInternetConnectionBodyState();
}

class _CustomNoInternetConnectionBodyState
    extends State<CustomNoInternetConnectionBody> {
  bool _isChecking = false;
  String _statusMessage =
      "Oops! It looks like you're offline. Please check your internet connection.";

  Future<void> _checkConnection() async {
    setState(() {
      _isChecking = true;
      _statusMessage = "Checking connection...";
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (await checkConnectionWithInternet()) {
      widget.onTryAgainPressed?.call();
    } else {
      setState(() {
        _isChecking = false;
        _statusMessage =
            "Oops! It looks like you're offline. Please check your internet connection.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        padding: LocalConstants.internalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalGap(20),
            Text(
              _statusMessage,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/images/no_internet.png'),
            const VerticalGap(20),
            CustomTriggerButton(
              description: _isChecking ? "Checking..." : "Try Again",
              buttonWidth: (MediaQuery.of(context).size.width -
                      (2 * LocalConstants.kHorizontalPadding)) *
                  0.5,
              buttonHeight: 50,
              onPressed: _isChecking
                  ? null
                  : _checkConnection,
            ),
          ],
        ),
      ),
    );
  }
}
