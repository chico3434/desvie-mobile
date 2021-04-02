import 'package:flutter/material.dart';
import 'package:desvie/global.dart';
import 'package:desvie/screens/game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desvie'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sua pontuação'),
            Text('${Global.score}'),
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GameScreen(),
                  ),
                );
                setState(() {
                  Global.score = Global.score;
                });
              },
              child: Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
