import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/auth/provider/auth_provider.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';
import 'package:optiguard/shared/widget/button.dart';
import 'package:optiguard/shared/widget/list_tile.dart';

class ListMenu {
  final String title;
  final IconData icon;
  final Function()? onTap;

  ListMenu(this.title, this.icon, this.onTap);
}

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Profil Saya',
          backgroundColor: AppColors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          iconColor: Colors.white,
        ),
        body: _widgetContent(context, ref));
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: AppColors.blue,
            height: 200,
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 148),
              child: Column(
                children: [
                  _bodyAccount(context),
                  const SizedBox(height: 24),
                  _bodyGeneral(context),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomElevatedButton(
                      title: 'Keluar',
                      icon: Icons.logout,
                      color: Colors.red[700],
                      onPressed: () async {
                        await authNotifier.logout();
                        if (context.mounted) {
                          GoRouter.of(context).go(SignInRoute.path);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _bodyBanner(context),
        ],
      ),
    );
  }

  Widget _bodyGeneral(BuildContext context) {
    final List<ListMenu> listMenu = [
      ListMenu('Pusat bantuan', Icons.help, () {}),
      ListMenu('Tentang OptiGuard', Icons.info, () {}),
    ];

    // Define a function to generate the list with dividers
    List<Widget> generateListTiles() {
      final tiles = <Widget>[];
      for (var i = 0; i < listMenu.length; i++) {
        tiles
          ..add(
            CustomListTile(
              title: listMenu[i].title,
              icon: listMenu[i].icon,
              onTap: listMenu[i].onTap,
            ),
          )
          ..add(Divider(
            height: 1,
            color: Colors.grey[300],
            indent: 54,
          ));
      }
      return tiles;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Umum',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
        Column(
          children: generateListTiles(),
        ),
      ],
    );
  }

  Widget _bodyAccount(BuildContext context) {
    final List<ListMenu> listMenu = [
      ListMenu('Profil saya', Icons.person, () {}),
      ListMenu('Kelola akun', Icons.gpp_maybe, () {}),
      ListMenu('Notifikasi', Icons.notifications, () {}),
      ListMenu('Bahasa', Icons.language, () {}),
    ];

    // Define a function to generate the list with dividers
    List<Widget> generateListTiles() {
      final tiles = <Widget>[];
      for (var i = 0; i < listMenu.length; i++) {
        tiles
          ..add(
            CustomListTile(
              title: listMenu[i].title,
              icon: listMenu[i].icon,
              onTap: listMenu[i].onTap,
            ),
          )
          ..add(Divider(
            height: 1,
            color: Colors.grey[300],
            indent: 54,
          ));
      }
      return tiles;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Akun',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
        Column(
          children: generateListTiles(),
        ),
      ],
    );
  }

  Widget _bodyBanner(BuildContext context) {
    return Positioned(
      top: 25,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('assets/avatar_example.png'),
            ),
          ),
          SizedBox(height: 10),
          Text('Tiara Sabrina',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Pasien',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
