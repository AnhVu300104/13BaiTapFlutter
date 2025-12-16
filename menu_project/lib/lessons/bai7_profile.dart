import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_lessons/lessons/bai7_login.dart'; // Đảm bảo đường dẫn import đúng

class ProfileScreen extends StatefulWidget {
  final String accessToken;
  final String refreshToken;

  const ProfileScreen({
    super.key,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/auth/me'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _userData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Không thể tải thông tin người dùng';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi kết nối: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  // --- HÀM XỬ LÝ ĐĂNG XUẤT ĐÃ SỬA ---
  Future<void> _handleLogout() async {
    // 1. Hiển thị Dialog xác nhận và chờ kết quả trả về (true/false)
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) { // Đặt tên biến khác để không nhầm với context của class
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: [
            TextButton(
              onPressed: () {
                // Đóng dialog và trả về false (Hủy)
                Navigator.pop(dialogContext, false); 
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // Đóng dialog và trả về true (Đồng ý)
                Navigator.pop(dialogContext, true); 
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    // 2. Nếu người dùng chọn Đăng xuất (shouldLogout == true)
    if (shouldLogout == true) {
      if (!mounted) return;

      // Hiển thị Loading Dialog
      // Lúc này ta dùng 'context' của ProfileScreen (vì context dialog kia đã đóng rồi)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Giả lập thời gian logout (xóa token, gọi API...)
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      // Đóng Loading Dialog (pop màn hình trên cùng hiện tại)
      Navigator.of(context).pop();

      // Chuyển hướng về Login và xóa sạch lịch sử
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginForm(),
        ),
        (route) => false, // Xóa tất cả các route trước đó
      );

      // Hiển thị thông báo (SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Đã đăng xuất thành công!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trang cá nhân',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Đăng xuất',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _errorMessage = null;
                          });
                          _fetchUserData();
                        },
                        child: const Text('Thử lại'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        // Avatar
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: _userData?['image'] != null
                                ? NetworkImage(_userData!['image'])
                                : null,
                            backgroundColor: Colors.blue,
                            child: _userData?['image'] == null
                                ? const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Full Name
                        Text(
                          '${_userData?['firstName'] ?? ''} ${_userData?['lastName'] ?? ''}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '@${_userData?['username'] ?? ''}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Thông tin cá nhân
                        Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.email, color: Colors.blue),
                                title: const Text('Email'),
                                subtitle: Text(_userData?['email'] ?? 'N/A'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading:
                                    const Icon(Icons.phone, color: Colors.blue),
                                title: const Text('Số điện thoại'),
                                subtitle: Text(_userData?['phone'] ?? 'N/A'),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.location_on,
                                    color: Colors.blue),
                                title: const Text('Địa chỉ'),
                                subtitle: Text(
                                    '${_userData?['address']?['address'] ?? ''}, ${_userData?['address']?['city'] ?? ''}'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Token Information (for debugging)
                        Card(
                          elevation: 3,
                          child: ExpansionTile(
                            leading: const Icon(Icons.vpn_key,
                                color: Colors.blue),
                            title: const Text('Token Information'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text('Access Token:', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(widget.accessToken, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Nút đăng xuất lớn
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text(
                              'Đăng xuất',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _handleLogout,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}