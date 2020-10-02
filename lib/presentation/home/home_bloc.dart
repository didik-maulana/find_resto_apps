import 'package:find_resto/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {

  final _tabSelected = BehaviorSubject<int>();
  Stream<int> get tabSelectedStream => _tabSelected.stream;

  void setTabSelected(int tabSelected) {
    _tabSelected.sink.add(tabSelected);
  }

  @override
  void dispose() {
    _tabSelected.close();
  }
}