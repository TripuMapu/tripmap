import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripmap/routegenerator.dart';
import 'package:tripmap/screens/contentscreen.dart';
import 'package:tripmap/widgets/search.dart';
import 'package:tripmap/widgets/gridview.dart';
import 'package:tripmap/widgets/scrollablelist.dart';

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2>
    with TickerProviderStateMixin {
  bool isGrid = true;
  int _currentDistrictIndex = 0;

  // TickerProviderStateMixin allows the fade out/fade in animation when changing the active button

  // this will control the button clicks and tab changing
  late TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  late AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  late AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  late Animation _colorTweenBackgroundOn;
  late Animation _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  late Animation _colorTweenForegroundOn;
  late Animation _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  final List _icons = [
    'Müzeler',
    'Parklar',
    'Ormanlar',
    'Sahiller',
    'Resimlik',
    'Selam'
  ];

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.black;

  // active button's background color
  Color _backgroundOn = Colors.blue;
  Color? _backgroundOff = Colors.grey[300];

  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }

    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: _icons.length);
    // this will execute the function every time there's a swipe animation
    _controller.animation!.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
                height: 49.0,
                // this generates our tabs buttons
                child: ListView.builder(
                    // this gives the TabBar a bounce effect when scrolling farther than it's size
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    // make the list horizontal
                    scrollDirection: Axis.horizontal,
                    // number of tabs
                    itemCount: _icons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        // each button's key
                        key: _keys[index],
                        // padding for the buttons
                        padding: EdgeInsets.all(6.0),
                        /*child: ButtonTheme(
                              child: AnimatedBuilder(
                            animation: _colorTweenBackgroundOn,
                            builder: (context, child) => FlatButton(
                                // get the color of the button's background (dependent of its state)
                                color: _getBackgroundColor(index),
                                // make the button a rectangle with round corners
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(7.0)),
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
                                  _icons[index],
                                  // get the color of the icon (dependent of its state)
                                )),
                          ))*/
                      );
                    })),
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
                itemCount: 5,
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
                                child: Image.asset(
                                  'png/ayasofya.jpg',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Fatih',
                                          style: TextStyle(color: Colors.white),
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
                        TextButton(onPressed: () {}, child: Text('Tümünü Gör'))
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
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Colors.black,
                                                  Color.fromARGB(124, 0, 0, 0),
                                                  Colors.transparent,
                                                ],
                                                stops: [
                                                  .35,
                                                  .75,
                                                  1,
                                                ]).createShader(Rect.fromLTRB(
                                                0, 0, rect.width, rect.height));
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text(
                                                  '4.5/5',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
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
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      'Ayasofya',
                                                      style: TextStyle(
                                                          color: Colors.white),
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
      body: TabBarView(
        controller: _controller,
        children: [
          isGrid ? GridViewWidget() : ScrollableListWidget(),
          isGrid ? GridViewWidget() : ScrollableListWidget(),
          isGrid ? GridViewWidget() : ScrollableListWidget(),
          isGrid ? GridViewWidget() : ScrollableListWidget(),
          isGrid ? GridViewWidget() : ScrollableListWidget(),
          isGrid ? GridViewWidget() : ScrollableListWidget(),
        ],
      ),
    );
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
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
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
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
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

  Widget _gridView(Color color) {
    List<bool> isBookmarked = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: .55,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              mainAxisExtent: 250,
            ),
            delegate: SliverChildBuilderDelegate(childCount: 10,
                (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/content', arguments: []),
                  child: Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 250,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.black,
                                    Color.fromARGB(124, 0, 0, 0),
                                    Colors.transparent,
                                  ],
                                  stops: [
                                    .35,
                                    .75,
                                    1,
                                  ]).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(
                              'png/ayasofya.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.5/5',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              color: const Color.fromARGB(113, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Ayasofya',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isBookmarked[index] = true;
                                        });
                                      },
                                      icon: Icon(
                                        isBookmarked[index]
                                            ? Icons.bookmark
                                            : Icons.bookmark_outline,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _scrollableList(Color color) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Container(
                  height: 200,
                  color: Color.fromARGB(255, 236, 236, 236),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 175,
                          width: 120,
                          child: Image.asset(
                            'png/ayasofya.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 3),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ayasofya',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: RatingBarIndicator(
                                    rating: 3.5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 17,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ],
          );
        });
  }
}
