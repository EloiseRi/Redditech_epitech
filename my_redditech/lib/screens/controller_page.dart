import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:provider/provider.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Publications'),
  Tab(text: 'Commentaires'),
  Tab(text: 'À propos'),
];

// class PostsGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Consumer<PostsState>(
//         builder: (context, state, _) {
//           return GridView.builder(
//             gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//             shrinkWrap: true,
//             itemCount: state.contents.length,
//             itemBuilder: (context, index) {
//               return PostThumbnail(
//                 post: state.contents[index],
//                 index: index,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class PostThumbnail extends StatelessWidget {
//   final Submission post;
//   final int index;

//   const PostThumbnail({Key? key, required this.post, required this.index})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget child;

//     if (post.isSelf || post.preview.isEmpty) {
//       child = Center(
//         child: Text(post.title),
//       );
//     } else {
//       child = Image.network(
//         post.thumbnail.toString(),
//         fit: BoxFit.cover,
//       );
//     }

//     return GestureDetector(
//       onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => PostsPage(
//                     startingIndex: index,
//                   ))),
//       child: child,
//     );
//   }
// }

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key, required this.startingIndex}) : super(key: key);
  final int startingIndex;
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PageController _controller;
  bool shouldPop = true;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<PostsState>(
          builder: (context, state, _) {
            return WillPopScope(
              // onWillPop: () => _exitView(context),
              onWillPop: () async {
                return shouldPop;
              },
              child: StreamBuilder(
                stream: state.controller.stream,
                builder: (context, snapshot) => PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.contentList.length,
                    itemBuilder: (context, index) {
                      Submission post = state.contentList[index];
                      print(index);

                      bool loadMore = (index > state.contentList.length - 10);
                      return SingleChildScrollView(
                        child: Center(
                          child: Text(post.title),
                        ),
                      );
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
