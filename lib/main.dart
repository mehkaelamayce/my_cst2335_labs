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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
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
              const Text('BROWSE CATEGORIES', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              const SizedBox(height: 14),

              // Subtitle
              const Text(
                  "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),

              const SizedBox(height: 28),

              // BY MEAT
              const _SectionHeader('BY MEAT'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _MeatChoices('images/beef.jpg', 'BEEF'),
                  _MeatChoices('images/chicken.jpg', 'CHICKEN'),
                  _MeatChoices('images/pork.jpg', 'PORK'),
                  _MeatChoices('images/seafood.jpg', 'SEAFOOD'),
                ],
              ),
              const SizedBox(height: 30),

              // BY COURSE
              const _SectionHeader('BY COURSE'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _ImageWithLabel('images/maindish.jpg', 'Main Dishes'),
                  _ImageWithLabel('images/salad.jpg', 'Salad Recipes'),
                  _ImageWithLabel('images/sidedish.jpg', 'Side Dishes'),
                  _ImageWithLabel('images/crockpot.jpg', 'Crockpot'),
                ],
              ),

              const SizedBox(height: 30),

              // BY DESSERT
              const _SectionHeader('BY DESSERT'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _ImageWithLabel('images/icecream.jpg', 'Ice Cream'),
                  _ImageWithLabel('images/brownies.jpg', 'Brownies'),
                  _ImageWithLabel('images/pies.jpg', 'Pies'),
                  _ImageWithLabel('images/cookies.jpg', 'Cookies'),
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
    return Text(text, textAlign: TextAlign.center, style: const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold,
      ),
    );
  }
}

// BY MEAT: centered text on image
class _MeatChoices extends StatelessWidget {
  final String image;
  final String label;

  const _MeatChoices(this.image, this.label);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(backgroundImage: AssetImage(image), radius: 45,),
        CircleAvatar(radius: 45, backgroundColor: Colors.black.withOpacity(0.25),),
        Text(label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 6, color: Colors.black45,)],
          ),
        ),
      ],
    );
  }
}

// BY COURSE / BY DESSERT
class _ImageWithLabel extends StatelessWidget {
  final String image;
  final String label;

  const _ImageWithLabel(this.image, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundImage: AssetImage(image), radius: 45,),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center, style:
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w500,
        ),
        ),
      ],
    );
  }
}
