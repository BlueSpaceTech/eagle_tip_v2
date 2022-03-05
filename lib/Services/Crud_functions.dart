import 'package:testttttt/Models/user.dart' as model;

class CrudFunction {
  List visibleRole(model.User user) {
    switch (user.userRole) {
      case "SiteUser":
        return [];
      case "SiteManager":
        return ["SiteUser"];
      case "SiteOwner":
        return ["SiteManager, Site User"];
      case "TerminalUser":
        return ["SiteOwner, SiteManager", "SiteUser"];
      case "TerminalManager":
        return ["TerminalUser", "SiteOwner", "SiteManager", "SiteUser"];
      case "AppAdmin":
        return [
          "TerminalManager",
          "TerminalUser",
          "SiteOwner",
          "SiteManager",
          "SiteUser"
        ];
      case "SuperAdmin":
      return [
        "AppAdmin",
          "TerminalManager",
          "TerminalUser",
          "SiteOwner",
          "SiteManager",
          "SiteUser"
        ];
    }
    return [];
  }
}
