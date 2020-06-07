import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  String type = '';
  List<String> countries = [
    'India',
    'USA',
    'China',
    'Japan',
    'Russia',
    'United Kingdom'
  ];
  // List types = [{'display':'TYPE A','value':'1'},{'display':'TYPE B', 'value':'2'}];
  List<String> languages = [
    'Hindi',
    'English',
    'Chinese',
    'Japanese',
    'Russian'
  ];

  createDropDownMenuItem() {
    DropdownMenuItem<String> type1 = DropdownMenuItem(
      child: Row(
        children: <Widget>[Text('Type A')],
      ),
      onTap: () {
        print('DropDownMenu called!');
      },
    );
    DropdownMenuItem<String> type2 = DropdownMenuItem(
      child: Row(
        children: <Widget>[Text('Type B')],
      ),
      onTap: () {
        print('DropDownMenu called!');
      },
    );
    List<DropdownMenuItem<String>> myDropList = [type1, type2];
    return myDropList;
  }

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
                SearchBox(
                  context: context,
                  myList: countries,
                  label: 'Country',
                ),
                DropdownButtonFormField(
                  // value: 'TYPE',
                  items: createDropDownMenuItem(),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                // SearchBox(
                //   context: context,
                //   myList: languages,
                //   label: 'Language',
                // ),
                SearchableDropdown.single(
                  items: languages.map((item) {
                    return new DropdownMenuItem(child: Text(item));
                  }).toList(),
                  value: type,
                  hint: 'Select one',
                  searchHint: 'Select one',
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  isExpanded: true,
                ),
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
  final String label;
  SearchBox({this.context, this.myList, this.label});

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
    TextEditingController controller = TextEditingController(text: '');
    return SimpleAutoCompleteTextField(
      key: key,
      decoration: new InputDecoration(
          labelText: widget.label, hintText: 'Your country name'),
      controller: controller,
      suggestions: myList,
      textChanged: (text) => currentText = text,
      clearOnSubmit: true,
      submitOnSuggestionTap: true,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          added.add(text);
          controller.addListener(() {
            controller.value = TextEditingValue(text: text);
          });
        }
        print(added);
      }),
    );
  }
}
