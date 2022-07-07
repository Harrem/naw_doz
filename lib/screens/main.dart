import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:name_doz/models/kurdish_names/kurdish_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int limit = 100;
  int offset = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<KurdishNames>(
          future: getData(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.names!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.names![index].name!),
                    subtitle: Text(snapshot.data!.names![index].desc!),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }

  Future<KurdishNames> getData() async {
    String endPoint = 'https://nawikurdi.com/api?limit=$limit&offset=$offset';
    final response = await http.get(Uri.parse(endPoint));
    var kurdishNames = KurdishNames.fromJson(response.body);
    return kurdishNames;
  }
}
