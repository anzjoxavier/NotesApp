import 'package:flutter/material.dart';
import 'package:simpleproject/services/auth/auth_service.dart';
import 'package:simpleproject/services/crud/notes_service.dart';
import 'dart:developer' as devtools show log;
import '../../constants/route.dart';
import '../../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(newNoteRoute);
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                devtools.log(shouldLogout.toString());
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(LoginRoute, (_) => false);
                }
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text("Logout")),
            ];
          })
        ],
      ),
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                  stream: _notesService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allNotes = snapshot.data as List<DatabaseNotes>;
                          return ListView.builder(
                            itemCount: allNotes.length,
                            itemBuilder: (context, index) {
                              final note = allNotes[index];
                              return ListTile(
                                title:Text(
                                  note.text,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              );
                            },
                          );
                        }else{
                          return const Scaffold(
                            body: Center(child: CircularProgressIndicator()));
                        }
                      default:
                        return const Scaffold(
                            body: Center(child: CircularProgressIndicator()));
                    }
                  });
            default:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure you want to log out"),
          actions: [
            TextButton(
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  return Navigator.of(context).pop(true);
                },
                child: const Text("Sign Out"))
          ],
        );
      }).then((value) => value ?? false);
}