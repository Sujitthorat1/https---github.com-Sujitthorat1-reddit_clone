import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/features/home/delegates/search_community_delegates.dart';
import 'package:reddit_clone/features/home/drawars/community_list_drawer.dart';
import 'package:reddit_clone/features/home/drawars/profile_drawer.dart';
import 'package:reddit_clone/theme/pallet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

    
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends ConsumerState<HomeScreen>{
    // ignore: unused_field
    int _page = 0;


  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
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
      body: Constants.tabWidget[_page],
      
      drawer: const CommunityListDrawer(),
      endDrawer:isGuest ? null : const ProfileDrawer(),
      bottomNavigationBar:isGuest ? null :  CupertinoTabBar(
        backgroundColor:currentTheme.backgroundColor,
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
        ],
        onTap: onPageChanged,
        currentIndex: _page,
      ),
    );
  }

}
    
