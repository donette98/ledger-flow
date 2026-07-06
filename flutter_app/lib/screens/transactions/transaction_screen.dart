import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_colors.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add transaction screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textTertiary,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          // Tab Bar
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Income'),
              Tab(text: 'Expense'),
            ],
          ),
          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionList(),
                _buildIncomeList(),
                _buildExpenseList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildTransactionCard(
          title: ['Salary', 'Groceries', 'Electricity', 'Internet'][index % 4],
          category: [
            'Income',
            'Food & Dining',
            'Utilities',
            'Utilities'
          ][index % 4],
          amount: ['+3500', '-50', '-120', '-30'][index % 4],
          date: ['Today', 'Yesterday', '3 days ago', '1 week ago'][index % 4],
          isExpense: index % 4 != 0,
          delay: 100 + (index * 50),
        );
      },
    );
  }

  Widget _buildIncomeList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildTransactionCard(
          title: ['Salary', 'Freelance', 'Bonus', 'Refund', 'Interest'][index],
          category: ['Income', 'Income', 'Income', 'Income', 'Income'][index],
          amount: ['+3500', '+200', '+500', '+25', '+10'][index],
          date: ['Today', 'Yesterday', '3 days ago', '1 week ago', '2 weeks ago'][index],
          isExpense: false,
          delay: 100 + (index * 50),
        );
      },
    );
  }

  Widget _buildExpenseList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildTransactionCard(
          title: ['Groceries', 'Electricity', 'Internet', 'Gas', 'Entertainment'][index],
          category: ['Food & Dining', 'Utilities', 'Utilities', 'Transport', 'Entertainment'][index],
          amount: ['-50', '-120', '-30', '-25', '-45'][index],
          date: ['Today', 'Yesterday', '3 days ago', '1 week ago', '2 weeks ago'][index],
          isExpense: true,
          delay: 100 + (index * 50),
        );
      },
    );
  }

  Widget _buildTransactionCard({
    required String title,
    required String category,
    required String amount,
    required String date,
    required bool isExpense,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isExpense
                  ? AppColors.error.withOpacity(0.1)
                  : AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isExpense ? Icons.arrow_downward : Icons.arrow_upward,
              color: isExpense ? AppColors.error : AppColors.success,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$$amount',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isExpense ? AppColors.error : AppColors.success,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 600.ms)
        .slideX(begin: 0.2, end: 0);
  }
}
