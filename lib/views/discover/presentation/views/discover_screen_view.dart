import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/views/discover/data/models/aj_hog_model.dart';

import '../../../../core/utils/app_settings.dart';
import '../../../../cubits/single_education_navigate_to/cubit/single_education_navigate_to_cubit.dart';
import '../../data/models/education_item_model.dart';
import 'widgets/aj_hog_coures_sceen.dart';
import 'widgets/alphabet_view.dart';
import 'widgets/song_and_lyrics_in_discover_screen_view.dart';

class DiscoverScreenView extends StatelessWidget {
  const DiscoverScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    var singleEducationNavigateToCubit =
        SingleEducationNavigateToCubit.get(context);
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Discover',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          AppSettings.heightSpace(amountHeight: .01),
          SongsAndLyricsInDiscoverScreenView(
            singleEducationNavigateToCubit: singleEducationNavigateToCubit,
            text: 'Learn with Music 🎵',
            educationItemsmodel: englishSongs,
          ),
          InkWell(
            onTap: () {
              NavigationUtils.goTo(
                  context,
                  AjHogCouresSceen(
                    ajHogListModel: ajHogList,
                    singleEducationNavigateToCubit:
                        singleEducationNavigateToCubit,
                  ));
            },
            child: Container(
              width: double.infinity,
              height: AppSettings.height * .25,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/AJ Hog Power Englishh.png'),
                    fit: BoxFit.fill,
                  )),
            ),
          ).animate().fade(duration: 600.ms).slideY(delay: 100.ms),
          AppSettings.heightSpace(amountHeight: .03),
          const Text(
            'Learn Alpaphet',
            style: TextStyle(
                // color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ).animate().fade(duration: 600.ms).slideY(delay: 100.ms),
          InkWell(
            onTap: () {
              NavigationUtils.goTo(context, const AlphabetView());
            },
            child: Image.asset(
              'assets/images/alphabet.png',
              width: AppSettings.width,
              height: AppSettings.height * .2,
              fit: BoxFit.fill,
            ),
          ).animate().fade(duration: 500.ms).scale(),
          AppSettings.heightSpace(amountHeight: .01),
        ],
      ).animate().fadeIn(duration: 600.ms, curve: Curves.easeIn),
    );
  }
}
