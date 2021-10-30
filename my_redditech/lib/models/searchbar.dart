import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/subreddit_page.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/states/subreddits_state.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  String? fetchLogo(Subreddit suggestion) {
    String? logo;
    if (Uri.parse(suggestion.data!['community_icon']).isAbsolute) {
      logo = Uri.parse(suggestion.data!['community_icon'], 0,
              suggestion.data!['community_icon'].toString().indexOf('?'))
          .toString();
    } else {
      logo = 'https://zupimages.net/up/21/43/6k02.png';
    }
    return logo;
  }

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
                TypeAheadField<Subreddit>(
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
                    return ListTile(
                      leading: CircleAvatar(
                          child: Image.network(fetchLogo(suggestion)!)),
                      title: Text('r/' + suggestion.displayName),
                      subtitle: Text(NumberFormat.compactCurrency(
                                  decimalDigits: 1, symbol: '')
                              .format(suggestion.data!['subscribers'])
                              .toString() +
                          ' members'),
                    );
                  },
                  noItemsFoundBuilder: (value) {
                    return const Text('  Oups! No result...');
                  },
                  onSuggestionSelected: (suggestion) {
                    Provider.of<PostsState>(context, listen: false)
                        .fetchPosts(source: suggestion.displayName);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SubredditPage(
                        subreddit: suggestion,
                      ),
                    ));
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
