import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';

class AddModsScreens extends ConsumerStatefulWidget {
  final String name;
  const AddModsScreens({required this.name, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModsScreensState();
}

class _AddModsScreensState extends ConsumerState<AddModsScreens> {
  Set<String> uids = {};
  int ctr = 0;

  void addUids(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUids(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()=> saveMods(),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => ListView.builder(
                itemCount: community.members.length,
                itemBuilder: (context, index) {
                  final member = community.members[index];
                  return ref.watch(getUserDataProvider(member)).when(
                      data: (user) {
                        if (community.mods.contains(member) && ctr == 0) {
                          uids.add(member);
                        }
                        ctr++;
                        return CheckboxListTile(
                          value: uids.contains(user.uid),
                          onChanged: (val) {
                            if (val!) {
                              addUids(user.uid);
                            } else {
                              removeUids(user.uid);
                            }
                          },
                          title: Text(user.name),
                        );
                      },
                      error: ((error, stackTrace) => ErrorText(
                            error: error.toString(),
                          )),
                      loading: () => const Loader());

                  // return CheckboxListTile(
                  //   value: true,
                  //   onChanged: (val) {},
                  //   title: Text(member),
                  // );
                },
              ),
          error: ((error, stackTrace) => ErrorText(
                error: error.toString(),
              )),
          loading: () => const Loader()),
    );
  }
}
