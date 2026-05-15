import 'package:flutter/material.dart';
import 'package:jarbas_clone/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildMenuGrid(),
            _buildExpandToggle(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Pesquise por ajuda e ações...',
            hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.white54),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: const Text(
                  '+9',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuGrid() {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Venda Rápida', 'icon': Icons.shopping_cart_outlined},
      {'title': 'Clientes', 'icon': Icons.people_outline},
      {'title': 'Produtos /\nServiços', 'icon': Icons.local_offer_outlined},
      {'title': 'Pedidos', 'icon': Icons.shopping_basket_outlined},
      {'title': 'Financeiro', 'icon': Icons.attach_money_outlined},
      {'title': 'Crediário', 'icon': Icons.receipt_long_outlined},
      {'title': 'Controle de\nCaixa', 'icon': Icons.point_of_sale_outlined},
      {'title': 'Estatísticas', 'icon': Icons.show_chart_outlined},
      {'title': 'Catálogo\nOnline', 'icon': Icons.cloud_outlined},
      {'title': 'Usuários', 'icon': Icons.group_outlined},
      {'title': 'Ajuda', 'icon': Icons.help_outline},
      {'title': 'Ajustes', 'icon': Icons.settings_outlined},
    ];

    final int visibleCount = _isExpanded ? menuItems.length : 6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: visibleCount,
        itemBuilder: (context, index) {
          return _buildGridItem(menuItems[index]);
        },
      ),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item['icon'], size: 32, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            item['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandToggle() {
    return IconButton(
      icon: Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
      iconSize: 30,
      color: Colors.white54,
      onPressed: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: AppTheme.background,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomNavItem(Icons.list_alt, 'Pedidos'),
            _buildBottomNavItem(Icons.people_outline, 'Clientes'),
            const SizedBox(width: 40), // Space for FAB
            _buildBottomNavItem(Icons.local_offer_outlined, 'Produtos'),
            _buildBottomNavItem(Icons.attach_money_outlined, 'Financeiro'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      backgroundColor: AppTheme.accentPurple,
      onPressed: _showAddMenu,
      child: const Icon(Icons.add, size: 30, color: Colors.white),
    );
  }

  void _showAddMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF221A3B), // Dark background for the sheet
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Novo', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Pedidos', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildPrimaryButton(Icons.shopping_bag_outlined, 'Novo Pedido', Colors.purpleAccent)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildPrimaryButton(Icons.shopping_cart_outlined, 'Venda Rápida', Colors.purpleAccent)),
                ],
              ),
              const SizedBox(height: 25),
              const Text('Cadastro', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCircularAction(Icons.attach_money, 'Transação', const Color(0xFF00B894)), // Green
                  _buildCircularAction(Icons.person_add_alt_1, 'Cliente', const Color(0xCCD63031)), // Pinkish/Purple
                  _buildCircularAction(Icons.sell, 'Produto /\nServiço', const Color(0xFFFF7675)), // Orange
                  _buildCircularAction(Icons.dashboard_customize, 'Categoria', const Color(0xFFB2BEC3)), // Brown/Grey
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton(IconData icon, String label, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCircularAction(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 75,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppTheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem(Icons.home_outlined, 'Home'),
          _buildDrawerItem(Icons.shopping_cart_outlined, 'Venda Rápida'),
          _buildDrawerItem(Icons.people_outline, 'Clientes'),
          _buildDrawerItem(Icons.list_alt, 'Pedidos'),
          _buildDrawerItem(Icons.point_of_sale_outlined, 'Controle de Caixa', isPremium: true),
          _buildDrawerItem(Icons.local_offer_outlined, 'Produtos / Serviços'),
          _buildDrawerItem(Icons.calendar_month_outlined, 'Agenda'),
          _buildDrawerItem(Icons.attach_money_outlined, 'Financeiro'),
          _buildDrawerItem(Icons.receipt_long_outlined, 'Crediário'),
          _buildDrawerItem(Icons.show_chart_outlined, 'Estatísticas'),
          _buildDrawerItem(Icons.cloud_outlined, 'Catálogo Online'),
          _buildDrawerItem(Icons.group_outlined, 'Usuários'),
          _buildDrawerItem(Icons.settings_outlined, 'Configurações'),
          _buildDrawerItem(Icons.help_outline, 'Ajuda'),
          _buildDrawerItem(Icons.exit_to_app, 'Sair'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF381568), // Slightly lighter purple for drawer header
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.greenAccent, width: 2),
              color: Colors.white,
            ),
            child: const Center(
              child: Icon(Icons.shopping_bag, color: Colors.purple, size: 30), // Placeholder logo
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Suas Variedades',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Suas Variedades',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Pro',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {bool isPremium = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 24),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: isPremium
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PREMIUM',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          : null,
      onTap: () {
        // Handle navigation here
      },
    );
  }
}
