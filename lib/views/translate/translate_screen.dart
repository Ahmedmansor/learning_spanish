import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_spanish/cubits/translation/cubit/translation_cubit.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = TranslationCubit.get(context);
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Translation'),
        centerTitle: true,
        leading: const Icon(Icons.translate),
      ),
      body: BlocBuilder<TranslationCubit, TranslationState>(
        builder: (context, state) {
          return _translationBody(cubit, context);
        },
      ),
    );
  }

  Card _translationBody(TranslationCubit cubit, BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomRow(
              text: cubit.from == 'en' ? 'English' : 'Espanol',
              onPressed: () {
                cubit.swapLanguages();
              },
              icon: Icons.swap_horiz_outlined),
          const SizedBox(height: 10),
          TextField(
            maxLines: 2,
            controller: cubit.textEditingController,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: cubit.translated == ''
                        ? null
                        : () {
                            cubit.clear();
                          },
                    icon: const Icon(Icons.highlight_remove_rounded)),
                hintText: cubit.from == 'en' ? 'Enter Text' : 'Ingrese Texto',
                border: InputBorder.none),
            onChanged: (text) async {
              TranslationCubit.get(context)
                  .translate(text, cubit.from, cubit.to);
            },
          ),
          const Divider(
            height: 32,
          ),
          CustomRow(
            text: cubit.to == 'es' ? 'Espanol' : 'English',
            icon: Icons.copy,
            onPressed: cubit.translated == ''
                ? null
                : () {
                    cubit.copyToClipBoard();
                  },
          ),
          const SizedBox(height: 10),
          Text(
            cubit.translated,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  final String text;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 40,
            ))
      ],
    );
  }
}
