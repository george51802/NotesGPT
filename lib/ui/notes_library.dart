import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/ui/settings_view.dart';
import '../chatgpt/chatpage.dart';
import 'navigation_bar.dart';
import 'home_view.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class NotesLibrary extends StatefulWidget {
  @override
  _NotesLibraryState createState() => _NotesLibraryState();
}

class EditNoteView extends StatefulWidget {
  final String? noteId;
  final String? noteContent;

  EditNoteView({this.noteId, this.noteContent});

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  TextEditingController _noteTitleController = TextEditingController();
  TextEditingController _noteContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      _noteTitleController.text = widget.noteId!;
    }
    if (widget.noteContent != null) {
      _noteContentController.text = widget.noteContent!;
    }
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1152FD),
        title: Text(
          widget.noteId == null ? 'Add Note' : 'Edit Note',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String noteTitle = _noteTitleController.text;
              String noteContent = _noteContentController.text;

              if (noteTitle.isNotEmpty && noteContent.isNotEmpty) {
                // Save the note to Firestore
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('Notes')
                    .doc(noteTitle)
                    .set({'Notes': noteContent});

                // Go back to the previous screen
                Navigator.pop(context);
              }
            },
            icon: Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _noteTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noteContentController,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotesLibraryState extends State<NotesLibrary> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _showSnackBar = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchText = '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1152FD),
          title: Row(
            children: [
              Text(
                'Notes Library',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 147, 178, 255),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Icon(CupertinoIcons.search,
                        color: Colors.white, size: 20),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchText = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12.5),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchText = '';
                            });
                          },
                          icon: Icon(CupertinoIcons.multiply_circle_fill,
                              color: Colors.white, size: 20),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNoteView(),
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color(0xff1152FD),
        ),
        body: _buildNotesList(),
      ),
    );
  }

  Widget _buildNotesList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('Notes')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final filteredNotes = snapshot.data!.docs.where((note) {
            final noteTitle = note.id.toLowerCase();
            final noteContent = note.get('Notes').toLowerCase();
            return noteTitle.contains(_searchText) ||
                noteContent.contains(_searchText);
          }).toList();
          filteredNotes.sort((a, b) {
            final aTitleMatches =
                a.id.toLowerCase().contains(_searchText) ? 1 : 0;
            final bTitleMatches =
                b.id.toLowerCase().contains(_searchText) ? 1 : 0;
            final aContentMatches =
                a.get('Notes').toLowerCase().contains(_searchText) ? 1 : 0;
            final bContentMatches =
                b.get('Notes').toLowerCase().contains(_searchText) ? 1 : 0;
            final aMatchScore = aTitleMatches + aContentMatches;
            final bMatchScore = bTitleMatches + bContentMatches;
            return bMatchScore.compareTo(aMatchScore);
          });
          return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              itemCount: filteredNotes.length,
              itemBuilder: (BuildContext context, int index) {
                final document = filteredNotes[index];
                return Dismissible(
                  key: Key(document.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) async {
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Notes')
                        .doc(document.id)
                        .delete();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0).withOpacity(
                                0.05), // set the color and opacity of the glow
                            spreadRadius:
                                5, // set the spread radius of the glow
                            blurRadius: 10, // set the blur radius of the glow
                            offset: Offset(0, 0), // set the offset of the glow
                          ),
                        ]),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 13),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        document.id,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          document.get('Notes'),
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNoteView(
                              noteId: document.id,
                              noteContent: document.get('Notes'),
                            ),
                          ),
                        );
                        CustomNavigationBar(
                          selectedIndex: 0,
                          onTabChange: (index) {
                            // ChatBot Page
                            if (index == 2) {
                              // Assuming ChatBot button is at index 2
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(),
                                ),
                              );
                            }
                            // Notes Library Page
                            else if (index == 1) {
                              // Assuming Notes Library button is at index 1
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesLibrary(),
                                ),
                              );
                            }
                            // Profile Page
                            else if (index == 3) {
                              // Assuming Profile button is at index 3
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserSettingsView(),
                                ),
                              );
                            }
                            // Home Page
                            else {
                              // Assuming Home button is at index 0
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeView(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              });
        });
  }
}
