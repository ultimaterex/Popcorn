import 'package:popcorn_companion/models/list_show.dart';
import 'package:popcorn_companion/services/providers/base_view_model.dart';
import 'package:popcorn_companion/services/repositories/network.dart';
import 'package:rxdart/rxdart.dart';


class SearchViewModel extends BaseViewModel {

  List<ListShow> shows = [];


  SearchViewModel() {
    initalize();
  }

  void initalize() {
    searchOnChange
        .debounceTime(Duration(seconds: 1))
        .listen((query) {
      print(query);
    });
  }

  void onchange (query) {
    searchOnChange.add(query);
  }


  // used for hiding related categories while search is true
  bool searchMode = false;
  final searchOnChange = BehaviorSubject<String>();

  search(String query) async {
    searchMode = query.isEmpty ? false : true;
    notifyListeners();

    final result = await NetworkService().search(query);
    shows = result;

    notifyListeners();
    print(result.length);
  }

}