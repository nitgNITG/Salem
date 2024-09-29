import 'dart:io';
import 'dart:ui';
import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/base/profile_controller.dart';
import 'package:al_mariey/app/modules/global_used_widgets/app_bottom_navigation.dart';
import 'package:al_mariey/app/modules/global_used_widgets/widget_methods.dart';
import 'package:al_mariey/app/modules/home/main_app_controller.dart';
import 'package:al_mariey/app/modules/home_page/home_controller.dart';
import 'package:al_mariey/app/modules/login/login_page.dart';
import 'package:al_mariey/app/modules/wallet_recharge/Drafet_SDK/walletRecharge.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/texts.dart';
import '../Wallet/walletScreen.dart';
import '../contact_us/contact_us.dart';
import '../student_profile/profile_page.dart';
import '../wallet_recharge/view/Recharge_Wallet.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();
final TextEditingController TC = TextEditingController();

class HomeMainParentPage extends StatefulWidget {
  HomeMainParentPage({super.key, this.connectivityResult});
  final ConnectivityResult? connectivityResult;

  @override
  State<HomeMainParentPage> createState() => _HomeMainParentPageState();
}

class _HomeMainParentPageState extends State<HomeMainParentPage> {
  final MainAppController controller = MainAppController();

  final HomeController controller2 = HomeController();

  final controller3 = BaseProfileController();

