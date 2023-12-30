extension DateTimeX on DateTime {
  ///Example : 07.11.2020 -  16:20
  String get toStringFormat {
    String returned = "";
    returned += "${day.toString().padLeft(2, "0")}.";
    returned += "${month.toString().padLeft(2, "0")}.";
    returned += "${year.toString().padLeft(4, "0")} - ";
    returned += "${hour.toString().padLeft(2, "0")}:";
    returned += minute.toString().padLeft(2, "0");
    return returned;
  }
}
