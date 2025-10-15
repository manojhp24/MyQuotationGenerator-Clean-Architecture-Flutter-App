enum States {
  andhraPradesh,
  arunachalPradesh,
  assam,
  bihar,
  chhattisgarh,
  goa,
  gujarat,
  haryana,
  himachalPradesh,
  jammuAndKashmir,
  jharkhand,
  karnataka,
  kerala,
  madhyaPradesh,
  maharashtra,
  manipur,
  meghalaya,
  mizoram,
  nagaland,
  odisha,
  punjab,
  rajasthan,
  sikkim,
  tamilNadu,
  telangana,
  tripura,
  uttarPradesh,
  uttarakhand,
  westBengal,
  andamanAndNicobarIslands,
  chandigarh,
  dadraAndNagarHaveliAndDamanAndDiu,
  delhi,
  lakshadweep,
  puducherry,
}

extension StatesExtension on States {
  String get displayName {
    switch (this) {
      case States.andhraPradesh:
        return "Andhra Pradesh";
      case States.arunachalPradesh:
        return "Arunachal Pradesh";
      case States.assam:
        return "Assam";
      case States.bihar:
        return "Bihar";
      case States.chhattisgarh:
        return "Chhattisgarh";
      case States.goa:
        return "Goa";
      case States.gujarat:
        return "Gujarat";
      case States.haryana:
        return "Haryana";
      case States.himachalPradesh:
        return "Himachal Pradesh";
      case States.jammuAndKashmir:
        return "Jammu & Kashmir";
      case States.jharkhand:
        return "Jharkhand";
      case States.karnataka:
        return "Karnataka";
      case States.kerala:
        return "Kerala";
      case States.madhyaPradesh:
        return "Madhya Pradesh";
      case States.maharashtra:
        return "Maharashtra";
      case States.manipur:
        return "Manipur";
      case States.meghalaya:
        return "Meghalaya";
      case States.mizoram:
        return "Mizoram";
      case States.nagaland:
        return "Nagaland";
      case States.odisha:
        return "Odisha";
      case States.punjab:
        return "Punjab";
      case States.rajasthan:
        return "Rajasthan";
      case States.sikkim:
        return "Sikkim";
      case States.tamilNadu:
        return "Tamil Nadu";
      case States.telangana:
        return "Telangana";
      case States.tripura:
        return "Tripura";
      case States.uttarPradesh:
        return "Uttar Pradesh";
      case States.uttarakhand:
        return "Uttarakhand";
      case States.westBengal:
        return "West Bengal";
      case States.andamanAndNicobarIslands:
        return "Andaman & Nicobar Islands";
      case States.chandigarh:
        return "Chandigarh";
      case States.dadraAndNagarHaveliAndDamanAndDiu:
        return "Dadra & Nagar Haveli and Daman & Diu";
      case States.delhi:
        return "Delhi";
      case States.lakshadweep:
        return "Lakshadweep";
      case States.puducherry:
        return "Puducherry";
    }
  }
}

