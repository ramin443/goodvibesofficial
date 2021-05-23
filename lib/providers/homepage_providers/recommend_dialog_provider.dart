import 'package:goodvibesoffl/models/tag_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import '../../locator.dart';

class RecommendDialogButtonProvider {
  List<OptionsTag> _tagsList = [];
  List<OptionsTag> _userAlreadySelectedTags = [];
  List<int> _selectedIdList = [];
  bool _hasHasUserChangedTagsSelection = false;

  bool _hasTagsError = false;

  String _tagsError = "";

  selectType(int id) {
    _hasHasUserChangedTagsSelection = true;
    _selectedIdList.add(id);
  }

  unselectType(int id) {
    _hasHasUserChangedTagsSelection = true;
    _selectedIdList.remove(id);
  }

  addIntoSelectedList(List<int> list) {
    _selectedIdList.clear();
    _selectedIdList.addAll(list);
    // print("already selected tags:" + _selectedIdList.toString());
  }

  getTags() async {
    _hasTagsError = false;
    final response = await locator<ApiService>().getAllRecommendTags();
    // print(response);
    if (response == null) {
      _hasTagsError = true;
      _tagsError = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasTagsError = true;
      _tagsError = response["error"];
    } else if (response.containsKey("data")) {
      var data = response["data"] as List;

      _tagsList = data.map<OptionsTag>((e) => OptionsTag.fromJson(e)).toList();
    }
  }

  Future<bool> confirmRecomendTags() async {
    ///TODO: to fix parameters
    final Map response = await locator<ApiService>()
        .postUserSelectedRecomendTags(tagIds: selectedIdList);

    if (response != null && response.containsKey("data")) {
      return true;
    } else
      return false;
  }

  List<OptionsTag> get tagsList => _tagsList;
  List<OptionsTag> get usersAlreadySelectedList => _userAlreadySelectedTags;
  List<int> get selectedIdList => _selectedIdList;

  bool get hasTagsError => _hasTagsError;
  bool get hasHasUserChangedTagsSelection => _hasHasUserChangedTagsSelection;

  String get tagsError => _tagsError;
}

class Tags {
  final int id;
  final String name;
  const Tags({this.id, this.name});
}
