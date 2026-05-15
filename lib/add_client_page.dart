import 'package:flutter/material.dart';
import 'package:jarbas_clone/theme.dart';
import 'package:jarbas_clone/category_page.dart';
import 'package:jarbas_clone/observation_page.dart';
import 'package:jarbas_clone/countries.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  bool _isActive = true;
  bool _isAddressExpanded = false;
  bool _isOptionsExpanded = false;
  bool _allowCredit = true;
  
  DateTime? _selectedDate;
  String _selectedCountryCode = '+55';
  String _selectedCountryFlagEmoji = '🇧🇷';
  
  String? _selectedCategory;
  String _observation = '';

  List<Map<String, String>> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = List.from(countriesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.cardBackground, // Darker purple for appbar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Adicionar Cliente', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProfileImage(),
                  const SizedBox(height: 30),
                  _buildMainCard(),
                  const SizedBox(height: 20),
                  _buildAddressCard(),
                  const SizedBox(height: 20),
                  _buildOptionsCard(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xFF00BCD4), // Cyan color
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.image, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTextField('Nome'),
          _buildDivider(),
          _buildSwitchField('Está Ativo?', _isActive, (val) => setState(() => _isActive = val)),
          _buildDivider(),
          _buildTextField('Código', initialValue: '278', readOnly: false), // Made editable
          _buildDivider(),
          _buildPhoneField('Celular'),
          _buildDivider(),
          _buildTextField('Email'),
          _buildDivider(),
          _buildListTileField(
            title: 'Categoria', 
            value: _selectedCategory,
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const CategorySelectionPage()));
              if (result != null) {
                setState(() {
                  _selectedCategory = result as String;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text('Endereço', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: Icon(_isAddressExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white),
            onTap: () => setState(() => _isAddressExpanded = !_isAddressExpanded),
          ),
          if (_isAddressExpanded) ...[
            _buildDivider(),
            _buildTextField('Código Postal', suffixIcon: Icons.my_location),
            _buildDivider(),
            Row(
              children: [
                Expanded(flex: 2, child: _buildTextField('Endereço', showBorderRight: true)),
                Expanded(flex: 1, child: _buildTextField('Número')),
              ],
            ),
            _buildDivider(),
            Row(
              children: [
                Expanded(flex: 2, child: _buildTextField('Complemento', showBorderRight: true)),
                Expanded(flex: 1, child: _buildTextField('Bairro')),
              ],
            ),
            _buildDivider(),
            Row(
              children: [
                Expanded(flex: 2, child: _buildTextField('Cidade', showBorderRight: true)),
                Expanded(flex: 1, child: _buildTextField('Estado')),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildOptionsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text('Opcionais', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            trailing: Icon(_isOptionsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white),
            onTap: () => setState(() => _isOptionsExpanded = !_isOptionsExpanded),
          ),
          if (_isOptionsExpanded) ...[
            _buildDivider(),
            _buildPhoneField('Telefone'),
            _buildDivider(),
            _buildDateField('Data de Nascimento'),
            _buildDivider(),
            _buildTextField('Documento (CPF/CNPJ)'),
            _buildDivider(),
            _buildTextField('RG/IE'),
            _buildDivider(),
            _buildListTileField(
              title: 'Observação',
              value: _observation.isNotEmpty ? _observation : null,
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => ObservationPage(initialObservation: _observation)));
                if (result != null) {
                  setState(() {
                    _observation = result as String;
                  });
                }
              },
            ),
            _buildDivider(),
            _buildSwitchField('Permitir Fiado', _allowCredit, (val) => setState(() => _allowCredit = val)),
            _buildDivider(),
            _buildCreditLimitField(),
          ]
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {String? initialValue, bool readOnly = false, IconData? suffixIcon, bool showBorderRight = false}) {
    return Container(
      decoration: BoxDecoration(
        border: showBorderRight ? const Border(right: BorderSide(color: Colors.white12)) : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (initialValue != null) ...[
            const SizedBox(height: 8),
            Text(hint, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
          TextFormField(
            initialValue: initialValue,
            readOnly: readOnly,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: initialValue == null ? hint : null,
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
              border: InputBorder.none,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.white54) : null,
              contentPadding: initialValue != null ? const EdgeInsets.only(bottom: 8) : const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showCountryPicker,
            child: Row(
              children: [
                Text(_selectedCountryFlagEmoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(_selectedCountryCode, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchField(String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppTheme.accentPurple,
            inactiveThumbColor: Colors.white54,
            inactiveTrackColor: Colors.white12,
          ),
        ],
      ),
    );
  }

  Widget _buildListTileField({required String title, String? value, VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: value != null ? Text(value, style: const TextStyle(color: Colors.white70), maxLines: 1, overflow: TextOverflow.ellipsis) : null,
      trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white54),
      onTap: onTap,
    );
  }

  Widget _buildDateField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppTheme.accentPurple,
                    onPrimary: Colors.white,
                    surface: Color(0xFF221A3B),
                    onSurface: Colors.white,
                  ),
                  dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF221A3B)),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(foregroundColor: AppTheme.accentPurple),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null && picked != _selectedDate) {
            setState(() {
              _selectedDate = picked;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null 
                    ? hint 
                    : "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16, 
                    fontWeight: _selectedDate == null ? FontWeight.bold : FontWeight.normal
                  ),
                ),
              ),
              const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 20),
              if (_selectedDate != null) ...[
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => setState(() => _selectedDate = null),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ] else ...[
                const SizedBox(width: 36),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: const Color(0xFF221A3B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Pesquise pelo nome do país ou código',
                        hintStyle: TextStyle(color: Colors.white54),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.accentPurple)),
                      ),
                      onChanged: (value) {
                        setStateDialog(() {
                          _filteredCountries = countriesData.where((country) {
                            return country['name']!.toLowerCase().contains(value.toLowerCase()) || 
                                   country['code']!.contains(value);
                          }).toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        return ListTile(
                          leading: Text(country['emoji']!, style: const TextStyle(fontSize: 24)),
                          title: Text(country['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(country['code']!, style: const TextStyle(color: Colors.white70)),
                          onTap: () {
                            setState(() {
                              _selectedCountryCode = country['code']!;
                              _selectedCountryFlagEmoji = country['emoji']!;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    ).then((_) {
      // Reset filter when dialog closes
      _filteredCountries = List.from(countriesData);
    });
  }

  Widget _buildCreditLimitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Limite de Crédito', style: TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(height: 4),
          const Text('R\$ 0,00', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Zero para ilimitado', style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: Colors.white12, indent: 16, endIndent: 16);
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.background,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.cardBackground, // Purple
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Colors.white, width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
