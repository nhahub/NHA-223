import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      " Ahmad",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildListTile(Icons.person_outline, "Personal Info"),
                  _buildListTile(Icons.favorite_border, "Favorites"),
                  _buildListTile(Icons.shopping_bag_outlined, "Cart"),
                  _buildListTile(Icons.local_shipping_outlined, "Track Orders"),

                  SwitchListTile(
                    title: const Text(
                      "Dark Mode",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    secondary: const Icon(Icons.dark_mode_outlined),
                    value: false,
                    onChanged: (val) {},
                    activeColor: Colors.black,
                  ),
                  _buildListTile(Icons.language_outlined, "Language"),
                  _buildListTile(Icons.credit_card_outlined, "Payment methods"),
                  _buildListTile(Icons.privacy_tip_outlined, "Privacy Policy"),

                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF0A0909),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _BottomNavItem(icon: Icons.home_outlined, label: "Home"),
              _BottomNavItem(icon: Icons.shopping_cart_outlined, label: "Cart"),
              _BottomNavItem(icon: Icons.favorite_border, label: "Favourite"),
              _BottomNavItem(icon: Icons.location_on_outlined, label: "Location"),
              _BottomNavItem(
                  icon: Icons.person, label: "Profile", isActive: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: isActive ? 24 : 22,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}