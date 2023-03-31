import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'home_view.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class NotesLibrary extends StatefulWidget {
  @override
  _NotesLibraryState createState() => _NotesLibraryState();
}

class _NotesLibraryState extends State<NotesLibrary> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _showSnackBar = false;

  Reference? _fileReference;
  File? _selectedFile;
  bool _isLoading = false;

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
          backgroundColor: Color(0xFF1152FD),
          title: Row(
            children: [
              Text(
                'Notes Library',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(width: 50),
              ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      PlatformFile file = result.files.first;
                      setState(() {
                        _selectedFile = File(file.path!);
                      });

                      //Upload the file to cloud storage
                      String fileName = _selectedFile!.path.split('/').last;
                      Reference storageRef =
                          FirebaseStorage.instance.ref().child(fileName);
                      await storageRef.putFile(_selectedFile!);
                      setState(() {
                        _fileReference = storageRef;
                        _isLoading = false;
                      });
                    }
                  },
                  label: _isLoading ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ): Text('Pick a file'),
                  icon: Icon(Icons.file_upload),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  )),
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
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.0),
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
                child: ListTile(
                  title: Text(document.id),
                  subtitle: Text(document.get('Notes')),
                ),
              );
            },
          );
        });
  }
}
