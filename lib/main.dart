import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Interesting Stories'),
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

  String _selectedLanguage = 'English';
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

  }


    List<String> allStories = [
      "Once upon a time, in a faraway land, a young prince was cursed to live as a beast until he learned to love.",
      "A group of explorers discovered an ancient city hidden beneath the ice of Antarctica.",
      "A boy found a mysterious key that opened a door to another dimension.",
      "A scientist accidentally created a potion that made him invisible, but the effects were irreversible.",
      "During a space mission, an astronaut encountered a strange, glowing object that gave him superpowers.",
      "A small village in Japan has a forest where it is said people can communicate with spirits.",
      "In a world where time stops for everyone except for one person, that person becomes the guardian of time.",
      "A magical library exists where the books write themselves, containing stories of people’s dreams.",
      "A pirate ship sailing through the Caribbean found a map leading to the legendary lost city of gold.",
      "A woman wakes up every day with no memory of her past, but she leaves herself clues hidden around the house.",
    ];



  void _showLanguageModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _languageOption('English'),
              _languageOption('Spanish'),
              _languageOption('French'),
              _languageOption('German'),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(String language) {
    return RadioListTile<String>(
      title: Text(language),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (String? value) {
        setState(() {
          _selectedLanguage = value!;
        });
        Navigator.of(context).pop(); // Close the modal after selection
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: _showLanguageModal,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Language: $_selectedLanguage',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allStories.length,
              itemBuilder: (context, index) {
                String story =allStories[index];
                return ListTile(
                  title: Text(story),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showLanguageModal,
        tooltip: 'Select Language',
        child: const Icon(Icons.language),
      ),
    );
  }
}
