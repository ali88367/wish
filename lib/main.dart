import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';

void main() {
  runApp(LoveSurpriseApp());
}

class LoveSurpriseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoveScreen(),
    );
  }
}

class LoveScreen extends StatefulWidget {
  @override
  _LoveScreenState createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> with SingleTickerProviderStateMixin {
  final ConfettiController _controller = ConfettiController(duration: Duration(seconds: 5));
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void startSurprise() {
    _controller.play();
    setState(() {
      showMessage = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!showMessage)
                  ElevatedButton(
                    onPressed: startSurprise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("Click Me ❤", style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                if (showMessage)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              "I Love You So Much! ❤❤❤",
                              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),
                              speed: Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                        SizedBox(height: 20),
                        AnimatedTextKit(
                          animatedTexts: [
                            FadeAnimatedText(
                              "You are the best thing that ever happened to me. Thank you for being in my life! 💕",
                              textStyle: TextStyle(fontSize: 20, color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                        SizedBox(height: 20),
                        Icon(Icons.favorite, size: 80, color: Colors.redAccent),
                        SizedBox(height: 10),
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Text(
                            "Forever Yours ❤",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirection: pi / 2,
              shouldLoop: false,
              colors: [Colors.red, Colors.pink, Colors.purple, Colors.orange],
              numberOfParticles: 50,
            ),
          ),
        ],
      ),
    );
  }
}
