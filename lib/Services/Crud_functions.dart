import 'package:testttttt/Models/user.dart' as model;

class CrudFunction {
  List visibleRole(model.User user) {
    switch (user.userRole) {
      case "SiteUser":
        return [];
      case "SiteManager":
        return ["SiteUser"];
      case "SiteOwner":
        return ["SiteManager", "SiteUser"];
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

  List visibleRole2(String userRole) {
    switch (userRole) {
      case "SiteUser":
        return [];
      case "SiteManager":
        return ["SiteUser"];
      case "SiteOwner":
        return ["SiteManager", "SiteUser"];
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

  List allChatVisibility(String userRole) {
    switch (userRole) {
      case "SiteUser":
        return ["SiteOwner", "SiteManager", "SiteUser"];
      case "SiteManager":
        return ["SiteOwner", "SiteManager", "SiteUser"];
      case "SiteOwner":
        return ["SiteOwner", "SiteManager", "SiteUser"];
      case "TerminalUser":
        return [
          "AppAdmin",
          "TerminalManager",
          "TerminalUser",
          "SiteOwner",
          "SiteManager",
          "SiteUser"
        ];
      case "TerminalManager":
        return [
          "AppAdmin",
          "TerminalManager",
          "TerminalUser",
          "SiteOwner",
          "SiteManager",
          "SiteUser"
        ];
      case "AppAdmin":
        return [
          "AppAdmin",
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
