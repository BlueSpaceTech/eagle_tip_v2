// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_print

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/pushNotificationService.dart';
import 'package:testttttt/UI/views/FAQss/FAQLogout.dart';
import 'package:testttttt/UI/views/FAQss/desktopfaq.dart';
import 'package:testttttt/UI/views/FAQss/mainfaq.dart';
import 'package:testttttt/UI/views/auth_handling.dart';

import 'package:testttttt/UI/views/on-borading-tour/final_tour.dart';
import 'package:testttttt/UI/views/on-borading-tour/final_tour_main.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour2.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour3.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour4.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour5.dart';
import 'package:testttttt/UI/views/on-borading-tour/webuser/final_tour_web.dart';
import 'package:testttttt/UI/views/on-borading-tour/welcome_tour.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/Manager/addUserManager.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/Owner/addUserOwner.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/invitation.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/crudmain.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/sent_to.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/newchat.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/createNotification.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/notifications.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/particularNotification.dart';
import 'package:testttttt/UI/views/post_auth_screens/Request%20History/particular_request.dart';
import 'package:testttttt/UI/views/post_auth_screens/Request%20History/request_history.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/dateSelect.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/sites.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/product_request.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/tanks_request.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/addFAQ.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/faqTerminal.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/terminalhome.dart';
import 'package:testttttt/UI/views/post_auth_screens/TermsConditions/displayTerms.dart';
import 'package:testttttt/UI/views/post_auth_screens/TicketHistory/ticketHistory.dart';
import 'package:testttttt/UI/views/post_auth_screens/TicketHistory/ticketHistoryDetail.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/editUser.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/userProfile.dart';
import 'package:testttttt/UI/views/post_auth_screens/about.dart';
import 'package:testttttt/UI/views/post_auth_screens/aboutCompany.dart';
import 'package:testttttt/UI/views/post_auth_screens/desktopSetting.dart';
import 'package:testttttt/UI/views/post_auth_screens/faq.dart';
import 'package:testttttt/UI/views/post_auth_screens/mobilesettings.dart';
import 'package:testttttt/UI/views/post_auth_screens/settings.dart';
import 'package:testttttt/UI/views/pre_auth_screens/create_account.dart';
import 'package:testttttt/UI/views/pre_auth_screens/deciding_screen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/emailsent.dart';
import 'package:testttttt/UI/views/pre_auth_screens/employer_code.dart';
import 'package:testttttt/UI/views/pre_auth_screens/forgetpassword.dart';
import 'package:testttttt/UI/views/pre_auth_screens/login_screen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/splashscreen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/uploadimage.dart';
import 'package:testttttt/UI/views/user_navigator.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging_web/firebase_messaging_web.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'package:testttttt/Utils/InviteCSV.dart';
import 'package:testttttt/amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      storageBucket: "eagle-tip.appspot.com",
      apiKey: "AIzaSyDIaG56XX_XS3SGy06SXmTG8jDFhs1M2O8",
      appId: "1:168073462322:android:364f09407678105ceeb22b",
      messagingSenderId: "168073462322",
      projectId: "eagle-tip",
    ),
  );

  PushNotificationService _pushNotificationService = PushNotificationService();
  _pushNotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  void initState() {
    configureCognitoPlugin();
  }

  Future<void> configureCognitoPlugin() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyStorageS3 storagePlugin = AmplifyStorageS3();

    await Amplify.addPlugins([authPlugin, storagePlugin]);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }

    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          print("USER IS SIGNED IN");
          break;
        case "SIGNED_OUT":
          print("USER IS SIGNED OUT");
          break;
        case "SESSION_EXPIRED":
          print("USER IS SIGNED IN");
          break;
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          //  builder: (context) => UserProvider(),
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eagle Tip',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color(0xff2B343B),
        ),
        // initialRoute: AppRoutes.sentto,
        home: DecidingScreen(),
        routes: {
          AppRoutes.dateRange: (context) => DateSelector(),
          // AppRoutes.test:(context)=>OpenCSV(),
          AppRoutes.mainFaq: (context) => MainFaq(),
          AppRoutes.about: (context) => AboutMobile(),
          AppRoutes.aboutCompany: (context) => AboutCompany(),
          AppRoutes.support: (context) => SupportScreen(),
          AppRoutes.faqLogout: (context) => FAQLogout(),
          // AppRoutes.faq: (context) => FAQScreen(),
          AppRoutes.loginscreen: (context) => LoginScreen(),
          AppRoutes.employercode: (context) => EmployerCode(),
          AppRoutes.bottomNav: (context) => BottomNav(),
          AppRoutes.homeScreen: (context) => HomeScreen(
                showdialog: false,
              ),
          AppRoutes.forgetpass: (context) => ForgetPassword(),
          AppRoutes.mailsent: (context) => EmailSent(),
          AppRoutes.faqTerminal: (context) => TerminalFAQ(),
          AppRoutes.tanksRequest: (context) => TanksRequest(),
          AppRoutes.welcometour: (context) => WelcomeTour(),
          AppRoutes.tour1: (context) => Tour1(),
          AppRoutes.tour2: (context) => Tour2(),
          AppRoutes.tour3: (context) => Tour3(),
          AppRoutes.tour4: (context) => Tour4(),
          AppRoutes.notifications: (context) => Notifications(),
          AppRoutes.tour5: (context) => Tour5(),
          AppRoutes.finaltour: (context) => FinalTour(),
          AppRoutes.ticketHistory: (context) => TicketHistory(),
          AppRoutes.myProfile: (context) => MyProfile(),
          AppRoutes.siteScreen: (context) => Sites(),
          AppRoutes.siteDetails: (context) => SiteDetails(),
          AppRoutes.desktopSetting: (context) => DesktopSetting(),
          AppRoutes.displayTerms: (context) => DisplayTerms(),
          // AppRoutes.settings: (context) => Settings(),
          AppRoutes.mobileSetting: (context) => MobileSetting(),
          AppRoutes.chattingscreen: (context) => ChatScreenn(
                photourlfriend: "",
                photourluser: "",
                currentusername: "",
                friendname: "",
                frienduid: "",
                index: 0,
              ),
          AppRoutes.addUserOwner: (context) => AddNewUserByOwner(),
          AppRoutes.addUserManager: (context) => AddUserByManager(),

          AppRoutes.newchat: (context) => NewChatScreen(),
          // AppRoutes.chattingscreen: (context) => ChatScreenn(),
          AppRoutes.crudscreen: (context) => CrudScreen(),
          AppRoutes.editUser: (context) => EditUser(),
          AppRoutes.useprofile: (context) => UserProfile(
                name: "eerr",
                email: "err",
                dpUrl: "ff",
                phonenumber: "f",
                sites: [],
                userRole: "",
                uid: "",
                fromsentto: true,
              ),
          AppRoutes.splashscreen: (context) => SplashScreen(),
          AppRoutes.createNotification: (context) => CreateNotification(),
          AppRoutes.specificNotification: (context) => SpecificNotification(
              notifyName: "Hurricane Coming!",
              notifyContent:
                  "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. "),
          AppRoutes.webfinaltour: (context) => FinalTourWeb(),
          AppRoutes.messagemain: (context) => MessageMain(
                Chatscreen: ChatScreenn(
                  photourlfriend: "",
                  photourluser: "",
                  currentusername: "",
                  index: 0,
                  friendname: "Start chat by clicking on user",
                  frienduid: "",
                ),
                // photourlfriend: "",
                // photourluser: "",
                // currentusername: "",
                // index: 0,
                // friendname: "Start chat by clicking on user",
                // frienduid: "",
              ),
          // AppRoutes.terminalhome: (context) => TerminalHome(),
          AppRoutes.settings: (context) => Setting(),
          AppRoutes.sentto: (context) => SentTo(),
          AppRoutes.finaltourmain: (context) => FinalTourMain(),
        },
      ),
    );
  }
}
