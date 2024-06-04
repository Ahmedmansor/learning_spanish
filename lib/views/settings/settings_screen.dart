import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/settings/cubit/settings_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Change Voice'),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                      return ListView.builder(
                        itemCount: context.read<SettingsCubit>().voices.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(context
                                .read<SettingsCubit>()
                                .voices[index]['name']),
                            onTap: () {
                              context.read<SettingsCubit>().setVoice(
                                  context.read<SettingsCubit>().voices[index]);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    });
                  },
                );
              },
              child: const Text('Change to Female Voice'),
            ),
          ],
        ),
      ),
    );
  }
}
