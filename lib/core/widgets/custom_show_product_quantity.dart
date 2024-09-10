
import 'package:flutter/material.dart';

class CustomShowProductQuantity extends StatelessWidget {
  const CustomShowProductQuantity({
    super.key,
    this.isShow = true,
    required this.quantity,
  });

  final bool isShow;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShow,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(360),
        ),
        child: Center(
          child: Text(
            "x $quantity",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
