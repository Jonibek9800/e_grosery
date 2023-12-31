import 'package:el_grocer/admin_app/main_page/admin_main_page.dart';
import 'package:flutter/material.dart';

import '../widget/auth/auth_widget.dart';
import '../widget/cart_page/cart_page_widget.dart';
import '../widget/checkout_page/checkout_widget.dart';
import '../widget/loader_page/loader_widget.dart';
import '../widget/location_page/confirm_location_widget.dart';
import '../widget/location_page/location_page_widget.dart';
import '../widget/main_page/main_page_widget.dart';
import '../widget/orders_page/order_details_widget.dart';
import '../widget/orders_page/order_page_widget.dart';
import '../widget/product_card/product_card_widget.dart';
import '../widget/products_page/products_by_category_widget.dart';
import '../widget/products_page/products_widget.dart';
import '../widget/profile_page/edit_profile_widget.dart';
import '../widget/profile_page/profile_page_widget.dart';
import '../widget/search_widget/search_widget.dart';

abstract class MainNavigationRouteNames {
  static const adminMainPage = "/admin_main_page";
  static const loaderWidget = "/";
  static const auth = "/auth";
  static const mainPage = "/main_page";
  static const products = "main_page/products";
  static const cartPage = "/cart_page";
  static const checkout = "/cart_page/checkout";
  static const searchPage = "/search_page";
  static const profile = "/profile";
  static const editProfile = "/profile/edit_profile";
  static const allOrders = "profile/orders";
  static const orderDetails = "profile/orders/details";
  static const location = "/location";
  static const confirmLocation = '/location/confirm';
  static const productCard = '/product/product_card';

  static const productByCategory = "/categories/product_by_category";
}

class Routes {
  static Map<String, WidgetBuilder> pathRoutes() {
    return {
      MainNavigationRouteNames.loaderWidget: (_) => const LoaderWidget(),
      MainNavigationRouteNames.auth: (_) => const AuthWidget(),
      MainNavigationRouteNames.mainPage: (_) => const MainPageWidget(),
      MainNavigationRouteNames.products: (_) => const ProductsWidget(),
      MainNavigationRouteNames.cartPage: (_) => const CartPageWidget(),
      MainNavigationRouteNames.searchPage: (_) => const SearchWidget(),
      MainNavigationRouteNames.productByCategory: (_) =>
          const ProductsByCategoryWidget(),
      MainNavigationRouteNames.profile: (_) => const ProfilePageWidget(),
      MainNavigationRouteNames.editProfile: (_) => const EditProfileWidget(),
      MainNavigationRouteNames.checkout: (_) => const CheckoutWidget(),
      MainNavigationRouteNames.allOrders: (_) => const OrdersWidget(),
      MainNavigationRouteNames.orderDetails: (_) => const OrderDetailsWidget(),
      MainNavigationRouteNames.location: (_) => const LocationWidget(),
      MainNavigationRouteNames.confirmLocation: (_) => const ConfirmLocationWidget(),
      MainNavigationRouteNames.productCard: (_) => const ProductCardWidget(),
      MainNavigationRouteNames.adminMainPage: (_) => const AdminMainPageWidget(),
    };
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        MainNavigationRouteNames.loaderWidget, (route) => false);
  }
}
