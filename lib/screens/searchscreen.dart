import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripmap/models/location.dart';
import 'package:tripmap/services/authservices.dart';
import 'package:tripmap/widgets/searchbody.dart';
import 'package:tripmap/widgets/searchwidget.dart';

class SearchScreen extends StatefulWidget {
  final int currentindex;
  const SearchScreen({Key? key, required this.currentindex}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Location> alllocations = [];
  List<Location> dummylocations = [];
  OverlayEntry? entry;
  String query = '';
  bool isHidden = true;

  void getlocations() async {
    await AuthService().getalllocations().then((val) {
      alllocations = val.map((json) => Location.fromJson(json)).toList();
      dummylocations = alllocations;
      setState(() {});
    });
  }

  @override
  void initState() {
    if (widget.currentindex == 1) {
      super.initState();
      getlocations();
    }
  }

  Widget buildSearch() {
    return SearchWidget(
      text: query,
      hintText: 'Lokasyon İsmi',
      onChanged: searchLocation,
    );
  }

  void searchLocation(String query) {
    final dummylocations = alllocations.where((location) {
      final titleLower = location.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.startsWith(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.dummylocations = dummylocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.currentindex == 1
        ? Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (isHidden) {
                              isHidden = false;
                            } else {
                              isHidden = true;
                            }
                          });
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                isHidden
                    ? const SliverToBoxAdapter(
                        child: SizedBox(),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        sliver: SliverToBoxAdapter(
                          child: buildSearch(),
                        ),
                      ),
                SearchBody(locations: dummylocations),
              ],
            ),
          )
        : const Scaffold();
  }
}
