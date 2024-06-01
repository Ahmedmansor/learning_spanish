import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(DiscoverInitial());

  static DiscoverCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> lyricslist = [
    {
      'english': 'book',
      'espanol': 'libro',
    },
    {
      'english': 'history',
      'espanol': 'historia',
    },
    {
      'english': 'paper',
      'espanol': 'papel',
    },
  ];
}
