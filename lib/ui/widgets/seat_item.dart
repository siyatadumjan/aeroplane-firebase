
import 'package:flutter/material.dart';
import 'package:aeroplane/shared/theme.dart';

class SeatItem extends StatelessWidget {
  final int status;
  final VoidCallback onTap;

  const SeatItem({Key? key, required this.status, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor() {
      switch (status) {
        case 0:
          return kAvailableColor;
        case 1:
          return kPrimaryColor;
        case 2:
          return kUnavailableColor;
        default:
          return kUnavailableColor;
      }
    }

    Color borderColor() {
      switch (status) {
        case 0:
          return kPrimaryColor;
        case 1:
          return kPrimaryColor;
        case 2:
          return kUnavailableColor;
        default:
          return kUnavailableColor;
      }
    }

    Widget child() {
      switch (status) {
        case 0:
          return SizedBox();
        case 1:
          return Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          );
        case 2:
          return SizedBox();
        default:
          return SizedBox();
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.symmetric(vertical: 4), // Add margin to maintain space between seats
            decoration: BoxDecoration(
              color: backgroundColor(),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor(), width: 2),
            ),
            child: child(),
          ),
          Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.symmetric(vertical: 4), // Add margin to maintain space between seats
            decoration: BoxDecoration(
              color: backgroundColor(),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor(), width: 2),
            ),
            child: child(),
          ),
          SizedBox(width: 16), // Add space between seats (horizontal
        ],
      ),
    );
  }
}
