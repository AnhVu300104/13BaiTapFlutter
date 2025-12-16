import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'lessons/bai1_helloworld.dart';
import 'lessons/bai2_classroom.dart';
import 'lessons/bai3_layout.dart' as bai3_layout;
import 'lessons/bai4_mypage.dart';
import 'lessons/bai5_changecolor.dart';
import 'lessons/bai6_counter.dart';
import 'lessons/bai7_login.dart';
import 'lessons/bai8_register.dart';
import 'lessons/bai9_bmi.dart';
import 'lessons/bai10_feedback.dart';
import 'lessons/bai11_myplace.dart' as bai11_myplace;
import 'lessons/bai12_product/my_product.dart';
import 'lessons/bai13_news/home_screen.dart' as bai13_news;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lessons',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/AnhVu300104/13BaiTapFlutter');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Nhóm 2 - Đào Anh Vũ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return _buildDesktopLayout(context);
            } else {
              return _buildMobileLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildInfoCard(context),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: _buildLessonsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildInfoCard(context),
          const SizedBox(height: 30),
          _buildLessonsList(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.school,
            size: 80,
            color: Colors.blue.shade600,
          ),
          const SizedBox(height: 15),
          const Text(
            'Flutter Lessons',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Tổng hợp 13 bài tập',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu_book),
            label: const Text(
              'Mở Menu Bài Tập',
              style: TextStyle(fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: _launchGitHub,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.link, color: Colors.blue, size: 18),
                const SizedBox(width: 8),
                const Flexible(
                  child: Text(
                    'Link GitHub Bài Tập',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsList(BuildContext context) {
    final lessons = [
      {'num': '1', 'title': 'Hello World', 'icon': Icons.waving_hand, 'page': const HelloWorldPage()},
      {'num': '2', 'title': 'Classroom', 'icon': Icons.class_, 'page': const Classroom()},
      {'num': '3', 'title': 'Layout Guide', 'icon': Icons.dashboard, 'page': const bai3_layout.HomeScreen()},
      {'num': '4', 'title': 'My Page', 'icon': Icons.article, 'page': const MyHomePage()},
      {'num': '5', 'title': 'Change Color', 'icon': Icons.palette, 'page': const ChangeColorApp()},
      {'num': '6', 'title': 'Counter App', 'icon': Icons.calculate, 'page': const CounterApp()},
      {'num': '7', 'title': 'Login & Profile', 'icon': Icons.login, 'page': const LoginForm()},
      {'num': '8', 'title': 'Register Form', 'icon': Icons.person_add, 'page': const RegisterForm()},
      {'num': '9', 'title': 'BMI Calculator', 'icon': Icons.monitor_weight, 'page': const BMIApp()},
      {'num': '10', 'title': 'Feedback Form', 'icon': Icons.feedback, 'page': const FeedbackForm()},
      {'num': '11', 'title': 'My Place', 'icon': Icons.place, 'page': const bai11_myplace.MyPage()},
      {'num': '12', 'title': 'Product API', 'icon': Icons.shopping_cart, 'page': const MyProduct()},
      {'num': '13', 'title': 'News API', 'icon': Icons.newspaper, 'page': const bai13_news.HomeScreen()},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book, color: Colors.blue.shade700, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Danh Sách Bài Học',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonWrapper(
                          child: lesson['page'] as Widget,
                          lessonTitle: 'Bài ${lesson['num']}: ${lesson['title']}',
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              lesson['num'] as String,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson['title'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Bài ${lesson['num']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          lesson['icon'] as IconData,
                          color: Colors.blue.shade600,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade400,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/AnhVu300104/13BaiTapFlutter');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Flutter Nhóm 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '13 Bài Tập Thực Hành',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.home,
              title: 'Trang Chủ',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            _buildDrawerItem(
              context,
              icon: Icons.waving_hand,
              title: 'Bài 1: Hello World',
              onTap: () => _navigate(context, const HelloWorldPage(), 'Bài 1: Hello World'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.class_,
              title: 'Bài 2: Classroom',
              onTap: () => _navigate(context, const Classroom(), 'Bài 2: Classroom'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.dashboard,
              title: 'Bài 3: Layout Guide',
              onTap: () => _navigate(context, const bai3_layout.HomeScreen(), 'Bài 3: Layout Guide'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.article,
              title: 'Bài 4: My Page',
              onTap: () => _navigate(context, const MyHomePage(), 'Bài 4: My Page'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.palette,
              title: 'Bài 5: Change Color',
              onTap: () => _navigate(context, const ChangeColorApp(), 'Bài 5: Change Color'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.calculate,
              title: 'Bài 6: Counter App',
              onTap: () => _navigate(context, const CounterApp(), 'Bài 6: Counter App'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.login,
              title: 'Bài 7: Login & Profile',
              onTap: () => _navigate(context, const LoginForm(), 'Bài 7: Login & Profile'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person_add,
              title: 'Bài 8: Register Form',
              onTap: () => _navigate(context, const RegisterForm(), 'Bài 8: Register Form'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.monitor_weight,
              title: 'Bài 9: BMI Calculator',
              onTap: () => _navigate(context, const BMIApp(), 'Bài 9: BMI Calculator'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.feedback,
              title: 'Bài 10: Feedback Form',
              onTap: () => _navigate(context, const FeedbackForm(), 'Bài 10: Feedback Form'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.place,
              title: 'Bài 11: My Place',
              onTap: () => _navigate(context, const bai11_myplace.MyPage(), 'Bài 11: My Place'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.shopping_cart,
              title: 'Bài 12: Product API',
              onTap: () => _navigate(context, const MyProduct(), 'Bài 12: Product API'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.newspaper,
              title: 'Bài 13: News API',
              onTap: () => _navigate(context, const bai13_news.HomeScreen(), 'Bài 13: News API'),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: _launchGitHub,
                child: Row(
                  children: [
                    const Icon(Icons.link, color: Colors.blue, size: 20),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'github.com/AnhVu300104/13BaiTapFlutter',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.blue.shade50,
    );
  }

  void _navigate(BuildContext context, Widget page, String title) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonWrapper(
          child: page,
          lessonTitle: title,
        ),
      ),
    );
  }
}

class LessonWrapper extends StatelessWidget {
  final Widget child;
  final String lessonTitle;

  const LessonWrapper({
    super.key,
    required this.child,
    required this.lessonTitle,
  });

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/AnhVu300104/13BaiTapFlutter');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lessonTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          tooltip: 'Về trang chủ',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: _launchGitHub,
            tooltip: 'GitHub Repository',
          ),
        ],
      ),
      body: child,
    );
  }
}