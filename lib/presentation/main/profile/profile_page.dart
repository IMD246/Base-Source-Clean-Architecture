import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/presentation/main/profile/profile_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfileModel, ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, ProfileModel model) {
    return const Scaffold(
      body: Center(
        child: Text("Profile page"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}