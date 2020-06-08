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
  String name;
  String type;
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
    'United Kingdom',
    'Argentina',
    'Brazil',
    'Denmark',
    'Fiji',
    'Ghana',
    'Japan',
    'Madagascar',
    'Nigeria',
    'Indonesia',
    'Iceland',
    'Palau',
    'Zimbabwe',
  ];
  List types = [
    {'display': 'TYPE A', 'value': 'TYPE A'},
    {'display': 'TYPE B', 'value': 'TYPE B'}
  ];
  List<String> languages = [
    'Hindi',
    'English',
    'Chinese',
    'Japanese',
    'Russian'
  ];
  List<String> production = ['Production A', 'Production B', 'Production C'];
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
              padding: EdgeInsets.all(15),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'What do people call you?',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    setState(() {
                      name = value;
                    
                    });
                  },
                ),
                SearchableField(
                  myList: countries,
                  label: 'Country',
                ),
                DropdownButtonFormField(
                  // key: _formKey,
                  value: type,
                  hint: Text('TYPE'),
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                    Icons.close,
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                  )),
                  items: types.map((item) {
                    return DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Text(item['display']),
                        ],
                      ),
                      value: item['value'],
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      type = item.value;
                    });
                  },
                  validator: (value) {
                    setState(() {
                      if (value != null) {
                        type = value;
                      }
                    });
                    // return value;
                  },
                ),
                SearchableField(
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
                SearchableField(
                  myList: production,
                  label: 'Production House',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'E-mail of Production House',
                    labelText: 'Production House E-mail',
                  ),
                  validator: (value) {
                    setState(() {
                    if (value != null) {
                      productionMail = value;
                    }  
                    });
                  },
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('Name: $name');
                      print('Type: $type');
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
              if (value != null) {}
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

class SearchableField extends StatefulWidget {
  final String label;
  final List<String> myList;

  SearchableField({this.label, this.myList});

  @override
  _SearchableFieldState createState() => _SearchableFieldState();
}

class _SearchableFieldState extends State<SearchableField> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SearchableDropdown.single(
        value: selectedValue,
        items: widget.myList.map((item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
        hint: widget.label,
        searchHint: 'Select ${widget.label}',
        dialogBox: true,
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        searchFn: (String keyword, items) {
          List<int> ret = List<int>();
          if (keyword != null && items != null && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              items.forEach((item) {
                if (k.isNotEmpty &&
                    (item.value
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  ret.add(i);
                }
                i++;
              });
            });
          }
          if (keyword.isEmpty) {
            ret = Iterable<int>.generate(items.length).toList();
          }
          return (ret);
        },
      ),
    );
  }
}
