import 'package:flutter/material.dart';
import 'package:task_27_03/pages/edit_profile_page.dart';
import 'package:task_27_03/pages/my_orders_page.dart';
import 'package:task_27_03/pages/splash_screen.dart';
import 'package:task_27_03/views/all_review_view.dart';
import 'package:task_27_03/views/bottom_navigation.dart';

import '../pages/about_us_page.dart';
import '../pages/add_details_page.dart';
import '../pages/add_new_address_page.dart';
import '../pages/category_page.dart';
import '../pages/chatting_page.dart';
import '../pages/contact_us_page.dart';
import '../pages/help_&_faq_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/manage_address_page.dart';
import '../pages/notification_page.dart';
import '../pages/otp_page.dart';
import '../pages/privacy_policy_page.dart';
import '../pages/product_details_page.dart';
import '../pages/product_listing.dart';
import '../pages/rate_app_page.dart';
import '../pages/recent_chat_page.dart';
import '../pages/store_details_page.dart';
import '../pages/store_details_reviews_page.dart';
import '../pages/terms_page.dart';
import '../pages/view_cart_page.dart';
import '../pages/walk_through_screens.dart';

class MyRouter {
  static const String root = "/";
  static const String loginPage = "/login_page";
  static const String editProfile = "/edit_profile_page";
  static const String walkThrough = "/walk_through_screens";
  static const String detailsPage = "/add_details_page";
  static const String bottomNavigation = "/bottom_navigation";
  static const String homePage = "/home_page";
  static const String otpPage = "/otp_page";
  static const String storeDetailsPage = "/store_details_page";
  static const String storeDetailsReviewPage = "/store_details_reviews";
  static const String categoryPage = "/category_page";
  static const String productList = "/product_listing";
  static const String productDetails = "/product_details_page";
  static const String myOrders = "/my_orders_page";
  static const String manageAddress = "/manage_address_page";
  static const String addNewAddress = "/add_new_address_page";
  static const String notification = "/notification_page";
  static const String viewCart = "/view_cart_page";
  static const String terms = "/terms_page";
  static const String help = "/help_&_faq_page";
  static const String aboutUs = "/about_us_page";
  static const String policy = "/privacy_policy_page";
  static const String contact = "/contact_us_page";
  static const String rateApp = "/rate_app_page";
  static const String allReview = "/all_review_view";
  static const String recentChat = "/recent_chat_page";
  static const String chatPage = "/chatting_page";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget page = SplashScreen();
    switch (settings.name) {
      case root:
        page = SplashScreen();
        break;
      case walkThrough:
        page = WalkThroughScreen();
        break;
      case loginPage:
        page = LoginPage();
        break;
      case detailsPage:
        page = DetailsPage();
        break;
      case homePage:
        page = HomePage();
        break;
      case addNewAddress:
        page = AddNewAddressPage();
        break;
      case bottomNavigation:
        page = HomeBottomNavigationBar();
        break;
      case otpPage:
        page = OtpPage();
        break;
      case manageAddress:
        page = ManageAddressPage();
        break;
      case storeDetailsPage:
        page = StoreDetails();
        break;
      case storeDetailsReviewPage:
        page = StoreDeatilsReview();
        break;
      case categoryPage:
        page = CategoryPage();
        break;
      case productList:
        page = ProductListing();
        break;
      case productDetails:
        page = ProductDetails();
        break;
      case myOrders:
        page = MyOrdersPage();
        break;
      case editProfile:
        page = EditProfilePage();
        break;
      case notification:
        page = NotificationPage();
        break;
      case viewCart:
        page = ViewCartPage();
        break;
      case terms:
        page = TermsAndConditionsPage();
        break;
      case rateApp:
        page = RateAppPage();
        break;
      case help:
        page = HelpAndFaqPage();
        break;
      case aboutUs:
        page = AboutUsPage();
        break;
      case policy:
        page = PrivacyPolicyPage();
        break;
      case contact:
        page = ContactUsPage();
        break;
      case allReview:
        page = AllReviewPage();
        break;
      case recentChat:
        page = RecentChatPage();
        break;
      case chatPage:
        page = ChattingPage();
        break;
    }
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        body: Center(
          child: Text("Route Not Found !!"),
        ),
      ),
    );
  }
}
