import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  List<String> countries = ['India', 'USA', 'China', 'Japan', 'Russia'];
  List<String> languages = ['Hindi', 'English', 'Chinese', 'Japanese', 'Russian'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DemoApp',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Upload Videos',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'What do people call you?',
                    labelText: 'Name',
                  ),
                  validator: (String value) {
                    return value.isEmpty ? 'Please fill this!' : null;
                  },
                ),
                SearchBox(context, countries),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  final BuildContext context;
  final List<String> myList;
  SearchBox(this.context, this.myList);

  @override
  _SearchBoxState createState() => _SearchBoxState(this.context, this.myList);
}

class _SearchBoxState extends State<SearchBox> {
  BuildContext context;
  List<String> myList;
  _SearchBoxState(this.context, this.myList);

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  
  @override
  Widget build(context) {
    List<String> myList = this.myList;
    List<String> added = [];
     String currentText = "";
    return SimpleAutoCompleteTextField(
      key: key,
      // decoration: new InputDecoration(errorText: "Beans"),
      controller: TextEditingController(text: added.isEmpty ? 'Country': added[0]),
      suggestions: myList,
      textChanged: (text) => currentText = text,
      clearOnSubmit: true,
      textSubmitted: (text) => setState(() {
            if (text != "") {
              added.add(text);
            }
          }),
    );
  }
}
