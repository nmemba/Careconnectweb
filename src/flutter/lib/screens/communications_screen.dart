import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../config/theme.dart';

class CommunicationsScreen extends StatefulWidget {
  const CommunicationsScreen({super.key});

  @override
  State<CommunicationsScreen> createState() => _CommunicationsScreenState();
}

class _CommunicationsScreenState extends State<CommunicationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String? templateText) {
    final message = templateText ?? _messageController.text;
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message sent: $message'),
          backgroundColor: AppTheme.successColor,
        ),
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppTheme.grayBg,
      appBar: AppBar(
        title: const Text('Messages'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Contacts'),
            Tab(text: 'Templates'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Contacts Tab
          ListView(
            padding: EdgeInsets.all(isLandscape ? 12 : 16),
            children: [
              ...appProvider.contacts.map((contact) {
                return Padding(
                  padding: EdgeInsets.only(bottom: isLandscape ? 8 : 12),
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        _showMessageDialog(context, contact.name, appProvider, isLandscape);
                      },
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
                      child: Padding(
                        padding: EdgeInsets.all(isLandscape ? 12 : 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: isLandscape ? 20 : 24,
                              backgroundColor: AppTheme.primaryLight,
                              child: Text(
                                contact.name[0],
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isLandscape ? 16 : 18,
                                ),
                              ),
                            ),
                            SizedBox(width: isLandscape ? 12 : 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contact.name,
                                    style: TextStyle(
                                      fontSize: isLandscape ? 14 : 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    contact.role,
                                    style: TextStyle(
                                      fontSize: isLandscape ? 12 : 14,
                                      color: AppTheme.grayMedium,
                                    ),
                                  ),
                                  if (contact.phone != null) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      contact.phone!,
                                      style: TextStyle(
                                        fontSize: isLandscape ? 11 : 12,
                                        color: AppTheme.grayLight,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppTheme.grayLight,
                              size: isLandscape ? 20 : 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          
          // Templates Tab
          ListView(
            padding: EdgeInsets.all(isLandscape ? 12 : 16),
            children: [
              Text(
                'Quick Message Templates',
                style: TextStyle(
                  fontSize: isLandscape ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.grayMedium,
                ),
              ),
              SizedBox(height: isLandscape ? 8 : 12),
              
              ...appProvider.messageTemplates.map((template) {
                return Padding(
                  padding: EdgeInsets.only(bottom: isLandscape ? 8 : 12),
                  child: Card(
                    child: InkWell(
                      onTap: () => _sendMessage(template.text),
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
                      child: Padding(
                        padding: EdgeInsets.all(isLandscape ? 12 : 16),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(isLandscape ? 8 : 10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.message_outlined,
                                color: AppTheme.primaryColor,
                                size: isLandscape ? 18 : 20,
                              ),
                            ),
                            SizedBox(width: isLandscape ? 12 : 16),
                            Expanded(
                              child: Text(
                                template.text,
                                style: TextStyle(
                                  fontSize: isLandscape ? 13 : 14,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.send,
                              color: AppTheme.primaryColor,
                              size: isLandscape ? 18 : 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  void _showMessageDialog(
    BuildContext context,
    String contactName,
    AppProvider appProvider,
    bool isLandscape,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message $contactName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                ),
              ),
              SizedBox(height: isLandscape ? 12 : 16),
              
              Text(
                'Or use a template:',
                style: TextStyle(
                  fontSize: isLandscape ? 12 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.grayMedium,
                ),
              ),
              SizedBox(height: isLandscape ? 6 : 8),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: appProvider.messageTemplates.map((template) {
                  return ActionChip(
                    label: Text(
                      template.text,
                      style: TextStyle(fontSize: isLandscape ? 11 : 12),
                    ),
                    onPressed: () {
                      _messageController.text = template.text;
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _sendMessage(null);
                Navigator.pop(context);
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}
