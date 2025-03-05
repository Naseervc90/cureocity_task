import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'core/dependency_injection.dart';

import 'presentation/pages/countries_page.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Initialize GraphQL
  await initializeGraphQL();

  // Setup Dependency Injection
  setupDependencyInjection();

  runApp(const MyApp());
}

Future<void> initializeGraphQL() async {
  await initHiveForFlutter();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CountriesPage(),
    );
  }
}
