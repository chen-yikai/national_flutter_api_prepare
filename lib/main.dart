import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:national_flutter_api_prepare/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MaterialApp(
    home: Entry(),
    debugShowCheckedModeBanner: false,
  ));
}

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final hostname = "https://skills-music-api-v3.eliaschen.dev";

  @override
  void initState() {
    super.initState();
    getApi();
  }

  Future<List<Sound>> getApi() async {
    final httpClient = HttpClient();
    try {
      final request = await httpClient.getUrl(Uri.parse("$hostname/sounds"))
        ..headers.add("X-API-Key", "kitty-secret-key");
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final res = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(res);
        List<Sound> sounds =
            (jsonData as List).map((item) => Sound.fromJson(item)).toList();
        print(sounds);
        return sounds;
      }
      return [];
    } catch (e) {
      print("error $e");
      return [];
    } finally {
      httpClient.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: getApi(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data?[index];
                                return ListTile(title: Text(data!.name));
                              })
                          : Text("data");
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
