import 'package:goodvibesoffl/models/tag_model.dart';
import 'package:goodvibesoffl/services/api_service.dart';

import '../../locator.dart';
import '../../utils/strings/string_constants.dart';

class WhatBringYouHereProvider {
  List<OptionsTag> _optionsList = [];
  List<int> _selectedList = [];
  bool _hasSelected = false;
  bool _hasError = false;
  String error = "";

  setSelected(bool value) {
    _hasSelected = value;
  }

  selectOption(id) {
    _selectedList.add(id);
  }

  unselectOption(id) {
    _selectedList.remove(id);
  }

  getAllChoices() async {
    _hasError = false;

    final Map response = await locator<ApiService>().getWhatBringsYouOptions();
    // print(response);
    if (response == null) {
      _hasError = true;
      error = some_error_occured;
    } else if (response.containsKey("error")) {
      _hasError = true;
      error = response["error"];
    } else if (response.containsKey("data")) {
      var rsp = response["data"] as List;

      _optionsList =
          rsp.map<OptionsTag>((e) => OptionsTag.fromJson(e)).toList();

      // print(_optionsList);
    }
  }

  clearLists() {
    _optionsList.clear();
    _selectedList.clear();
  }

  addAllIntoSelectedList(List<int> list) {
    _selectedList.addAll(list);
  }

  postChoicesToApi() async {
    final response = await locator<ApiService>()
        .postWhatBringsYouHereOptions(options: _selectedList);
  }

  List get selectedList => _selectedList;
  List<OptionsTag> get optionsList => _optionsList;

  bool get hasSelected => _hasSelected;
  bool get hasError => _hasError;
}
