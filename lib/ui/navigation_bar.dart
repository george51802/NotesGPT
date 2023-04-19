import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../chatgpt/chat_runner.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  CustomNavigationBar({required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Set the desired height
      width:
          360, // Set the desired width, double.infinity will make it take full width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20), // Set the desired border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
        child: Center(
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            rippleColor: Color.fromARGB(
                255, 188, 188, 188), // tab button ripple color when pressed
            hoverColor:
                Color.fromARGB(255, 96, 96, 96), // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 20,
            tabActiveBorder:
                Border.all(color: Colors.white, width: 0), // tab button border
            tabBorder:
                Border.all(color: Colors.white, width: 1), // tab button border
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)
            ], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 400), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Color(0xff1152FD), // selected icon and text color

            iconSize: 25, // tab button icon size
            tabBackgroundColor: Color(0xff1152FD)
                .withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // navigation bar padding
            tabs: [
              GButton(
                icon: CupertinoIcons.house,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.square_stack,
                text: 'Notes',
              ),
              GButton(
                icon: CupertinoIcons.chat_bubble_text,
                text: 'NoteBot',
              ),
              GButton(
                icon: CupertinoIcons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
