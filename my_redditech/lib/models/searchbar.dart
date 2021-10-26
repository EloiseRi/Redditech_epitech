// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/states/subreddits_state.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// class SearchBar extends StatefulWidget {
//   const SearchBar({Key? key}) : super(key: key);

//   @override
//   State<SearchBar> createState() => _SearchBar();
// }

// class _SearchBar extends State<SearchBar> {
//   List<String> searchResult = [];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 50),
//       child: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 16.0,
//           ),
//           TextField(
//             onTap: () async =>
//                 {showSearch(context: context, delegate: SearchSub())},
//             cursorColor: Colors.grey,
//             decoration: const InputDecoration(
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               prefixIconConstraints: BoxConstraints(
//                 minHeight: 16.0,
//                 minWidth: 38.0,
//               ),
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: Colors.black,
//               ),
//               fillColor: Color.fromARGB(40, 20, 20, 20),
//               filled: true,
//               isDense: true,
//               hintText: 'Search ...',
//               hintStyle: TextStyle(color: Colors.black),
//               contentPadding: EdgeInsets.all(8.0),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SearchSub extends SearchDelegate<String> {
//   @override
//   String get searchFieldLabel => 'Search...';

//   List<String> searchResult = [];

//   @override
//   List<Widget> buildActions(BuildContext context) => [
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             if (query.isEmpty) {
//               close(context, '');
//             } else {
//               query = '';
//               showSuggestions(context);
//             }
//           },
//         )
//       ];

//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () => close(context, ''),
//       );

//   @override
//   Widget buildResults(BuildContext context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.location_city, size: 120),
//             const SizedBox(height: 48),
//             Text(
//               query,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 64,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       );

//   @override
//   Widget buildSuggestions(BuildContext context) => Container(
//         color: Colors.white,
//         child: FutureBuilder<List<String>>(
//           future: computeQuery(context, query),
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return Center(child: CircularProgressIndicator());
//               default:
//                 return buildSuggestionsSuccess(snapshot.data!);
//             }
//           },
//         ),
//       );

//   Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
//         itemCount: suggestions.length,
//         itemBuilder: (context, index) {
//           final suggestion = suggestions[index];
//           final queryText = suggestion.substring(0, query.length);
//           final remainingText = suggestion.substring(query.length);

//           return ListTile(
//             onTap: () {
//               query = suggestion;
//               showResults(context);

//               // 2. Close Search & Return Result
//               // close(context, suggestion);

//               // 3. Navigate to Result Page
//               //  Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (BuildContext context) => ResultPage(suggestion),
//               //   ),
//               // );
//             },
//             leading: const Icon(Icons.location_city),
//             // title: Text(suggestion),
//             title: RichText(
//               text: TextSpan(
//                 text: queryText,
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: remainingText,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );

//   Future<List<String>> computeQuery(context, query) async {
//     return await Provider.of<SubredditsState>(context, listen: false)
//         .searchSubreddit(query);
//   }
// }

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
                        leading: const Icon(Icons.shopping_cart),
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
