import 'package:flutter/foundation.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MyHomePage(title: 'Naw Doz'),
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
  int limit = 10;
  int offset = 0;
  final List<String> genderList = ["O", "M", "F"];
  String gender = "O";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    elevation: 0,
                    hint: const Text("Limit"),
                    items:
                        ["100", "200", "300", "400", "500"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        limit = int.parse(val!);
                      });
                    },
                  ),
                ),
                const VerticalDivider(),
                SizedBox(
                  width: 104,
                  child: Expanded(
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Gender"),
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      items: genderList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                          value = value;
                        });
                      },
                    ),
                  ),
                ),
                const VerticalDivider(),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    hint: const Text("Offset"),
                    items:
                        ["0", "10", "20", "30", "40", "50"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        offset = int.parse(val!);
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(snapshot.data!.names![index].name!),
                          subtitle: Text(snapshot.data!.names![index].desc!),
                        ),
                      );
                    },
                  );
                }
              }),
            )),
          ],
        ),
      ),
    );
  }

  Future<KurdishNames> getData() async {
    String endPoint =
        'https://nawikurdi.com/api?limit=$limit&offset=$offset&gender=$gender';
    final response = await http.get(Uri.parse(endPoint));
    var kurdishNames = KurdishNames.fromJson(response.body);
    return kurdishNames;
  }
}
