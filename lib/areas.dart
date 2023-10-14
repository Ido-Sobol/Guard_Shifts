enum Areas { EAST, WEST1, WEST2 }

extension areas on Areas {
  String get message {
    switch (this) {
      case Areas.EAST:
        return "בנימינה מזרח (גב' הפועל, נחלת זבוטינסקי, בית הכרם, מושבה)";
      case Areas.WEST1:
        return "בנימינה מערב 1 (אזור תעשייה, כרמי בנימינה, זערוניה)";
      case Areas.WEST2:
        return "בנימינה מערב 2 (העצמאות שכ' יעקב, נחלת בנימינה)";
      default:
        return "";
    }
  }
}