import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../games/games_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text: 'Hey! I’m With Me 👋\nHow are you feeling today?',
      isUser: false,
    ),
  ];

  bool _isSidebarOpen = true;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // SEND MESSAGE
  // ─────────────────────────────────────────────

  void _sendMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          text: message,
          isUser: true,
        ),
      );

      _messageController.clear();
    });

    _scrollToBottom();

    // Temporary AI response.
    // Later this will connect to your AI backend.
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      setState(() {
        _messages.add(
          const _ChatMessage(
            text: 'I’m here with you. Tell me more 💜',
            isUser: false,
          ),
        );
      });

      _scrollToBottom();
    });
  }

  // ─────────────────────────────────────────────
  // SCROLL
  // ─────────────────────────────────────────────

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // ─────────────────────────────────────────────
  // CLEAR CHAT
  // ─────────────────────────────────────────────

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
  }

  // ─────────────────────────────────────────────
  // OPEN GAMES
  // ─────────────────────────────────────────────

  void _openGames() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GamesScreen(),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MAIN BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            if (_isSidebarOpen) _buildSidebar(),

            Expanded(
              child: Column(
                children: [
                  _buildTopBar(),

                  Expanded(
                    child: _buildChatArea(),
                  ),

                  _buildMessageInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SIDEBAR
  // ─────────────────────────────────────────────

  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // ─────────────────────────────────────
          // WITH ME LOGO
          // ─────────────────────────────────────

          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              20,
              18,
              22,
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: AppColors.primary.withValues(
                        alpha: 0.28,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: 0.08,
                        ),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      'assets/images/withme_logo.jpeg',
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primary,
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    'With Me',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─────────────────────────────────────
          // NEW CHAT
          // ─────────────────────────────────────

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _messages.clear();
                  });
                },
                icon: const Icon(
                  Icons.add_rounded,
                  size: 20,
                ),
                label: const Text('New Chat'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryLight,
                  side: BorderSide(
                    color: AppColors.primary.withValues(
                      alpha: 0.35,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ─────────────────────────────────────
          // CHAT
          // ─────────────────────────────────────

          _sidebarItem(
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Chat',
            selected: true,
            onTap: () {},
          ),

          // ─────────────────────────────────────
          // GAMES
          // ─────────────────────────────────────

          _sidebarItem(
            icon: Icons.sports_esports_outlined,
            title: 'Games',
            onTap: _openGames,
          ),

          // ─────────────────────────────────────
          // MEMORIES
          // ─────────────────────────────────────

          _sidebarItem(
            icon: Icons.auto_awesome_outlined,
            title: 'Memories',
            onTap: () {
              _showComingSoon('Memories');
            },
          ),

          // ─────────────────────────────────────
          // CHAT HISTORY
          // ─────────────────────────────────────

          _sidebarItem(
            icon: Icons.history_rounded,
            title: 'Chat History',
            onTap: () {
              _showComingSoon('Chat History');
            },
          ),

          const Spacer(),

          // ─────────────────────────────────────
          // NOTIFICATIONS
          // ─────────────────────────────────────

          _sidebarItem(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            onTap: () {
              _showComingSoon('Notifications');
            },
          ),

          // ─────────────────────────────────────
          // SETTINGS
          // ─────────────────────────────────────

          _sidebarItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              _showComingSoon('Settings');
            },
          ),

          // ─────────────────────────────────────
          // PROFILE
          // ─────────────────────────────────────

          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              10,
              18,
              18,
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: 0.14,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primaryLight,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    _showComingSoon('Profile');
                  },
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.textMuted,
                  ),
                  tooltip: 'More',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SIDEBAR ITEM
  // ─────────────────────────────────────────────

  Widget _sidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool selected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: Material(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 21,
                  color: selected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),

                const SizedBox(width: 13),

                Text(
                  title,
                  style: TextStyle(
                    color: selected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // TOP BAR
  // ─────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // MENU BUTTON

          IconButton(
            onPressed: () {
              setState(() {
                _isSidebarOpen = !_isSidebarOpen;
              });
            },
            icon: Icon(
              _isSidebarOpen
                  ? Icons.menu_open_rounded
                  : Icons.menu_rounded,
              color: AppColors.textSecondary,
            ),
            tooltip: 'Menu',
          ),

          const SizedBox(width: 8),

          // SMALL LOGO

          Container(
            width: 34,
            height: 34,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primary.withValues(
                  alpha: 0.20,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'assets/images/withme_logo.jpeg',
                fit: BoxFit.contain,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return const Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.primary,
                    size: 18,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 10),

          const Text(
            'With Me',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          // ROBOT CONNECTION

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(
                alpha: 0.08,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.success.withValues(
                  alpha: 0.18,
                ),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.circle,
                  color: AppColors.success,
                  size: 8,
                ),
                SizedBox(width: 7),
                Text(
                  'Robot connected',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // NOTIFICATIONS

          IconButton(
            onPressed: () {
              _showComingSoon('Notifications');
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textSecondary,
            ),
            tooltip: 'Notifications',
          ),

          const SizedBox(width: 4),

          // PROFILE ICON

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.indigoSlate,
              ),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.textSecondary,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // CHAT AREA
  // ─────────────────────────────────────────────

  Widget _buildChatArea() {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: _messages.isEmpty
          ? _buildEmptyChat()
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(
                24,
                30,
                24,
                30,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(
                  _messages[index],
                );
              },
            ),
    );
  }

  // ─────────────────────────────────────────────
  // EMPTY CHAT
  //
  // NO LOGO HERE
  // ─────────────────────────────────────────────

  Widget _buildEmptyChat() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What’s on your mind?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Talk to With Me about anything.\n'
              'I’m here to listen, help and keep you company.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 28),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _suggestionChip(
                  'How was my day?',
                ),
                _suggestionChip(
                  'Tell me something fun',
                ),
                _suggestionChip(
                  'I need motivation',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SUGGESTION CHIP
  // ─────────────────────────────────────────────

  Widget _suggestionChip(String text) {
    return InkWell(
      onTap: () {
        _messageController.text = text;
        _sendMessage();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.indigoSlate,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MESSAGE
  // ─────────────────────────────────────────────

  Widget _buildMessage(_ChatMessage message) {
    final bool isUser = message.isUser;

    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 18,
        ),
        child: Row(
          mainAxisAlignment: isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 650,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: isUser
                      ? AppColors.primary.withValues(
                          alpha: 0.15,
                        )
                      : AppColors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(17),
                    topRight: const Radius.circular(17),
                    bottomLeft: Radius.circular(
                      isUser ? 17 : 5,
                    ),
                    bottomRight: Radius.circular(
                      isUser ? 5 : 17,
                    ),
                  ),
                  border: Border.all(
                    color: isUser
                        ? AppColors.primary.withValues(
                            alpha: 0.20,
                          )
                        : AppColors.indigoSlate,
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MESSAGE INPUT
  // ─────────────────────────────────────────────

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        18,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // TEXT FIELD

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                    border: Border.all(
                      color: AppColors.indigoSlate,
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction:
                        TextInputAction.newline,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    decoration:
                        const InputDecoration(
                      hintText: 'Message With Me...',
                      hintStyle: TextStyle(
                        color: AppColors.textMuted,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 14,
                      ),
                    ),
                    onSubmitted: (_) {
                      _sendMessage();
                    },
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // SEND BUTTON

              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                      BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary
                          .withValues(alpha: 0.18),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(
                    Icons.arrow_upward_rounded,
                    color: AppColors.background,
                    size: 23,
                  ),
                  tooltip: 'Send',
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // FOOTER

          Row(
            children: [
              const Expanded(
                child: Text(
                  'With Me can make mistakes. Check important information.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
              ),

              TextButton.icon(
                onPressed: _clearChat,
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 15,
                ),
                label: const Text(
                  'Clear chat',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor:
                      AppColors.textMuted,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // COMING SOON
  // ─────────────────────────────────────────────

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature is coming soon 💜',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHAT MESSAGE MODEL
// ─────────────────────────────────────────────

class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({
    required this.text,
    required this.isUser,
  });
}