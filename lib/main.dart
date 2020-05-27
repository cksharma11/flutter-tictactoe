import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Board(),
    );
  }
}

class Board extends StatefulWidget {
  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  final Set<int> xMoves = Set<int>();
  final Set<int> oMoves = Set<int>();
  List<String> board = <String>["", "", "", "", "", "", "", "", "", ""];
  List<String> symbols = <String>["X", "O"];
  int currentPlayerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: _buildBoxes(),
    );
  }

  Widget _buildBoxes() {
    return GridButton(
      onPressed: (dynamic value) {
        print(value);
        setState(() {
          if (board[value] != "") return;

          currentPlayerIndex == 0 ? xMoves.add(value) : oMoves.add(value);
          board[value] = symbols[currentPlayerIndex];
          currentPlayerIndex = 1 - currentPlayerIndex;
        });
      },
      borderWidth: 5,
      textStyle: TextStyle(fontSize: 30),
      items: [
        [
          GridButtonItem(title: board[1], value: 1),
          GridButtonItem(title: board[2], value: 2),
          GridButtonItem(title: board[3], value: 3),
        ],
        [
          GridButtonItem(title: board[4], value: 4),
          GridButtonItem(title: board[5], value: 5),
          GridButtonItem(title: board[6], value: 6),
        ],
        [
          GridButtonItem(title: board[7], value: 7),
          GridButtonItem(title: board[8], value: 8),
          GridButtonItem(title: board[9], value: 9),
        ],
      ],
    );
  }
}
