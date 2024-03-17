enum ClassMode { online, physical }

extension ClassModeX on ClassMode {
  String get nameString {
    switch (this) {
      case ClassMode.online:
        return "Online";
      case ClassMode.physical:
        return "Physical";
    }
  }

  static ClassMode getClassModeFromName(String name) {
    switch (name) {
      case "Online":
        return ClassMode.online;
      case "Physical":
        return ClassMode.physical;
      default:
        throw ArgumentError("Invalid class mode name: $name");
    }
  }
}

enum ClassType { recurring, oneOff }

extension ClassTypeX on ClassType {
  String get nameString {
    switch (this) {
      case ClassType.recurring:
        return "Recurring";
      case ClassType.oneOff:
        return "One-off";
    }
  }

  static ClassType getClassTypeFromName(String name) {
    switch (name) {
      case "Recurring":
        return ClassType.recurring;
      case "One-off":
        return ClassType.oneOff;
      default:
        throw ArgumentError("Invalid class type name: $name");
    }
  }
}

enum ClassFrequency { daily, weekly }

extension ClassFrequencyX on ClassFrequency {
  String get nameString {
    switch (this) {
      case ClassFrequency.daily:
        return "Daily";
      case ClassFrequency.weekly:
        return "Weekly";
    }
  }

  static ClassFrequency getClassFrequencyFromName(String name) {
    switch (name) {
      case "Daily":
        return ClassFrequency.daily;
      case "Weekly":
        return ClassFrequency.weekly;
      default:
        throw ArgumentError("Invalid class frequency name: $name");
    }
  }
}
