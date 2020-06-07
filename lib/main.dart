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
  String type = 'TYPE A';
  List<String> countries = [
    'India',
    'USA',
    'China',
    'Japan',
    'Russia',
    'United Kingdom'
  ];
  List types = [
    {'display': 'TYPE A', 'value': '1'},
    {'display': 'TYPE B', 'value': '2'}
  ];
  List<String> languages = [
    'Hindi',
    'English',
    'Chinese',
    'Japanese',
    'Russian'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DemoApp',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w100,
            color: Color.fromRGBO(255, 255, 255, 0.7),
          ),
          bodyText1: TextStyle(fontSize: 15.0, fontFamily: 'Hind'),
        ),
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
                  items: types.map((item) {
                    return DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Text(item['display']),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                ),
                SearchBox(
                  context: context,
                  myList: languages,
                  label: 'Language',
                ),
                SizedBox(
                  height: 15,
                ),
                Synopsis(),
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
          labelText: widget.label,
          hintText: 'Your country name',
          suffixIcon: Icon(Icons.arrow_drop_down)),
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

class Synopsis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Synopsis(Mandatory)',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
        SizedBox(height:10),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check_box, color: Colors.white, size: 20.0,),
            SizedBox(width:5),
            Container(
              child:Expanded(child: Text('Importantly, there is no nudity allowed at all and attempts will result in a loss of account and submission of content to local authorities for prosecution. ')),),
          ],
        ),
      ],
    );
  }
}
