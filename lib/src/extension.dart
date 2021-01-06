part of dd_extensions;

extension Str on String {
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return 0;
    }
  }

  double toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return 0;
    }
  }

  List<String> toList() => this.split('');

  List<String> toChineseList() {
    // 4e00-9fa5
    return this
        .toList()
        .where(
            (n) => (n.codeUnits.first >= 0x4e00 && n.codeUnits.first <= 0x9fa5))
        .toList();
  }
}

extension Int on int {
  String intToChinese() {
    String str;
    if (this > 99) {
      return this.toString();
    }
    List<String> s1 = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"];
    if (this <= 10) {
      str = s1[this];
    } else {
      String ten = this.toString()[0];
      String bit = this.toString()[1];
      if (bit == "0") {
        str = s1[int.parse(ten)] + s1[10];
      } else if (ten == "1") {
        str = s1[10] + s1[int.parse(bit)];
      } else {
        str = s1[int.parse(ten)] + s1[10] + s1[int.parse(bit)];
      }
    }
    return str;
  }
}
