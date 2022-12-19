import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripmap/models/comment.dart';
import 'package:tripmap/models/district.dart';
import 'package:tripmap/models/location.dart';
import 'package:tripmap/models/locationtype.dart';
import 'package:tripmap/routegenerator.dart';
import 'package:tripmap/screens/contentscreen.dart';
import 'package:tripmap/services/authservices.dart';

import 'package:tripmap/widgets/gridview.dart';
import 'package:tripmap/widgets/scrollablelist.dart';

class HomeScreen extends StatefulWidget {
  final int currentindex;
  const HomeScreen({Key? key, required this.currentindex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isFetched = false;
  bool isGrid = true;
  OverlayEntry? entry;
  int _currentDistrictIndex = 0;
  late TabController _controller;
  late AnimationController _animationControllerOn;
  late AnimationController _animationControllerOff;
  late Animation _colorTweenBackgroundOn;
  late Animation _colorTweenBackgroundOff;
  late Animation _colorTweenForegroundOn;
  late Animation _colorTweenForegroundOff;
  int _currentIndex = 0;
  int _prevControllerIndex = 0;
  double _aniValue = 0.0;
  double _prevAniValue = 0.0;
  final Color _foregroundOn = Colors.white;
  final Color _foregroundOff = Colors.black;
  final Color _backgroundOn = Colors.blue;
  final Color? _backgroundOff = Colors.grey[300];
  final ScrollController _scrollController = ScrollController();
  final List _keys = [];
  bool _buttonTap = false;
  List<District> districtslist = [];
  List<Location> locationlist = [];
  List<LocationType> typelist = [];
  List<Widget> gridviewlist = [];
  List<Widget> scrollableviewlist = [];

  void initializedata() async {
    await AuthService().getdistricts().then((val) {
      districtslist = val.map((json) => District.fromJson(json)).toList();
    });
    await AuthService().getlocations(1).then((val) {
      locationlist = val.map((json) => Location.fromJson(json)).toList();
    });
    await AuthService().gettypes().then((val) {
      typelist = val.map((json) => LocationType.fromJson(json)).toList();
    });
    for (int index = 0; index < typelist.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(GlobalKey());
      gridviewlist.add(GridViewWidget(
        locationslist: locationlist,
        typeid: typelist[index].id,
      ));
      scrollableviewlist.add(ScrollableListWidget(
        locationslist: locationlist,
        typeid: typelist[index].id,
      ));
    }
    _controller = TabController(vsync: this, length: typelist.length);
    _controller.animation!.addListener(_handleTabAnimation);
    _controller.addListener(_handleTabChange);
    _animationControllerOff = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 75));
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);
    _animationControllerOn = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
    setState(() {
      hideLoadingOverlay();
      isFetched = true;
    });
  }

  void changelocationdata() async {
    setState(() {
      isFetched = false;
    });
    await AuthService().getlocations(_currentDistrictIndex + 1).then((val) {
      locationlist.clear();
      locationlist = val.map((json) => Location.fromJson(json)).toList();
    });
    setState(() {
      isFetched = true;
    });
  }

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );

  @override
  void initState() {
    if (widget.currentindex == 0) {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
      initializedata();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.currentindex == 0
        ? NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                        height: 49.0,
                        // this generates our tabs buttons
                        child: ListView.builder(
                            // this gives the TabBar a bounce effect when scrolling farther than it's size
                            physics: BouncingScrollPhysics(),
                            controller: _scrollController,
                            // make the list horizontal
                            scrollDirection: Axis.horizontal,
                            // number of tabs
                            itemCount: typelist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  // each button's key
                                  key: _keys[index],
                                  // padding for the buttons
                                  padding: EdgeInsets.all(6.0),
                                  child: ButtonTheme(
                                      child: AnimatedBuilder(
                                    animation: _colorTweenBackgroundOn,
                                    builder: (context, child) => ElevatedButton(
                                        // get the color of the button's background (dependent of its state)
                                        // make the button a rectangle with round corners
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    _getBackgroundColor(
                                                        index))),
                                        onPressed: () {
                                          setState(() {
                                            _buttonTap = true;
                                            // trigger the controller to change between Tab Views
                                            _controller.animateTo(index);
                                            // set the current index
                                            _setCurrentIndex(index);
                                            // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                            _scrollTo(index);
                                          });
                                        },
                                        child: Text(
                                          // get the icon
                                          typelist[index].name,
                                          // get the color of the icon (dependent of its state)
                                        )),
                                  )));
                            })),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    height: 5,
                    thickness: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    color: Colors.white,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      itemCount: districtslist.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentDistrictIndex =
                                    index; //gridviewda gelen veriyi değiştir
                              });
                            },
                            child: Container(
                              width: 125,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _currentDistrictIndex == index
                                      ? Colors.blue
                                      : Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        districtslist[index].districtimageurl,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(113, 0, 0, 0),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                districtslist[index]
                                                    .districtname,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    height: 5,
                    thickness: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('En Popülerler'),
                              TextButton(
                                  onPressed: () {}, child: Text('Tümünü Gör'))
                            ],
                          ),
                        ),
                        Container(
                          height: 250,
                          color: Colors.white,
                          child: ListView.builder(
                              clipBehavior: Clip.none,
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (() {
                                      Navigator.of(context)
                                          .pushNamed('/content', arguments: []);
                                    }),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 300,
                                        height: 250,
                                        color: Colors.black,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 250,
                                              child: ShaderMask(
                                                shaderCallback: (rect) {
                                                  return const LinearGradient(
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Colors.black,
                                                        Color.fromARGB(
                                                            124, 0, 0, 0),
                                                        Colors.transparent,
                                                      ],
                                                      stops: [
                                                        .35,
                                                        .75,
                                                        1,
                                                      ]).createShader(
                                                      Rect.fromLTRB(
                                                          0,
                                                          0,
                                                          rect.width,
                                                          rect.height));
                                                },
                                                blendMode: BlendMode.dstIn,
                                                child: Image.asset(
                                                  'png/ayasofya.jpg',
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: const [
                                                      Text(
                                                        '4.5/5',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  color: const Color.fromARGB(
                                                      113, 0, 0, 0),
                                                  child: Row(
                                                    children: const [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Text(
                                                            'Ayasofya',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    height: 5,
                    thickness: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton(
                              underline:
                                  const SizedBox(), //Daha sonra burası list ile düzeltilecek
                              value:
                                  'Popülerlik', //Daha sonra burası list ile düzeltilecek
                              items: const [
                                //Daha sonra burası list ile düzeltilecek
                                DropdownMenuItem(
                                  //Daha sonra burası list ile düzeltilecek
                                  value:
                                      'Popülerlik', //Daha sonra burası list ile düzeltilecek
                                  child: Text(
                                      'Popülerlik'), //Daha sonra burası list ile düzeltilecek
                                ) //Daha sonra burası list ile düzeltilecek
                              ],
                              onChanged: (String? newValue) {}),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isGrid = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.grid_view_sharp,
                                  color: isGrid ? Colors.purple : Colors.grey,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isGrid = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.format_list_bulleted,
                                  color: isGrid ? Colors.grey : Colors.purple,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: isFetched
                ? TabBarView(
                    controller: _controller,
                    children: isFetched
                        ? (isGrid ? gridviewlist : scrollableviewlist)
                        : [])
                : const Center(child: CircularProgressIndicator()),
          )
        : const Scaffold();
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation!.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[typelist.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }
}
