import 'package:dictionary_app/blocs/dictionary_cubit.dart';
import 'package:dictionary_app/screens/list/list_screen.dart';
import 'package:dictionary_app/widget/gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  getDictionaryFormWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: [
          Spacer(),
          Text(
            "Dictionary App",
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Search any word you want quickly",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: cubit.queryControler,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Search a word",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: new BorderSide(color: Colors.deepOrangeAccent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.deepOrangeAccent,
              ),
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          GradientButton(
            width: 150,
            height: 45,
            onPressed: () {
              cubit.getWordSearched();
            },
            text: Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
          Spacer()
        ],
      ),
    );
  }

  getLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  getErrorWidget(message) {
    return Center(child: Text(message));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState && state.words != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListScreen(state.words)));
        }
      },
      bloc: cubit,
      child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: cubit.state is WordSearchingState
              ? getLoadingWidget()
              : cubit.state is ErrorState
                  ? getErrorWidget("Some Error")
                  : cubit.state is NoWordSearchedState
                      ? getDictionaryFormWidget(context)
                      : Container()),
    );
  }
}
