class DateFormats {
  late String month;
  late String formattedDate;
  List hindiMonths = [
    'जनवरी',
    'फरवरी',
    'मार्च',
    'अप्रैल',
    'मई',
    'जून',
    'जुलाई',
    'अगस्त',
    'सितंबर',
    'अक्टूबर',
    'नवंबर',
    'दिसंबर	'
  ];

  List englishMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December	'
  ];

  List shortMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec	'
  ];

  getFormatDate(date, language) {
    var dateParse = DateTime.parse(date);
    switch (language) {
      case "hindi":
        month = hindiMonths[dateParse.month - 1];
        break;
      case "english":
        month = englishMonths[dateParse.month - 1];
        break;
      case "short":
        month = shortMonths[dateParse.month - 1];
        break;
      default:
        month = hindiMonths[dateParse.month - 1];
    }
    if (language == "short") {
      formattedDate = "${dateParse.day}-$month-${dateParse.year}";
    } else {
      formattedDate = "${dateParse.day} $month ${dateParse.year}";
    }
    // print(dateParse);
    return formattedDate;
  }
}
