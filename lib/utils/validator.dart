emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Email is not valid';
  else
    return null;
}

stringValidator(value) {
  if (value.isEmpty) {
    return 'This filed can not be empty';
  }
  return null;
}

nameValidator(value) {
  if (value.isEmpty) {
    return 'Name is required.';
  }
  return null;
}

passwordValidator(value) {
  if (value.length < 8) {
    return 'Password must be min 8 char';
  }
  return null;
}
