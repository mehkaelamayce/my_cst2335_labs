
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
    const double radius = 45;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('BROWSE CATEGORIES', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(
                "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            _SectionHeader('BY MEAT'),
            _MeatRow(radius: radius),
            _SectionHeader('BY COURSE'),
            _CourseRow(radius: radius),
            _SectionHeader('BY DESSERT'),
            _DessertRow(radius: radius),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
    Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 18, fontWeight: .bold));
  }
}

class _MeatRow extends StatelessWidget {
  final double radius;
  const _MeatRow({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CenterTextCircle('images/beef.jpg', 'BEEF', radius),
          _CenterTextCircle('images/chicken.jpg', 'CHICKEN', radius),
          _CenterTextCircle('images/pork.jpg', 'PORK', radius),
          _CenterTextCircle('images/seafood.jpg', 'SEAFOOD', radius),
        ],
    );
  }
}

class _CourseRow extends StatelessWidget {
  final double radius;
  const _CourseRow({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _BottomTextCircle('images/maindish.jpg', 'Main Dishes', radius),
        _BottomTextCircle('images/salad.jpg', 'Salad Recipes', radius),
        _BottomTextCircle('images/sidedish.jpg', 'Side Dishes', radius),
        _BottomTextCircle('images/crockpot.jpg', 'Crockpot', radius),
      ],
    );
  }
}

class _DessertRow extends StatelessWidget {
  final double radius;
  const _DessertRow({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _BottomTextCircle('images/icecream.jpg', 'Ice Cream', radius),
        _BottomTextCircle('images/brownies.jpg', 'Brownies', radius),
        _BottomTextCircle('images/pies.jpg', 'Pies', radius),
        _BottomTextCircle('images/cookies.jpg', 'Cookies', radius),
      ],
    );
  }
}

class _CenterTextCircle extends StatelessWidget {
  final String image;
  final String label;
  final double radius;

  const _CenterTextCircle(this.image, this.label, this.radius);

  @override
  Widget build(BuildContext context) {
   return Stack(
     alignment: Alignment.center,
     children: [
       CircleAvatar(backgroundImage: AssetImage(image), radius: radius),
       CircleAvatar(radius: radius, backgroundColor: Colors.black.withOpacity(0.25)),
       Text(
         label, style: const TextStyle(
            color: Colors.white, fontWeight: .bold)
       ),
     ],
   );
  }
}

class _BottomTextCircle extends StatelessWidget {
  final String image;
  final String label;
  final double radius;

  const _BottomTextCircle(this.image, this.label, this.radius);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2, height: radius * 2,
      child: Stack(
        children: [
          CircleAvatar(backgroundImage: AssetImage(image), radius: radius),

          Positioned(
              left: 0, right: 0, bottom: 20,
              child: Text(label, textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black, fontWeight: .bold, fontSize: 12,
                ),
              ),)
        ],
      ),
    );
  }
}