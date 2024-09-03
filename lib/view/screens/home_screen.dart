import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/home_screen_controller.dart';
import 'package:sntr_mobile_banking_user_app/data/logged_in_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/send_money_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/transaction_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int flag = 0;
  int beforeTransaction = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final List<Image> serviceIcons = [
    Image.asset("assets/icons/send_money.png"),
    Image.asset("assets/icons/money_withdraw.png"),
    Image.asset("assets/icons/update_profile.png"),
    Image.asset("assets/icons/transaction.png"),
    Image.asset("assets/icons/pay_bill.png"),
    Image.asset("assets/icons/loan.png"),
    Image.asset("assets/icons/savings.png"),
    Image.asset("assets/icons/agent.png"),
    Image.asset("assets/icons/contact_us.png"),
  ];
  final List<String> serviceNames = [
    "Send Money",
    "Withdraw Money",
    "Update Profile",
    "Transactions",
    "Pay Bill",
    "Get Loan",
    "Savings",
    "Our Agents",
    "Contact Us",
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeScreenController>().getHomeScreenData();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('brand_icon');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAccountBalanceSection(),
          buildServiceList(),
        ],
      ),
    );
  }

  Widget buildServiceList() {  //agile
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(18), topLeft: Radius.circular(18)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const AppLogo(),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: serviceIcons.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const SendMoneyScreen());
                            break;
                          case 1:
                            break;
                          case 2:
                            break;
                          case 3:
                            Get.to(() => const TransactionScreen());
                            break;
                          case 4:
                            break;
                          case 5:
                            break;
                          case 6:
                            break;
                          case 7:
                            break;
                          case 8:
                            break;
                        }
                      },
                      child: buildServiceCard(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildServiceCard(int index) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.orange,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 6),
            SizedBox(
              height: 50,
              width: 50,
              child: serviceIcons[index],
            ),
            index != 1 ? const SizedBox(height: 10) : const SizedBox(height: 0),
            Text(
              index == 1 ? "   Money\nWithdraw" : serviceNames[index],
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountBalanceSection() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "   Account Balance",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textHeightBehavior: TextHeightBehavior(
              applyHeightToLastDescent: false,
              applyHeightToFirstAscent: false,
            ),
          ),
          StreamBuilder(
            stream: firebaseFirestore.collection("user_account_balance").doc(LoggedInUserData.userAccount).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              LoggedInUserData.accountBalance = int.parse(snapshot.data?.get("balance") ?? "0");
              if (flag == 0 || flag == 1) {
                flag++;
              } else {
                _showNotificationOnTransaction();
              }
              beforeTransaction = LoggedInUserData.accountBalance;
              return Text(
                "৳ " "${snapshot.data?.get("balance") ?? "0"}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                ),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToLastDescent: false,
                  applyHeightToFirstAscent: false,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: GetBuilder<HomeScreenController>(
        builder: (homeScreenController) {
          if (homeScreenController.inProgress) {
            return const CircularProgressIndicator();
          }
          return _buildAppBarLeading(
            userEmail: homeScreenController.homeScreenDataModel.userEmail ?? "error",
            userName: homeScreenController.homeScreenDataModel.accountUserId ?? "error",
            profileImageUrl: homeScreenController.homeScreenDataModel.profileImageUrl ?? "",
          );
        },
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Image.asset(
              "assets/icons/logout.png",
            ),
          ),
        ),
      ],
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.orange,
      ),
    );
  }

  Widget _buildAppBarLeading({required String userName, required String userEmail, required String profileImageUrl}) {
    return Row(
      children: [
        CircleAvatar(
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: profileImageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.lightGreenAccent,
              ),
            ),
            Text(
              userEmail,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showNotificationOnTransaction() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      beforeTransaction > LoggedInUserData.accountBalance ? 'Send Money' : "Receive Money",
      beforeTransaction > LoggedInUserData.accountBalance
          ? 'Amount ${beforeTransaction - LoggedInUserData.accountBalance}'
          : 'Amount ${LoggedInUserData.accountBalance - beforeTransaction}',
      platformChannelSpecifics,
      payload: 'item id 2',
    );
  }
}
