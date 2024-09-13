import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:share/share.dart';

class LeaderboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboard = [
    {"name": "John Doe", "score": 1200, "rank": 1},
    {"name": "Jane Smith", "score": 1150, "rank": 2},
    {"name": "Alice Johnson", "score": 1100, "rank": 3},
    {"name": "Bob Brown", "score": 900, "rank": 4},
    {"name": "Charlie Davis", "score": 850, "rank": 5},
    {"name": "Haley Horn", "score": 700, "rank": 6},
    {"name": "James Henrison", "score": 657, "rank": 7},
    {"name": "Max Betel", "score": 546, "rank": 8},
    {"name": "Bobie Kleid", "score": 321, "rank": 9},
    {"name": "Chuck Bass", "score": 190, "rank": 10},
  ];

  @override
  Widget build(BuildContext context) {
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
              // Invite Friends Section
              _buildInviteFriendsCard(context),

              SizedBox(height: 24),

              // Leaderboard Title
              Text(
                'Top Rankings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 16),

              // Leaderboard List
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  return _buildLeaderboardCard(leaderboard[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Card for inviting friends
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
                'Invite your friends!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'See who is leading the leaderboard.',
                style: TextStyle(color: AppColors.gray),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.medium,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Share.share("https://play.google.com/store/apps/details?id=com.instructivetech.fitnessapp");
            },
            child: Text(
              'Invite',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Card for each leaderboard entry
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
                backgroundColor: AppColors.lightlight,
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
      trophyColor = AppColors.medium;
    }

    return Icon(Icons.emoji_events, color: trophyColor);
  }

  // Reusable BoxDecoration for consistency in design
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