  @override
  void initState() {
    TC.addListener(() {
      if (TC.text == 'CLICKED') {
        setState(() {});
        TC.clear();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (popInvoked) {
          Exit(context);
        },
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          drawerEnableOpenDragGesture: false,
          drawer: Drawer(
            child: !controller2.getIsUserGuest()
                ? FutureBuilder(
                    future: controller3.Student(),
                    builder: (_, s) {
                      if (s.connectionState == ConnectionState.waiting)
                        return Draw(controller3.getLoggedUser());
                      else if (s.connectionState == ConnectionState.done) {
                        LoggedUser lu = s.data!;
                        return Draw(lu);
                      }
                      return Draw(controller3.getLoggedUser());
                    })
                : Container(),
          ),
          body: BaseView<MainAppController>(
            injectedObject: controller,
            connectivityResult: widget.connectivityResult,
            child: Container(
              color: getThemeData(context).colorScheme.background,
              child: Stack(
                children: [
                  getAppPostionedBackground(context),
                  Scaffold(
                    backgroundColor: Colors.white.withOpacity(0),
                    // floatingActionButton: ValueListenableBuilder(
                    //   valueListenable: controller.currentPageIndex,
                    //   builder: (context, index, ch) {
                    //     if (index == 0) {
                    //       return SvgPicture.asset("assets/images/whatsapp_ic.svg")
                    //           .onTap(
                    //         () {
                    //           contactUsWhatsapp();
                    //         },
                    //       );
                    //     } else {
                    //       return const SizedBox();
                    //     }
                    //   },
                    // ),
                    body: PageView.builder(
                      controller: controller.pageViewController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.getIsUserGuest()
                          ? controller.pagesForPageViewForGuest.length
                          : controller.pagesForPageView.length,
                      itemBuilder: (context, index) =>
                          controller.getIsUserGuest()
                              ? controller.pagesForPageViewForGuest[index]
                              : controller.pagesForPageView[index],
                    ),
                    bottomNavigationBar: !controller.getIsUserGuest()
                        ? const AppBottomNavigationBar()
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget Draw(LoggedUser lu) {
    print(lu.token);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: getScreenHeight(context),
              height: getScreenHeight(context) > getScreenWidth(context)
                  ? getScreenHeight(context) * 0.3
                  : getScreenWidth(context) * 0.2,
              color: HexColor('#45474B'),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: getScreenWidth(context) * 0.25,
                        height: getScreenHeight(context) * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(lu.image),
                                fit: BoxFit.fill))),
                    Text(lu.firstName + ' ' + lu.lastName,
                        style: TextStyle(fontFamily: 'Medium', fontSize: 18)),
                    Text(lu.email,
                        style: TextStyle(fontFamily: 'Medium', fontSize: 18))
                  ])),
          Container(
              width: getScreenHeight(context),
              height: getScreenHeight(context) > getScreenWidth(context)
                  ? getScreenHeight(context) * 0.6
                  : getScreenWidth(context) * 0.6,
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    getHeightSpace(10),
                    ListTile(
                        onTap: () {
                          scaffoldKey.currentState!.closeDrawer();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => StudentProfile()));
                        },
                        leading: ImageIcon(
                            AssetImage('assets/images/Subtract.png'),
                            color: kDefaultIconDarkColor,
                            size: 16),
                        title: Text(getL10(context).profile,
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: kDefaultIconDarkColor))),
                    Container(
                        height: 2,
                        width: getScreenWidth(context) * 0.6,
                        color: HexColor('#F4CE14')),
                    ListTile(
                        onTap: () {
                          scaffoldKey.currentState!.closeDrawer();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => Walletscreen()));
                        },
                        leading: ImageIcon(
                            AssetImage('assets/images/wallet.png'),
                            color: kDefaultIconDarkColor,
                            size: 16),
                        title: Text(getL10(context).wallet,
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: kDefaultIconDarkColor))),
                    Container(
                        height: 2,
                        width: getScreenWidth(context) * 0.6,
                        color: HexColor('#F4CE14')),
                    ListTile(
                        onTap: () {
                          scaffoldKey.currentState!.closeDrawer();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => web_recharge(token: lu.token,)));
                        },
                        leading: ImageIcon(
                            AssetImage('assets/images/add-money-wallet-icon.png'),
                            color: kDefaultIconDarkColor,
                            size: 19),
                        title: Text(getL10(context).recharge,
                            style: TextStyle(
                                fontSize: 16,
                                color: kDefaultIconDarkColor,
                                fontFamily: 'Medium',
                                fontWeight: FontWeight.w300))),
                    Container(
                        height: 2,
                        width: getScreenWidth(context) * 0.6,
                        color: HexColor('#F4CE14')),
                    ListTile(
                        onTap: () {
                          scaffoldKey.currentState!.closeDrawer();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ContactUs()));
                        },
                        leading: ImageIcon(
                            AssetImage('assets/images/Vector (6).png'),
                            color: kDefaultIconDarkColor,
                            size: 16),
                        title: Text(getL10(context).contactUs,
                            style: TextStyle(
                                fontSize: 16,
                                color: kDefaultIconDarkColor,
                                fontFamily: 'Medium',
                                fontWeight: FontWeight.w300))),
                    getHeightSpace(
                        getScreenHeight(context) > getScreenWidth(context)
                            ? getScreenHeight(context) * 0.1
                            : getScreenWidth(context) * 0.1),
                    InkWell(
                        onTap: () async {
                          scaffoldKey.currentState!.closeDrawer();
                          // await controller2.getLogout(lu.token!).then((value) async {
                          //   if(value) {
                          //     bool result=   await controller.setIsUserGuest();
                          //     if(result)
                          await SharedPreferencesService.instance.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              routeToPage(LoginPage()), (c) => false);
                          //   }
                          // });
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: HexColor('#F4CE14')),
                            width: getScreenWidth(context) * 0.4,
                            height: getScreenHeight(context) >
                                    getScreenWidth(context)
                                ? getScreenHeight(context) * 0.05
                                : getScreenWidth(context) * 0.05,
                            child: ImageIcon(
                                AssetImage('assets/images/logout.png'),
                                size: getScreenWidth(context) * 0.1,
                                color: HexColor('#45474B')))),
                  ])),
        ]);
  }

  Exit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 1.5,
        ),
        child: AlertDialog(
          backgroundColor: HexColor('#45474B'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          actionsAlignment: MainAxisAlignment.start,
          content: SizedBox(
            height: getScreenHeight(context) * 0.18,
            child: Column(
              children: [
                getHeightSpace(10),
                getNormalText(
                  family: 'Bold',
                  getL10(context).exit,
                  context,
                  color: Colors.white,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 70,
                      height: 40,
                      color: HexColor('#008170'),
                      child: TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          getL10(context).yes,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Bold'),
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      color: HexColor('#F4CE14'),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          getL10(context).cancel,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Bold'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /// اخر حاجه خالص هل تريد الخروج ام لا
      ),
      barrierDismissible: true,
      barrierColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
    );
  }
}
