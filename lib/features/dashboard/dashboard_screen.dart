import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();

  bool _isSidebarOpen = true;
  bool _isSending = false;

  final List<_ChatMessage> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SEND MESSAGE
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isSending) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          text: text,
          isUser: true,
        ),
      );

      _messageController.clear();
      _isSending = true;
    });

    _scrollToBottom();

    // TEMPORARY AI RESPONSE
    // Later this will be replaced with your HTTPS AI API.

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    String response;

    if (text.toLowerCase().contains('hello') ||
        text.toLowerCase().contains('hi')) {
      response = "Hey! 👋 I'm With Me. It's nice to talk with you.";
    } else if (text.toLowerCase().contains('sad') ||
        text.toLowerCase().contains('bad')) {
      response =
          "I'm here with you. 💙 You can talk to me about what's bothering you.";
    } else if (text.toLowerCase().contains('bored')) {
      response =
          "Bored already? 😄 We can chat, play a game, or I can give you a little challenge!";
    } else {
      response = "I'm listening. 💙 Tell me more about that.";
    }

    setState(() {
      _messages.add(
        _ChatMessage(
          text: response,
          isUser: false,
        ),
      );

      _isSending = false;
    });

    _scrollToBottom();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SCROLL TO BOTTOM
  // ─────────────────────────────────────────────────────────────────────────

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_chatScrollController.hasClients) return;

      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CLEAR CHAT
  // ─────────────────────────────────────────────────────────────────────────

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            // SIDEBAR
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: _isSidebarOpen ? 270 : 0,
              child: _isSidebarOpen
                  ? _buildSidebar()
                  : const SizedBox.shrink(),
            ),

            // MAIN AREA
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: _buildChatArea(),
                  ),
                  _buildChatInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SIDEBAR
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildSidebar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1020),
        border: Border(
          right: BorderSide(
            color: AppColors.textSecondary.withValues(alpha: 0.15),
          ),
        ),
      ),
      child: Column(
        children: [
          // Sidebar header
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 12, 18),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.accentRed.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: AppColors.accentRed,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'With Me',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Close sidebar',
                  onPressed: () {
                    setState(() {
                      _isSidebarOpen = false;
                    });
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: AppColors.textSecondary.withValues(alpha: 0.12),
            height: 1,
          ),

          // Sidebar menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              children: [
                _sidebarItem(
                  icon: Icons.home_rounded,
                  title: 'Home',
                  selected: true,
                  onTap: () {},
                ),

                const SizedBox(height: 5),

                _sidebarItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'All Chats',
                  onTap: () {},
                ),

                _sidebarItem(
                  icon: Icons.history_rounded,
                  title: 'Recents',
                  onTap: () {},
                ),

                _sidebarItem(
                  icon: Icons.push_pin_outlined,
                  title: 'Pinned',
                  onTap: () {},
                ),

                _sidebarItem(
                  icon: Icons.chat_outlined,
                  title: 'Temporary Chat',
                  onTap: _clearChat,
                ),

                _sidebarItem(
                  icon: Icons.mood_rounded,
                  title: 'Mood Check',
                  onTap: () {},
                ),

                const SizedBox(height: 18),

                // ─────────────────────────────────────────────────────────
                // GAMES
                // Only the Games section is kept here.
                // Your team can add games underneath later.
                // ─────────────────────────────────────────────────────────

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'GAMES',
                    style: TextStyle(
                      color: AppColors.highlightGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                _sidebarItem(
                  icon: Icons.sports_esports_outlined,
                  title: 'Games',
                  onTap: () {},
                  compact: true,
                ),
              ],
            ),
          ),

          // User area
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.textSecondary.withValues(alpha: 0.12),
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor:
                      AppColors.accentRed.withValues(alpha: 0.15),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'You',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Settings',
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SIDEBAR ITEM
  // ─────────────────────────────────────────────────────────────────────────

  Widget _sidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool selected = false,
    bool compact = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected
            ? AppColors.accentRed.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: compact ? 8 : 10,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: compact ? 18 : 20,
                  color: selected
                      ? AppColors.accentRed
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: selected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontSize: compact ? 13 : 14,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TOP BAR
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(
            color: AppColors.textSecondary.withValues(alpha: 0.12),
          ),
        ),
      ),
      child: Row(
        children: [
          if (!_isSidebarOpen)
            IconButton(
              tooltip: 'Open sidebar',
              onPressed: () {
                setState(() {
                  _isSidebarOpen = true;
                });
              },
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.textPrimary,
              ),
            ),

          if (!_isSidebarOpen) const SizedBox(width: 8),

          const Text(
            'With Me',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          // Search
          Container(
            width: 220,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF101827),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.textSecondary.withValues(alpha: 0.18),
              ),
            ),
            child: const TextField(
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.textSecondary,
                  size: 19,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          const SizedBox(width: 10),

          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textSecondary,
            ),
          ),

          IconButton(
            tooltip: 'More',
            onPressed: () {
              _showMoreMenu(context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CHAT AREA
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildChatArea() {
    if (_messages.isEmpty) {
      return _buildEmptyChat();
    }

    return ListView.builder(
      controller: _chatScrollController,
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];

        return _buildMessageBubble(message);
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // EMPTY CHAT
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildEmptyChat() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: AppColors.accentRed.withValues(alpha: 0.10),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accentRed.withValues(alpha: 0.25),
                ),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.accentRed,
                size: 38,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Good to see you 👋',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'What would you like to talk about?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 28),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                _suggestionButton(
                  '💬 Talk with me',
                  'Tell me something about your day.',
                ),
                _suggestionButton(
                  '😂 Make me laugh',
                  'Tell me something funny.',
                ),
                _suggestionButton(
                  "🎮 Let's play",
                  'I want to play a game.',
                ),
                _suggestionButton(
                  '💙 I need to talk',
                  'I want to talk about how I feel.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SUGGESTION BUTTON
  // ─────────────────────────────────────────────────────────────────────────

  Widget _suggestionButton(String title, String message) {
    return OutlinedButton(
      onPressed: () {
        _messageController.text = message;
        _sendMessage();
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: BorderSide(
          color: AppColors.textSecondary.withValues(alpha: 0.25),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // MESSAGE BUBBLE
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildMessageBubble(_ChatMessage message) {
    return Align(
      alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
          mainAxisAlignment: message.isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser) ...[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.accentRed.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.accentRed,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
            ],

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
                  color: message.isUser
                      ? AppColors.accentRed
                      : const Color(0xFF101827),
                  borderRadius: BorderRadius.circular(17),
                  border: message.isUser
                      ? null
                      : Border.all(
                          color: AppColors.textSecondary
                              .withValues(alpha: 0.15),
                        ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser
                        ? Colors.white
                        : AppColors.textPrimary,
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

  // ─────────────────────────────────────────────────────────────────────────
  // CHAT INPUT
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 18),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 900,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF101827),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.22),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 8),

              IconButton(
                tooltip: 'Attach',
                onPressed: () {},
                icon: const Icon(
                  Icons.add_rounded,
                  color: AppColors.textSecondary,
                ),
              ),

              Expanded(
                child: TextField(
                  controller: _messageController,
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  onSubmitted: (_) => _sendMessage(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Write something...',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                  ),
                ),
              ),

              IconButton(
                tooltip: 'Voice',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Voice input will be connected soon.',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.mic_none_rounded,
                  color: AppColors.textSecondary,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  right: 7,
                  bottom: 7,
                ),
                child: Material(
                  color: AppColors.accentRed,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _isSending ? null : _sendMessage,
                    child: SizedBox(
                      width: 43,
                      height: 43,
                      child: Center(
                        child: _isSending
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.white,
                                size: 21,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // MORE MENU
  // ─────────────────────────────────────────────────────────────────────────

  void _showMoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF080B18),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.textSecondary,
                ),
                title: const Text(
                  'Clear current chat',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _clearChat();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.accentRed,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Logout will be connected to Firebase Auth.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CHAT MESSAGE MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({
    required this.text,
    required this.isUser,
  });
}