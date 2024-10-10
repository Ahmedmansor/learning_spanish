import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/core/utils/app_settings.dart';
import 'package:learning_spanish/core/utils/navigation.dart';
import 'package:learning_spanish/repos/colors.dart';
import 'package:learning_spanish/views/settings/presentation/views/widgets/settings_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../cubits/settings/cubit/settings_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../layout/cubit/layout_cubit.dart';
import '../../../../repos/shared_pref_helper.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                BlocBuilder<LayoutCubit, LayoutState>(
                  builder: (context, state) {
                    return Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: LayoutCubit.get(context).isDark
                              ? Colors.grey[900]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          SettingsItem(
                            text: 'Voices',
                            icon: FontAwesomeIcons.microphone,
                            widget: const Icon(
                              FontAwesomeIcons.chevronRight,
                              color: kMainColor,
                            ),
                            onTap: () {
                              showMaterialModalBottomSheet(
                                backgroundColor: Colors.black,
                                context: context,
                                builder: (context) {
                                  return SafeArea(
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child: Text('Voices',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                        AppSettings.heightSpace(
                                            amountHeight: .03),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: LayoutCubit.get(context)
                                                        .isDark
                                                    ? Colors.grey[900]
                                                    : Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: BlocBuilder<SettingsCubit,
                                                      SettingsState>(
                                                  builder: (context, state) {
                                                return ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Divider(
                                                      height: 1,
                                                    );
                                                  },
                                                  itemCount: context
                                                      .read<SettingsCubit>()
                                                      .realVoices
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return VoiceItemBuilder(
                                                      index: index,
                                                    );
                                                  },
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const Divider(
                            height: 1,
                          ),
                          SettingsItem(
                            text: 'Dark Mode',
                            icon: FontAwesomeIcons.lightbulb,
                            widget: Switch(
                              value: LayoutCubit.get(context).isDark,
                              onChanged: (value) {
                                LayoutCubit.get(context).changeTheme();
                              },
                              activeColor: kMainColor,
                            ),
                            onTap: null,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VoiceItemBuilder extends StatelessWidget {
  const VoiceItemBuilder({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    var settingsCubit = context.read<SettingsCubit>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          settingsCubit.setVoice(context.read<SettingsCubit>().voices[index]);
          NavigationUtils.offScreen(context);
          //When Click on Particular voice the check icon show
          settingsCubit.isSelectedVoiceItemFun(index);
          //save selected voice
          CachMemory.insertIntToCachMemory(
              key: 'selectedVoiceIndex', value: index);
        },
        child: ListTile(
          title: Text(
            settingsCubit.realVoices[index].name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                VoicePropertityWidget(
                  text: settingsCubit.realVoices[index].sex,
                ),
                AppSettings.widthSpace(
                  amountWidth: 0.01,
                ),
                VoicePropertityWidget(
                  text: settingsCubit.realVoices[index].location,
                ),
              ],
            ),
          ),
          trailing: SizedBox(
            width: AppSettings.width * .2,
            child: Row(
              children: [
                Icon(FontAwesomeIcons.circleCheck,
                    color: settingsCubit.isSelectedVoiceItem == index
                        ? kMainColor
                        : Colors.transparent),
                IconButton(
                    onPressed: () {
                      context.read<SettingsCubit>().setVoice(
                          context.read<SettingsCubit>().voices[index]);

                      settingsCubit.setSpeed(0.5);
                      settingsCubit.speak('How you doin, dude?');

                      settingsCubit.isSelectedVoiceItemFun(index);
                      //save selected voice
                      CachMemory.insertIntToCachMemory(
                          key: 'selectedVoiceIndex', value: index);

                      //save selected voice to just color the icon after restart app
                      CachMemory.insertIntToCachMemory(
                          key: 'isSelectedVoiceItem', value: index);
                    },
                    icon: const Icon(Icons.record_voice_over_outlined)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VoicePropertityWidget extends StatelessWidget {
  const VoicePropertityWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
          color: kMainColor, borderRadius: BorderRadius.circular(50)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
