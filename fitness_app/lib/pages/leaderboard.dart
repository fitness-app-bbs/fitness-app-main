import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:share/share.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Map<String, dynamic>? localizedStrings;

  @override
  void initState() {
    super.initState();
    _loadLocalizedStrings();
  }

  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('assets/json/leaderboard.json');
    setState(() {
      localizedStrings = json.decode(jsonString);
      _calculateRanks();
    });
  }

  void _calculateRanks() {
    List<dynamic> leaderboard = localizedStrings!['leaderboard'];
    leaderboard.sort((a, b) => b['score'].compareTo(a['score']));
    for (int i = 0; i < leaderboard.length; i++) {
      leaderboard[i]['rank'] = i + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (localizedStrings == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInviteFriendsCard(context),

              SizedBox(height: 24),

              Text(
                localizedStrings!['leaderboard_title'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 16),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: localizedStrings!['leaderboard'].length,
                itemBuilder: (context, index) {
                  return _buildLeaderboardCard(localizedStrings!['leaderboard'][index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInviteFriendsCard(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizedStrings!['invite_friends_title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                localizedStrings!['invite_friends_description'],
                style: TextStyle(color: AppColors.gray),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Share.share("https://play.google.com/store/apps/details?id=com.instructivetech.fitnessapp");
            },
            child: Text(
              localizedStrings!['invite_button'],
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardCard(Map<String, dynamic> user) {
    return Container(
      decoration: _buildBoxDecorationWithBorder(user['rank']),
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.dark,
                child: Text(
                  user['rank'].toString(),
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${user['score']} pts',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildTrophyIcon(user['rank']),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecorationWithBorder(int rank) {
    Color borderColor;

    if (rank == 1) {
      borderColor = AppColors.gold;
    } else if (rank == 2) {
      borderColor = AppColors.silver;
    } else if (rank == 3) {
      borderColor = AppColors.bronze;
    } else {
      borderColor = Colors.transparent;
    }

    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor, width: 3),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildTrophyIcon(int rank) {
    Color trophyColor;

    if (rank == 1) {
      trophyColor = AppColors.gold;
    } else if (rank == 2) {
      trophyColor = AppColors.silver;
    } else if (rank == 3) {
      trophyColor = AppColors.bronze;
    } else {
      trophyColor = AppColors.dark;
    }

    return Icon(Icons.emoji_events, color: trophyColor);
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
}
