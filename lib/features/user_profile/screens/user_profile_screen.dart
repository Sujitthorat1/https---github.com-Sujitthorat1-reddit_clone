import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/post_card.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({required this.uid, super.key});

  void navigateToEditUser(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            user.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 45,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(20),
                          child: OutlinedButton(
                            onPressed: () => navigateToEditUser(context),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic),
                          radius: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'u/${user.name}',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "${user.karma} karma",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ])),
                  )
                ];
              },
              body: ref.watch(getUserPostsProvider(uid)).when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final post = data[index];
                        return PostCard(
                          post: post,
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString());
                    }
                    return ErrorText(error: error.toString());
                  },
                  loading: () => const Loader()),
            ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
