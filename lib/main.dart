import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
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
  String name;
  String type = 'TYPE A';
  String language;
  String country;
  String synopsis;
  String productionMail;
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
  List<String> production = ['Production A', 'Production B', 'Production A'];
  List<String> terms = [
    """ Importantly, there is no nudity allowed at all and attempts
will result in a loss of account and submission of content
to local authorities for prosecution.""",
    """I agree to submit only my own original content and agree
to be fined and cover all legal expenses of the company if
I submit unoriginal or copyrighted material.""",
    """ I agree to allow to show my original content 
to their entire audience and to anyone
including media outlets, to allow a future sale.""",
    """All creators recognize that the purpose of
is to one, provide free original content
to as large an audience as possible and two..
"""
  ];
  String extaText =
      """(Must be under 12 mins, also note it is our opinion that if videos are not done in English,that is the best chance to achieve max viewership is with subtitles.)""";

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
          headline2: TextStyle(
            fontSize: 10.0,
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              padding: EdgeInsets.all(15),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'What do people call you?',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value != null) {
                      name = value;
                    }
                    return value;
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
                SizedBox(
                  height: 15,
                ),
                TermsAndConditions(terms: terms[0]),
                TermsAndConditions(terms: terms[1]),
                TermsAndConditions(terms: terms[2]),
                TermsAndConditions(terms: terms[3]),
                Text(
                  'Read More',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                UploadButton(
                  heading: 'Upload Thumbnail',
                  iconNeeded: true,
                ),
                UploadButton(
                  heading: """Upload Video""",
                  extraText: extaText,
                  iconNeeded: false,
                ),
                SearchBox(
                  context: context,
                  myList: production,
                  label: 'Production House',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'E-mail of Production House',
                    labelText: 'Production House E-mail',
                  ),
                  validator: (value) {
                    if (value != null) {
                      productionMail = value;
                    }
                  },
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      print('Name: $name');
                      print('Production Mail: $productionMail');
                    }
                  },
                  padding: null,
                  child: Center(
                      child: Text('Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
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
  // List<String> myList = this.myList;
    List<String> added = [];
    String currentText = "";
    TextEditingController controller = TextEditingController(text: '');

  getDetails() async {
    return added == null ? 'Empty' : added[0];
  }

  @override
  Widget build(context) {
    return SimpleAutoCompleteTextField(
      key: key,
      decoration: new InputDecoration(
          labelText: widget.label,
          hintText: 'Your ${widget.label} name',
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
        Container(
          height: 120.0,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: TextFormField(
            maxLines: 5,
            decoration: new InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.black54,
              filled: true,
            ),
            validator: (value) {
              if (value != null) {
                
              }
            },
          ),
        ),
      ],
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  final String terms;
  TermsAndConditions({this.terms});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_box,
            color: Colors.white,
            size: 20.0,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              terms,
            ),
          ),
        ],
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  final String heading;
  final bool iconNeeded;
  final String extraText;
  UploadButton({this.heading, this.iconNeeded, this.extraText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: Theme.of(context).textTheme.headline1,
            ),
            iconNeeded ? Icon(Icons.info) : Container(),
            SizedBox(width: 5.0),
            extraText != null
                ? Expanded(
                    child: Text(
                      extraText,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Container(),
          ],
        ),
        Container(
          height: 200.0,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: FlatButton(
            child: Card(
              color: Colors.black54,
              child: Center(
                  child: Icon(
                Icons.add,
                color: Colors.white,
              )),
            ),
            onPressed: () {
              SnackBar mySnackbar = new SnackBar(
                content: Text('$heading button has been clicked'),
                backgroundColor: Colors.white,
              );
              Scaffold.of(context).showSnackBar(mySnackbar);
            },
          ),
        ),
      ],
    );
  }
}
