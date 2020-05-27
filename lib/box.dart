import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box({@required this.onTap, @required this.symbol});

  final Function onTap;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
      ),
      child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              symbol,
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          )),
    );
  }
}
