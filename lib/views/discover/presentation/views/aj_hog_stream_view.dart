import 'package:flutter/material.dart';
import 'package:learning_spanish/views/discover/presentation/views/widgets/tab_bat_item.dart';

import '../../../../core/utils/app_settings.dart';
import '../../../../repos/colors.dart';

class AjHogStreamView extends StatefulWidget {
  const AjHogStreamView(
      {super.key,
      required this.title,
      required this.mainSubtitleFile,
      required this.vocabSubtitleFile,
      required this.msSubtitleFile,
      required this.povSubtitleFile,
      required this.mainSubtitleAudioFile,
      required this.vocabSubtitleAudioFile,
      required this.msSubtitleAudioFile,
      this.povSubtitleAudioFile});
  final String? title;
  final String? mainSubtitleFile;
  final String? vocabSubtitleFile;
  final String? msSubtitleFile;
  final String? povSubtitleFile;
  final String? mainSubtitleAudioFile;
  final String? vocabSubtitleAudioFile;
  final String? msSubtitleAudioFile;
  final String? povSubtitleAudioFile;
  @override
  State<AjHogStreamView> createState() => _AjHogStreamViewState();
}

Future<String> detectLanguage(String word) async {
  if (word.contains(RegExp(r'[a-zA-Z]'))) {
    return 'en'; // English
  } else {
    return 'ar'; // Arabic
  }
}

class _AjHogStreamViewState extends State<AjHogStreamView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    debugPrint('povSubtitleFile: ${widget.povSubtitleFile}'); // Add this line
    _tabController = TabController(
      length: widget.povSubtitleFile == null ? 3 : 4,
      vsync: this,
      initialIndex: 0,
    );
    debugPrint('TabController length: ${_tabController!.length}');
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'srt file ${widget.mainSubtitleFile} , audio ${widget.mainSubtitleAudioFile}');
    print(
        'srt file ${widget.vocabSubtitleFile} , audio ${widget.vocabSubtitleAudioFile}');

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffF4F4F5),
                borderRadius: BorderRadius.circular(20)),
            height: AppSettings.height * 0.05,
            width: AppSettings.width,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: kMainColor,
              dividerColor: Colors.transparent,
              // indicatorWeight: 10,

              splashBorderRadius: BorderRadius.circular(20),
              tabs: [
                const Tab(
                  text: 'Main',
                ),
                const Tab(text: 'Vocab'),
                const Tab(text: 'MS'),
                if (widget.povSubtitleFile != null) const Tab(text: 'Pov'),
              ],
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppSettings.heightSpace(amountHeight: 0.03),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  TabBatItem(
                    subtitleFile: widget.mainSubtitleFile!,
                    audioFile: widget.mainSubtitleAudioFile!,
                  ),
                  TabBatItem(
                    subtitleFile: widget.vocabSubtitleFile!,
                    audioFile: widget.vocabSubtitleAudioFile!,
                  ),
                  TabBatItem(
                    subtitleFile: widget.msSubtitleFile!,
                    audioFile: widget.msSubtitleAudioFile!,
                  ),
                  if (widget.povSubtitleFile != null)
                    TabBatItem(
                      subtitleFile: widget.povSubtitleFile!,
                      audioFile: widget.povSubtitleAudioFile!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
