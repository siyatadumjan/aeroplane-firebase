import 'package:aeroplane/ui/pages/profile/profilePage.dart';
import 'package:aeroplane/ui/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:aeroplane/cubit/page_cubit.dart';
import 'package:aeroplane/ui/pages/home_page.dart';
import 'package:aeroplane/ui/widgets/custom_bottom_navigation_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';
import 'MybookingPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const TransactionPage();
        case 2:
          return const SettingPage();
        case 3:
          return const UserProfile();
        default:
          return const HomePage();
      }
    }

    Widget customBottomNavigation() {
      return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
            decoration: BoxDecoration(
                color: kWhiteColor, borderRadius: BorderRadius.circular(18)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBottomNavigationItem(
                  index: 0,
                  imageUrl: 'assets/icon_home.png',
                ),
                CustomBottomNavigationItem(
                  index: 1,
                  imageUrl: 'assets/icon_booking.png',
                ),
                CustomBottomNavigationItem(
                  index: 2,
                  imageUrl: 'assets/icon_card.png',
                ),
                CustomBottomNavigationItem(
                  index: 3,
                  imageUrl: 'assets/icon_settings.png',
                ),
              ],
            ),
          ));
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              customBottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
