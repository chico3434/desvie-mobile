import 'package:flutter/material.dart';
import 'package:desvie/global.dart';
import 'package:desvie/screens/game_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;
  int record;

  @override
  void initState() {
    _getRecord();
    super.initState();
  }

  _getRecord() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      record = prefs.getInt('record') ?? 0;
    });
  }

  _saveRecord() async {
    await prefs.setInt('record', record);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desvie'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text('Seu record'),
                      Text(
                        '$record',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text('Sua pontuação'),
                    Text(
                      '${Global.score}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GameScreen(),
                  ),
                );
                setState(() {
                  if (record < Global.score) {
                    setState(() {
                      record = Global.score;
                    });
                    _saveRecord();
                  }
                });
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Iniciar')),
            ),
          ],
        ),
      ),
    );
  }
}
