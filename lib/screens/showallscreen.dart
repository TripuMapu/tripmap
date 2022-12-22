import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowAllScreen extends StatelessWidget {
  const ShowAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                //Navigator.of(context).pop();
              },
              icon: const Icon(LineAwesomeIcons.arrow_left),
              color: const Color(0xFF6C43BC),
            ),
          ),
        ],
      ),
    );
  }
}
