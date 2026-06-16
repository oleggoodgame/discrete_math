import 'package:discrete_math/core/settings/presentation/widget/settings_card_widget.dart';
import 'package:discrete_math/shared/theme/widget/theme_switch_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("More")),
      body: Column(
        children: [
          ThemeSwitchWidget(title: "Change Theme", subtitle: "You can oparate with Theme in app"),
          SettingsCardWidget(
            title: "Bag/Report",
            subtitle:
                "Please let us know if you find any bugs or recommend something to add.",
            icon: Icons.add_comment_outlined,
            onTap: () async {
              final uri = Uri(
                scheme: 'mailto',
                path: 'oleggludyn09@gmail.com',
                queryParameters: {
                  'subject': 'Bug Report',
                  'body': 'Please describe the issue here.',
                },
              );

              if (!await canLaunchUrl(uri)) return;

              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
          ),
          // SettingsCardWidget(
          //   title: "GitHub",
          //   subtitle: "You can see project in github",
          //   icon: Icons.account_tree_rounded,
          //   onTap: () async {
          //     final uri = Uri.tryParse(
          //       "https://github.com/oleggoodgame/discrete_math",
          //     );

          //     if (uri == null) return;

          //     await launchUrl(uri, mode: LaunchMode.externalApplication);
          //   },
          // ),
          SettingsCardWidget(
            title: "Delete Account",
            subtitle: "Delete all your information",
            icon: Icons.delete,
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;

              await user!.delete();
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
