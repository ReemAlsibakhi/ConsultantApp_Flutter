import 'package:consultant_app/model/mail/MailFilter.dart';
import 'package:consultant_app/model/status/StatusMail.dart';
import 'package:consultant_app/model/user/User.dart';
import 'package:consultant_app/view/home/home_vm.dart';
import 'package:consultant_app/view/new_inbox/new_inbox_screen.dart';
import 'package:consultant_app/view/search/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/category/Categories.dart';
import '../../model/mail/MailData.dart';
import '../../utils/Constants.dart';
import '../tiles/MailTile.dart';
import '../tiles/StatusTile.dart';
import '../widgets/CustomText.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/MyErrorWidget.dart';
import '../widgets/listView/TagGridList.dart';

class HomeScreen extends StatelessWidget {
  User user;
  HomeScreen({Key? key, required this.user}) : super(key: key);
  List<MailFilter> data = <MailFilter>[];

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeVM>(
      create: (viewModel) => HomeVM(),
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: kPrimaryColor,
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        drawer: _buildNavDrawer(),
        child: Scaffold(
          backgroundColor: kLightWhiteColor,
          body: Container(
            margin: EdgeInsets.only(
              left: 20.h,
              right: 20.h,
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                    elevation: 0,
                    // Set padding and margin to zero
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    stretch: true,
                    pinned: true,
                    backgroundColor: kLightWhiteColor,
                    title: _buildAppBar(
                      context,
                    )),
                SliverToBoxAdapter(
                    child: Consumer<HomeVM>(builder: (context, viewModel, _) {
                  switch (viewModel.statusMain.status) {
                    case Status.LOADING:
                      print("Status :: LOADING");
                      return LoadingWidget();
                    case Status.ERROR:
                      print("Status :: ERROR ");
                      return MyErrorWidget(
                          viewModel.statusMain.message ?? "NA");
                    case Status.COMPLETED:
                      print("Status :: COMPLETED");
                      return _getStatusGridView(
                          viewModel.statusMain.data!.status!);
                    default:
                  }
                  return Container();
                })),
                SliverToBoxAdapter(
                  child: Consumer<HomeVM>(
                    builder: (context, viewModel, _) {
                      switch (viewModel.catMain.status) {
                        case Status.LOADING:
                          print("Cat :: LOADING");
                          return LoadingWidget();
                        case Status.ERROR:
                          print("Cat :: ERROR ");
                          return MyErrorWidget(
                              viewModel.catMain.message ?? "NA");
                        case Status.COMPLETED:
                          print("Cat :: COMPLETED");
                          getMailsByCat(viewModel);
                          return _getMailsList(data);
                        default:
                      }
                      return Container();
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Consumer<HomeVM>(builder: (context, viewModel, _) {
                    switch (viewModel.tagsMain.status) {
                      case Status.LOADING:
                        print("tagsMain :: LOADING");
                        return LoadingWidget();
                      case Status.ERROR:
                        print("tagsMain :: ERROR ");
                        return MyErrorWidget(
                            viewModel.tagsMain.message ?? "NA");
                      case Status.COMPLETED:
                        print("tagsMain :: COMPLETED");
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: CustomText(
                                'Tags',
                                18.sp,
                                'Poppins',
                                kBlackColor,
                                FontWeight.w600,
                              ),
                            ),
                            // Text('Tags',style: TextStyle(fontFamily:'Poppins', fontSize:20,color: kBlackColor ,fontWeight:  FontWeight.w600,))
                            TagGridList(viewModel.tagsMain.data!.tags!),
                          ],
                        );
                      default:
                    }
                    return Container();
                  }),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(context),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _handleMenuButtonPressed,
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
            valueListenable: _advancedDrawerController,
            builder: (_, value, __) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Container(
                  key: ValueKey<bool>(value.visible),
                  child: value.visible
                      ? Image.asset(
                          'images/clear.png',
                          width: 20.w,
                          height: 20.h,
                        )
                      : Image.asset('images/menu.png'),
                ),
              );
            },
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            )
          },
          child: Container(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.search,
              color: kBlackColor,
              size: 20.w,
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: PopUpMenu(
            menuList: _buildMenuList(context),
            icon: CircleAvatar(
              radius: 23,
              backgroundImage: NetworkImage(user.image ??
                  'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  List<PopupMenuEntry<dynamic>> _buildMenuList(BuildContext context) {
    return [
      PopupMenuItem(
          child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: CircleAvatar(
            radius: 45.0,
            backgroundImage: NetworkImage(user.image ??
                'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
      )),
      PopupMenuItem(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            color: kBlackColor),
        child: Center(child: Text(user.name! ?? '')),
      ),
      PopupMenuItem(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            color: kLightBlackColor),
        child: Center(child: Text(user.role!.name! ?? '')),
      ),
      const PopupMenuDivider(),
      PopupMenuItem(
          child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(
          'English',
          style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              color: kLightBlackColor,
              fontWeight: FontWeight.w400),
        ),
      )),
      PopupMenuItem(
          onTap: () {
            context.read<HomeVM>().logOut(context);
          },
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  color: kLightBlackColor,
                  fontWeight: FontWeight.w400),
            ),
          )),
    ];
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
            isScrollControlled: true,
            backgroundColor: kLightWhiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.w)),
            context: context,
            builder: (BuildContext context) {
              return NewInboxScreen();
            });
      },
      child: Container(
        height: 57.h,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: kNavBottomColor, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: kLightPrimaryColor,
                radius: 13,
                child: Image(
                  image: AssetImage('images/add.png'),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              CustomText('New Inbox', 18.sp, 'Poppins', kLightPrimaryColor,
                  FontWeight.w600),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavDrawer() {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildDrawerHeader(),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins'),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Profile',
                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins')),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.people_rounded),
                title: Text('Senders',
                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins')),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Users management',
                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins')),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: 128.0,
      height: 128.0,
      margin: const EdgeInsets.only(
        top: 24.0,
        bottom: 64.0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'images/logo2.png',
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Future<List<MailFilter>> getMailsByCat(HomeVM viewModel) async {
    data = <MailFilter>[];
    List<Categories> cats = viewModel.catMain.data!.categories!;
    List<MailData> mails = viewModel.mailMain.data!.mails!.data!;
    List<MailData> tmp = [];
    for (int i = 0; i < cats.length; i++) {
      for (int j = 0; j < mails.length; j++) {
        if (mails[j].sender!.category!.name == cats[i].name) tmp.add(mails[j]);
      }
      data.add(MailFilter(cats[i].name!, tmp));
      tmp = [];
    }
    return data;
  }

  Widget _getMailsList(List<MailFilter> data) {
    if (data.isEmpty) {
      return CustomText(
          'Not found data', 14.sp, 'Poppins', kDarkGreyColor, FontWeight.w400);
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 16.h),
        itemBuilder: (BuildContext context, int idx) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              // this.text, this.size, this.fontFamily, this.color, this.fontWeight
              title: CustomText(
                  data[idx].title, 20, 'Poppins', kBlackColor, FontWeight.w600),
              backgroundColor: Colors.transparent,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: data[idx].children.length,
                  itemBuilder: (context, index) {
                    return MailTile(data[idx].children[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 0,
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _getStatusGridView(List<StatusMail> statusList) {
    if (statusList.isEmpty) {
      return CustomText(
          'Not found data', 12.sp, 'Poppins', kDarkGreyColor, FontWeight.w400);
    }
    return GridView.builder(
      padding: EdgeInsets.only(top: 16.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statusList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.75,
      ),
      itemBuilder: (context, position) => StatusTile(statusList[position]),
    );
  }
}

class PopUpMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMenu({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
