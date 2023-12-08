import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/features/home/delegates/search_community_delegates.dart';
import 'package:reddit_clone/features/home/drawars/community_list_drawer.dart';
import 'package:reddit_clone/features/home/drawars/profile_drawer.dart';
import 'package:reddit_clone/theme/pallet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: false,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => displayDrawer(context),
                icon: const Icon(Icons.menu));
          }),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: SearchCommunityDelegate(ref));
                },
                icon: const Icon(Icons.search)),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () => displayEndDrawer(context),
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic),
                ),
              );
            }),
          ],
        ),
        body: Center(
          child: Text(user.name),
        ),
        drawer: const CommunityListDrawer(),
        endDrawer: const ProfileDrawer(),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: currentTheme.backgroundColor,
          activeColor: currentTheme.iconTheme.color,
          items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: '',
          ),
        ]));
  }
}
