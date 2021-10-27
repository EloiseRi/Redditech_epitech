import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/states/subreddits_state.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Form(
              child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    cursorColor: Colors.grey,
                    autofocus: false,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        fontSize: 15),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minHeight: 16, minWidth: 36),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(7),
                      isDense: true,
                      filled: true,
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Color.fromARGB(20, 20, 20, 20),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await Provider.of<SubredditsState>(context,
                            listen: false)
                        .searchSubreddit(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    if (suggestion != null) {
                      return ListTile(
                        // leading: const Icon(suggestion),
                        title: Text(suggestion.toString()),
                        // subtitle: Text('\$${suggestion['price']}'),
                      );
                    } else {
                      return const ListTile(
                        title: Text('No subreddit'),
                      );
                    }
                  },
                  noItemsFoundBuilder: (value) {
                    return const Text('  Oups! No result...');
                  },
                  onSuggestionSelected: (suggestion) {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => ProductPage(product: suggestion)
                    // ));
                  },
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
