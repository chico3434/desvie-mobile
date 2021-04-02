import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:desvie/global.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Space space = new Space();
  Player player = Player(x: 100, y: 100);
  var random = math.Random();

  List<Enemy> enemies = [];

  @override
  void initState() {
    Global.score = 0;
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    )..repeat();
    _animation = new Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0)
            player.dx = 1;
          else
            player.dx = -1;

          if (details.delta.dy > 0)
            player.dy = 1;
          else
            player.dy = -1;
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext contex, Widget child) {
            if (space.end) {
              _controller.dispose();
              Navigator.pop(context);
            }
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: MyGame(space, player, enemies),
              child: Stack(
                children: [
                  for (int i = 0; i < 20; i++)
                    Positioned(
                      top: random.nextDouble() *
                          MediaQuery.of(context).size.height,
                      left: random.nextDouble() *
                          MediaQuery.of(context).size.width,
                      child: SizedBox(
                        width: 3,
                        height: 3,
                        child: ColoredBox(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Space {
  bool end = false;
  void render(Canvas canvas) {
    canvas.drawPaint(new Paint()..color = new Color(0xff111111));
    canvas.save();
    canvas.restore();
  }
}

class Player {
  double x;
  double y;
  double speed = 2;
  double dx = 0;
  double dy = 0;
  double size = 20;

  Player({this.x, this.y});

  void render(Canvas canvas) {
    var color = new Paint()..color = new Color(0xffffff00);
    canvas.drawRect(new Rect.fromLTWH(x, y, size, size), color);
  }

  moveX() {
    x += dx * speed;
  }

  moveY() {
    y += dy * speed;
  }

  void update(Size size) {
    if (dx > 0) {
      if ((x + this.size) < size.width) {
        moveX();
      }
    } else {
      if ((x) > 0) {
        moveX();
      }
    }

    if (dy > 0) {
      if ((y + this.size) < size.height) {
        moveY();
      }
    } else {
      if ((y) > 0) {
        moveY();
      }
    }
  }
}

class Enemy {
  double x;
  double y;
  double speed = 2;
  double size = 20;
  bool alive = true;

  Enemy({this.x, this.y});

  void render(Canvas canvas) {
    var color = new Paint()..color = new Color(0xffff0000);
    canvas.drawRect(new Rect.fromLTWH(x, y, size, size), color);
  }

  moveY() {
    y += -1 * speed;
  }

  void toDie() {
    print('Inimigo morto');
    alive = false;
  }

  void update(Size size) {
    if ((y - this.size) > 0) {
      moveY();
    } else {
      toDie();
    }
  }
}

class MyGame extends CustomPainter {
  final Space world;
  final Player player;
  final List<Enemy> enemies;
  final random = new math.Random();

  MyGame(this.world, this.player, this.enemies);

  @override
  void paint(Canvas canvas, Size size) {
    if (checkCollision(player, enemies)) {
      world.end = true;
    } else {
      Global.score++;
    }
    world.render(canvas);
    player.update(size);
    player.render(canvas);

    if (enemies.isEmpty) {
      createEnemies(size);
    }

    for (Enemy enemy in enemies) {
      enemy.update(size);
      if (enemy.alive) {
        enemy.render(canvas);
      } else {
        enemy.x = random.nextDouble() * size.width - 10;
        enemy.y = size.height - (random.nextDouble() * 20);
        enemy.alive = true;
      }
    }
  }

  bool checkCollision(Player player, List<Enemy> enemies) {
    for (Enemy enemy in enemies) {
      if ((player.x - enemy.x).abs() < 20 && (player.y - enemy.y).abs() < 20) {
        print('Colisão');
        return true;
      }
    }
    return false;
  }

  void createEnemies(Size size) {
    for (int i = 0; i < 20; i++) {
      double x = random.nextDouble() * size.width;
      double y = size.height - (random.nextDouble() * (size.height / 1.5));
      print("$i => x= $x; y= $y");
      enemies.add(Enemy(x: x, y: y));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
