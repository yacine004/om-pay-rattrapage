import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/om_transaction.dart';
import '../services/auth_service.dart';
import '../services/transaction_service.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Mode { payer, transferer }

class _HomeScreenState extends State<HomeScreen> {
  _Mode _mode = _Mode.payer;
  final _targetController = TextEditingController();
  final _amountController = TextEditingController();
  String? _error;
  bool _hideBalance = false;

  void _onValider() {
    setState(() => _error = null);
    final target = _targetController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());

    if (target.isEmpty || amount == null || amount <= 0) {
      setState(() => _error = 'Veuillez saisir un numéro/code et un montant valides.');
      return;
    }

    try {
      final transactionService = context.read<TransactionService>();
      if (_mode == _Mode.payer) {
        transactionService.payer(target, amount);
      } else {
        transactionService.transferer(target, amount);
      }
      _targetController.clear();
      _amountController.clear();
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  void dispose() {
    _targetController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final transactions = context.watch<TransactionService>().history;
    final firstName = auth.currentUser?.fullName.split(' ').first ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Navigator.of(context).pushNamed('/profile'),
                  ),
                  Container(width: 56, height: 56, color: Colors.white),
                ],
              ),
              Text('Bonjour $firstName', style: const TextStyle(color: OmTheme.textMuted)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    _hideBalance ? '*******' : '${auth.currentUser?.balance.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(width: 6),
                  const Text('FCFA', style: TextStyle(color: OmTheme.orange, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(_hideBalance ? Icons.visibility_off : Icons.visibility,
                        color: OmTheme.textMuted, size: 18),
                    onPressed: () => setState(() => _hideBalance = !_hideBalance),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: OmTheme.card, borderRadius: BorderRadius.circular(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<_Mode>(
                          value: _Mode.payer,
                          groupValue: _mode,
                          activeColor: OmTheme.orange,
                          onChanged: (v) => setState(() => _mode = v!),
                        ),
                        const Text('Payer', style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 16),
                        Radio<_Mode>(
                          value: _Mode.transferer,
                          groupValue: _mode,
                          activeColor: OmTheme.orange,
                          onChanged: (v) => setState(() => _mode = v!),
                        ),
                        const Text('Transférer', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    TextField(
                      controller: _targetController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(hintText: 'Saisir le numéro/code march...'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(hintText: 'Saisir le montant'),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
                    ],
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: _onValider, child: const Text('Valider')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.grid_view, color: OmTheme.orange, size: 18),
                  label: const Text('Accéder à Max it'),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Historique', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Icon(Icons.refresh, color: OmTheme.textMuted),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const Divider(color: OmTheme.border, height: 1),
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    return _TransactionTile(transaction: t);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final OmTransaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM HH:mm');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: OmTheme.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: OmTheme.border),
                ),
                child: const Icon(Icons.attach_money, color: OmTheme.textMuted, size: 18),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.label, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  Text(transaction.target, style: const TextStyle(color: OmTheme.textMuted, fontSize: 13)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('- ${transaction.amount.toStringAsFixed(0)} CFA',
                  style: const TextStyle(color: Colors.redAccent)),
              Text(dateFormat.format(transaction.date),
                  style: const TextStyle(color: OmTheme.textMuted, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
