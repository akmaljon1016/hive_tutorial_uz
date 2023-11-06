import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box ismBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  ismBox = await Hive.openBox("ismBox");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtIsm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hive Tutorial"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtIsm,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Ism kiriting"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  ismBox.add(txtIsm.text);
                });
              },
              child: Text("Saqlash"),
              color: Colors.green,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ismBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Text(ismBox.getAt(index)),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
