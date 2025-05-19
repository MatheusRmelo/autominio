import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';

class AppBarLogo extends StatelessWidget implements PreferredSizeWidget {
  const AppBarLogo({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return AppBar(
        title: Text(title ?? 'MyVoice'),
        centerTitle: true,
      );
    }
    return AppBar(
      leading: Text(
        'MyVoice',
        style: GoogleFonts.oi(fontSize: 24),
      ),
      actions: [CircleAvatar()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
