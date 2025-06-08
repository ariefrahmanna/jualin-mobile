import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_profile/bindings/detail_profile_binding.dart';
import '../modules/detail_profile/views/detail_profile_view.dart';
import '../modules/detailed_item/bindings/detailed_item_binding.dart';
import '../modules/detailed_item/views/detailed_item_view.dart';
import '../modules/edit_account/bindings/edit_account_binding.dart';
import '../modules/edit_account/views/edit_account_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/item_by_category/bindings/item_by_category_binding.dart';
import '../modules/item_by_category/views/item_by_category_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_account/bindings/my_account_binding.dart';
import '../modules/my_account/views/my_account_view.dart';
import '../modules/recently_added/bindings/recently_added_binding.dart';
import '../modules/recently_added/views/recently_added_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/sell_items/bindings/sell_items_binding.dart';
import '../modules/sell_items/views/sell_items_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/term_condition/bindings/term_condition_binding.dart';
import '../modules/term_condition/views/term_condition_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MY_ACCOUNT,
      page: () => const MyAccountView(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.SELL_ITEMS,
      page: () => const SellItemsView(),
      binding: SellItemsBinding(),
    ),
    GetPage(
      name: _Paths.RECENTLY_ADDED,
      page: () => const RecentlyAddedView(),
      binding: RecentlyAddedBinding(),
    ),
    GetPage(
      name: _Paths.TERM_CONDITION,
      page: () => const TermConditionsView(),
      binding: TermConditionBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_BY_CATEGORY,
      page: () => const ItemByCategoryView(),
      binding: ItemByCategoryBinding(),
    ),
    GetPage(
      name: _Paths.DETAILED_ITEM,
      page: () => const DetailedItemView(),
      binding: DetailedItemBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ACCOUNT,
      page: () => const EditAccountView(),
      binding: EditAccountBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PROFILE,
      page: () => const DetailProfileView(),
      binding: DetailProfileBinding(),
    ),
  ];
}
