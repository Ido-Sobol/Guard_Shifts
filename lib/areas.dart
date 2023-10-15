enum Areas {
  EAST,
  WEST1,
  WEST2;
}

extension Message on Areas {
  String get message => switch (this) {
        Areas.EAST =>
          "בנימינה מזרח (גב' הפועל, נחלת זבוטינסקי, בית הכרם, מושבה)",
        Areas.WEST1 => "בנימינה מערב 1 (אזור תעשייה, כרמי בנימינה, זערוניה)",
        Areas.WEST2 => "בנימינה מערב 2 (העצמאות שכ' יעקב, נחלת בנימינה)",
      };
}

Areas fromNumber(int num) {
  switch (num) {
    case 0:
      return Areas.EAST;
    case 1:
      return Areas.WEST1;
    case 2:
    default:
      return Areas.WEST2;
  }
}
