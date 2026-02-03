import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lab 4'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const double gap = 14;
    const double radius = 55;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Title
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'BROWSE CATEGORIES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 14),

              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 28),

              // BY MEAT
              const _SectionHeader('BY MEAT'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CenterTextCircle('images/beef.jpg', 'BEEF', radius),
                  SizedBox(width: 12),
                  _CenterTextCircle('images/chicken.jpg', 'CHICKEN', radius),
                  SizedBox(width: 12),
                  _CenterTextCircle('images/pork.jpg', 'PORK', radius),
                  SizedBox(width: 12),
                  _CenterTextCircle('images/seafood.jpg', 'SEAFOOD', radius),
                ],
              ),
              const SizedBox(height: 30),

              // BY COURSE
              const _SectionHeader('BY COURSE'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _BottomTextCircle('images/maindish.jpg', 'Main Dishes', radius),
                  SizedBox(width: 12),
                  _BottomTextCircle('images/salad.jpg', 'Salad Recipes', radius),
                  SizedBox(width: 12),
                  _BottomTextCircle('images/sidedish.jpg', 'Side Dishes', radius),
                  SizedBox(width: 12),
                  _BottomTextCircle('images/crockpot.jpg', 'Crockpot', radius),
                ],
              ),

              const SizedBox(height: 30),

              // BY DESSERT
              const _SectionHeader('BY DESSERT'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _BottomTextCircle('images/icecream.jpg', 'Ice Cream', radius),
                  SizedBox(width: 12),
                  _BottomTextCircle('images/brownies.jpg', 'Brownies', radius),
                  SizedBox(width: 12),
                  _BottomTextCircle('images/pies.jpg', 'Pies', radius),
                  SizedBox(width: 12),
                  _BottomTextCircle('images/cookies.jpg', 'Cookies', radius),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Widgets

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(
          child: Text(
            text, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, letterSpacing: 2.5, fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// BY MEAT: centered text on image
class _CenterTextCircle extends StatelessWidget {
  final String image;
  final String text;
  final double radius;

  const _CenterTextCircle(this.image, this.text, this.radius);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: radius,
        ),
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.black.withOpacity(0.25),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [Shadow(blurRadius: 6, color: Colors.black45, offset: Offset(0, 2))],
          ),
        ),
      ],
    );
  }
}

// BY COURSE / BY DESSERT: bottom-center text on image (per your lab instructions)
class _BottomTextCircle extends StatelessWidget {
  final String image;
  final String text;
  final double radius;

  const _BottomTextCircle(this.image, this.text, this.radius);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: radius,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 6, color: Colors.black45)],
            ),
          ),
        ),
      ],
    );
  }
}