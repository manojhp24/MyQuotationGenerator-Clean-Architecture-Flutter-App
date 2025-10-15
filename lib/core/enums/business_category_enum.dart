enum BusinessCategory{
  woodWorks,
  electrical,
  plumbing,
  birthdayEvents,
}

extension BusinessCategoryExtension on BusinessCategory{
  String get displayName{
    switch (this) {
      case BusinessCategory.woodWorks:
        return "Wood works/Furniture's";
      case BusinessCategory.electrical:
        return "Electrical";
      case BusinessCategory.plumbing:
        return "Plumbing";
      case BusinessCategory.birthdayEvents:
        return "Birthday Decorations/Event Planning";
    }
  }
}