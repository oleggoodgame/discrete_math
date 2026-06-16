import 'package:discrete_math/shared/theme/style/theme_style.dart';
import 'package:discrete_math/shared/widgets/account_widget.dart';
import 'package:discrete_math/core/settings/presentation/widget/settings_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: sLarge,),
        const AccountHeader(),
        const Spacer(),
        SettingsCardWidget(
          title: "AppInfo",
          subtitle: "You can read what you can create!",
          icon: Icons.output_outlined,
          onTap: () {
            context.push("/app_info");
          },
        ),
        SettingsCardWidget(
          title: "More",
          subtitle: "See other feature",
          icon: Icons.more_horiz,
          onTap: () {
            context.push("/settings/more");
          },
        ),
        SettingsCardWidget(
          title: "Favorites",
          subtitle: "See your favorites",
          icon: Icons.output_outlined,
          onTap: () {
            context.push("/favorites");
          },
        ),
        SettingsCardWidget(
          title: "Sign out",
          subtitle: "Logs out of your current account",
          icon: Icons.output_outlined,
          onTap: () {
            context.go('/login');
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
