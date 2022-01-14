enum PrivateType { note, folder }
enum VerifyType { note, folder }
enum VerifyMode { view, edit, remove }

extension PrivateTypeIndex on PrivateType {
  // Overload the [] getter to get the name of the fruit.
  operator [](String key) => (name) {
        switch (name) {
          case 'note':
            return PrivateType.note;
          case 'folder':
            return PrivateType.folder;
          default:
            throw RangeError("enum contains no value '$name'");
        }
      }(key);
}

extension VerifyModeIndex on VerifyMode {
  // Overload the [] getter to get the name of the fruit.
  operator [](String key) => (name) {
        switch (name) {
          case 'view':
            return VerifyMode.view;
          case 'edit':
            return VerifyMode.edit;
          case 'remove':
            return VerifyMode.remove;
          default:
            throw RangeError("enum contains no value '$name'");
        }
      }(key);
}
