
emptyValidation(value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else {
    return null;
  }
}
passwordValidation(value){
  if (value.isEmpty) {
    return 'This field is required';
  }
  if (value.length <=6) {
    return null;
  }

}

phoneValidation(value){

    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

