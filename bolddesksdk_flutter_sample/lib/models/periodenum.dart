enum Period { day, week, month }

extension PeriodLabel on Period {
  String get label {
    switch (this) {
      case Period.day:
        return '1D';
      case Period.week:
        return '1W';
      case Period.month:
        return '1M';
    }
  }
}

Period parsePeriod(String v) {
  switch (v.trim().toUpperCase()) {
    case '1W':
      return Period.week;
    case '1M':
      return Period.month;
    case '1D':
    default:
      return Period.day;
  }
}