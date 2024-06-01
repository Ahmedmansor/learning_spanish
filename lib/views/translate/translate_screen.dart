import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/cubits/translation/cubit/translation_cubit.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation'),
        centerTitle: true,
        leading: const Icon(Icons.translate),
      ),
      body: Card(
        margin: const EdgeInsets.all(12),
        child: ListView(padding: const EdgeInsets.all(20), children: [
          const Text('English (US)'),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
                hintText: 'Enter Text ', border: InputBorder.none),
            onChanged: (value) async {
              TranslationCubit.get(context).translate(value);
            },
          ),
          const Divider(
            height: 32,
          ),
          const Text('Espanol '),
          const SizedBox(height: 10),
          BlocBuilder<TranslationCubit, TranslationState>(
            builder: (context, state) {
              return Text(
                TranslationCubit.get(context).translated,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              );
            },
          ),
        ]),
      ),
    );
  }
}
