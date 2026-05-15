import 'package:flutter/material.dart';
import 'package:jarbas_clone/theme.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text('Produtos', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'Itens'),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Estoque'),
                  SizedBox(width: 4),
                  Icon(Icons.warning, size: 14, color: Colors.purpleAccent),
                ],
              ),
            ),
            Tab(text: 'Categorias'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildItemsTab(),
          _buildStockTab(),
          _buildCategoriesTab(),
        ],
      ),
    );
  }

  Widget _buildItemsTab() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: _isGridView ? _buildGridItems() : _buildListItems(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white54),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Pesquisar em todos os itens',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view, color: Colors.white),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildListItems() {
    final List<Map<String, String>> items = [
      {'name': 'Adaptador de pendrive para Celular', 'cat': 'Acessórios para Celular', 'price': 'R\$ 30,00'},
      {'name': 'Airfryer #05', 'cat': 'Pequenos Eletrodomésticos', 'price': 'R\$ 550,00'},
      {'name': 'Airfryer #08', 'cat': 'Preparação de Alimentos', 'price': 'R\$ 675,00'},
      {'name': 'Alianças Douradas', 'cat': 'Anéis e Alianças', 'price': 'R\$ 40,00'},
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          children: [
            if (index == 0) _buildSectionHeader('A'),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: const Icon(Icons.image, color: Colors.white54),
              ),
              title: Text(item['name']!, style: const TextStyle(color: Colors.white, fontSize: 16)),
              subtitle: Text(item['cat']!, style: const TextStyle(color: Colors.white54, fontSize: 14)),
              trailing: Text(item['price']!, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const Divider(color: Colors.white10, indent: 72),
          ],
        );
      },
    );
  }

  Widget _buildGridItems() {
    final List<Map<String, String>> items = [
      {'name': 'Adaptador de pendrive...', 'price': 'R\$ 30,00'},
      {'name': 'Airfryer #05', 'price': 'R\$ 550,00'},
      {'name': 'Airfryer #08', 'price': 'R\$ 675,00'},
      {'name': 'Alianças Douradas', 'price': 'R\$ 40,00'},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item['price']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.accentPurple,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(item['name']!.substring(0, 2).toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF2D264C),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                ),
                child: Text(
                  item['name']!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStockTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _buildStockCard('Total em estoque', 'R\$ 0,00', 'Custo: R\$ 0,00', const Color(0xFF4B39EF)),
              const SizedBox(width: 16),
              _buildStockCard('nenhum item', 'em estoque', '', const Color(0xFF9E1F63)),
            ],
          ),
          const SizedBox(height: 24),
          _buildAlertsSection(),
        ],
      ),
    );
  }

  Widget _buildStockCard(String title, String mainValue, String subValue, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 8),
            const Text('R\$ 0,00', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            if (subValue.isNotEmpty) Text(subValue, style: const TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsSection() {
    return Column(
      children: [
        Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Alertas', style: TextStyle(color: Colors.white, fontSize: 18)),
            Spacer(),
            Text('1', style: TextStyle(color: Colors.white70)),
            Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.inventory_2_outlined, color: Colors.redAccent),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sem estoque', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('3 itens', style: TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(12)),
                child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesTab() {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Acessórios para Celular', 'icon': 'AC', 'color': Colors.redAccent},
      {'name': 'Cabos de Celular', 'icon': 'CC', 'color': Colors.blueGrey},
      {'name': 'Carcaças, Capas e Protetores', 'icon': 'CP', 'color': Colors.teal},
      {'name': 'Carregadores', 'icon': 'Ca', 'color': Colors.orange},
    ];

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: cat['color'],
            child: Text(cat['icon'], style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
          title: Text(cat['name'], style: const TextStyle(color: Colors.white, fontSize: 16)),
          trailing: const Icon(Icons.edit, color: Colors.white54, size: 20),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.black12,
      child: Text(title, style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
    );
  }
}
