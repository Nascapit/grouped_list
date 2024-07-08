import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

void main() => runApp(const MyApp());

List<Map<String, String>> _elements = [
  {'name': 'John', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team B'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team B'},
  {'name': 'Mike', 'group': 'Team C'},
  {'name': 'Danny', 'group': 'Team C'},
];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final StreamController<GroupedListItem<Map<String, String>>> streamController = StreamController();

  final GlobalKey _key = GlobalKey();
  final GlobalKey _stickyHeaderKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> _elements = [
      {'name': 'John', 'group': 'Team A'},
      {'name': 'Will', 'group': 'Team B'},
      {'name': 'Beth', 'group': 'Team A'},
      {'name': 'Miranda', 'group': 'Team B'},
      {'name': 'Mike', 'group': 'Team C'},
      {'name': 'Danny', 'group': 'Team C'},
      {'name': 'Mike', 'group': 'Team C'},
      {'name': 'Danny', 'group': 'Team C'},
      {'name': 'Mike', 'group': 'Team C'},
      {'name': 'Danny', 'group': 'Team C'},
      {'name': 'Mike', 'group': 'Team C'},
      {'name': 'Danny', 'group': 'Team C'},
      {'name': 'Mike', 'group': 'Team D'},
      {'name': 'Danny', 'group': 'Team D'},
      {'name': 'Mike', 'group': 'Team D'},
      {'name': 'Danny', 'group': 'Team D'},
      {'name': 'Mike', 'group': 'Team D'},
      {'name': 'Danny', 'group': 'Team D'},
      {'name': 'Mike', 'group': 'Team D'},
      {'name': 'Danny', 'group': 'Team D'},
      {'name': 'Mike', 'group': 'Team D'},
      {'name': 'Danny', 'group': 'Team D'},
      {'name': 'Mike', 'group': 'Team D'},
      {'name': 'Danny', 'group': 'Team D'},
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              key: _key,
              title: Text("woopaloopa"),
              pinned: true,
              floating: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: Text("Woopa"),
              ),
            ),
            SliverPersistentHeader(
                key: _stickyHeaderKey,
                pinned: true,
                delegate: HeaderDelegate(
                    widget: StreamBuilder<GroupedListItem<Map<String, String>>>(
                  initialData: GroupedListItem(0, _elements.first),
                  stream: streamController.stream,
                  builder: (buildContext, AsyncSnapshot<GroupedListItem<Map<String, String>>> snapshot) {
                    GroupedListItem<Map<String, String>>? data = snapshot.data;

                    String result = "PENIS";
                    if (data != null) {
                      result = data.data['group'] ?? "jokul";
                    }

                    return SizedBox(
                      height: 56,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Text(result),
                        color: Colors.white,
                      ),
                    );
                  },
                ))),
            SliverGroupedListView<Map<String, String>, String>(
              controller: _scrollController,
              elements: _elements,
              groupBy: (element) => element['group'] ?? "",
              groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) => item1['name']!.compareTo(item2['name'] ?? ""),
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              streamController: streamController,
              groupHeaderKey: _stickyHeaderKey,
              appBarKey: _key,
              groupSeparatorBuilder: (String value) => SizedBox(
                height: 56,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(value),
                  color: Colors.white,
                ),
              ),
              itemBuilder: (c, element) {
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: SizedBox(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: const Icon(Icons.account_circle),
                      title: Text(element['name'] ?? ""),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  HeaderDelegate({required this.widget});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(width: double.infinity, height: 80, child: widget);
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
