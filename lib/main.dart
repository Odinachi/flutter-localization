import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:language_app/app/app_string.dart';

Future<void> main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'es', 'fr', 'de']);

  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MaterialApp(
      title: AppString.flutterDemo,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<String> langNotifier = ValueNotifier('en');

  @override
  void initState() {
    super.initState();
  }

  void _showLanguageModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppString.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _languageOption('English'),
              _languageOption('Español'),
              _languageOption('Français'),
              _languageOption('Deutsch'),
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
      groupValue: langNotifier.value,
      onChanged: (String? value) {
        langNotifier.value = value!;
        changeLocale(context, getLangString(value));
        Navigator.of(context).pop(); // Close the modal after selection
      },
    );
  }

  String getLangString(String value) {
    switch (value) {
      case "English":
        return 'en';
      case 'Español':
        return 'es';

      case 'Français':
        return 'fr';

      case 'Deutsch':
        return 'de';
      default:
        return 'en';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: langNotifier,
      builder: (_, value, child) {
        List<String> allStories = [
          AppString.story1,
          AppString.story2,
          AppString.story3,
          AppString.story4,
          AppString.story5,
          AppString.story6,
          AppString.story7,
          AppString.story8,
          AppString.story9,
          AppString.story10,
        ];
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppString.interestingStories),
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
                  '${AppString.selectLanguage}: ${langNotifier.value}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allStories.length,
                  itemBuilder: (context, index) {
                    String story = allStories[index];
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
            tooltip: AppString.selectLanguage,
            child: const Icon(Icons.language),
          ),
        );
      },
    );
  }
}
