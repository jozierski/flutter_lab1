import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Match Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
with TickerProviderStateMixin{
  late ConfettiController _controllerConfetti;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controllerConfetti.dispose();
    super.dispose();
  }

  int _team1 = 0;
  int _team2 = 0;

  _winningTeam() {
    if (_team1 > _team2) return Alignment.topLeft;
    if (_team1 < _team2) return Alignment.topRight;
    if (_team1 == _team2) return Alignment.topCenter;
  }

  _ballStatus() {
    if (_team1 > _team2) {
      return Tween(begin: 0.0, end: -1.0).animate(_controller);
    } else if (_team1 < _team2) {
      return Tween(begin: 0.0, end: 1.0).animate(_controller);
    } else {
      return Tween(begin: 0.0, end: 0.0).animate(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              const Image(image: AssetImage('images/wallpaper.jpg')),
              Container(
                margin: const EdgeInsets.only(top: 80, left: 50),
                width: 300,
                alignment: _winningTeam(),
                child: IconButton(
                  onPressed: () {
                    _controllerConfetti.play();
                  },
                  icon: const Icon(Icons.emoji_events),
                  iconSize: 100,
                  color: Colors.amber,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerConfetti,
                  blastDirectionality: BlastDirectionality.explosive,
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Text('$_team1 : $_team2',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _team1++;
                    });
                    _controller.repeat();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: const Icon(Icons.add),
                ),
                const Text('SCORE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    )),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _team2++;
                    });
                    _controller.repeat();
                  },

                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (_team1 > 0) {
                        _team1--;
                      }
                    });
                    _controller.repeat();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 100),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (_team2 > 0) {
                        _team2--;
                      }
                    });
                    _controller.repeat();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: const Icon(Icons.remove),
                ),
              ],
            ),

            // BALL
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   child: const Text("go"),
                //   onPressed: () => _controller.repeat(),
                // ),
                RotationTransition(
                  turns: _ballStatus(),
                  child: const Icon(
                    Icons.sports_soccer,
                    size: 70,
                  ),
                ),
              ],
            ),

            // SPACE
            const SizedBox(height: 40),

            // CARDS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: null,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    minimumSize: const Size(50, 70),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Yellow()),
                    );
                  },
                ),
                ElevatedButton(
                  child: null,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(50, 70),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Red()),
                    );

                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Yellow extends StatelessWidget {
  const Yellow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
      builder: (context, constrains) => ElevatedButton(
        child: null,
        style: TextButton.styleFrom(
            backgroundColor: Colors.yellow,
            fixedSize: Size(constrains.maxHeight, constrains.maxHeight),
            maximumSize: Size.infinite),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));
  }
}

class Red extends StatelessWidget {
  const Red({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
      builder: (context, constrains) => ElevatedButton(
        child: null,
        style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            fixedSize: Size(constrains.maxHeight, constrains.maxHeight),
            maximumSize: Size.infinite),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));
  }
}
