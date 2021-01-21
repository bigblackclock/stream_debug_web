import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stream_debug_web/contact.dart';
import 'package:stream_debug_web/contact_functions.dart';
import 'package:stream_debug_web/ticker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(
        contactFunctions: ContactFunctions(),
        ticker: Ticker(),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key, this.contactFunctions, this.ticker})
      : super(key: key);
  final ContactFunctions contactFunctions;
  final Ticker ticker;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                key: Key('firstContactStream'),
                stream: contactFunctions.contacts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    QuerySnapshot contacts = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.docs.length,
                      itemBuilder: (context, index) => Text(
                          Contact.fromMap(contacts.docs[index].data()).name),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error');
                  } else
                    return Text('Loading');
                },
              ),
              StreamBuilder(
                key: Key('firstTickerStream'),
                stream: ticker.tick(ticks: 90),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error');
                  } else
                    return Text('Loading');
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(
                contactStream: contactFunctions.contacts(),
                tickerStream: ticker.tick(ticks: 90),
              ),
            )),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key key, this.contactStream, this.tickerStream})
      : super(key: key);
  final Stream contactStream;
  final Stream tickerStream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
          child: Center(
        child: Column(
          children: [
            StreamBuilder(
              key: Key('SecondContactStream'),
              stream: contactStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot contacts = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: contacts.docs.length,
                    itemBuilder: (context, index) =>
                        Text(Contact.fromMap(contacts.docs[index].data()).name),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error');
                } else
                  return Text('Loading');
              },
            ),
            StreamBuilder(
              key: Key('tickerstreanmSecondPage'),
              stream: tickerStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error');
                } else
                  return Text('Loading');
              },
            ),
          ],
        ),
      )),
    );
  }
}
