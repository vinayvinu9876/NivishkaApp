bool isEmpty(var val) {
    if (val == null) {
      return true;
    }
    if (val.runtimeType == String) {
      if (val.length == 0) {
        return true;
      }
    }

    return false;
}