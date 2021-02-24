enum PrivateType { note, folder }

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
 