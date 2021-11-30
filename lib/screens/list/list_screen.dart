import 'package:dictionary_app/model/word_response.dart';
import 'package:dictionary_app/screens/detail/detail_screen.dart';
import 'package:dictionary_app/utilities/title_case.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<WordResponse> words;

  ListScreen(this.words);

  @override
  Widget build(BuildContext context) {
    TitleCase instance = TitleCase();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: ListTile(
              title: Text(
                "${index + 1}. ${instance.titleCase(words[index].word)}",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(words[index]),
                  ),
                );
              },
            ),
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemCount: words.length,
      ),
    );
  }
}
