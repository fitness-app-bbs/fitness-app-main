import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:share_plus/share_plus.dart';
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
    final locale = Localizations.localeOf(context);
    final String jsonString;

    if (locale.languageCode == 'de') {
      jsonString = await rootBundle.loadString('assets/json/leaderboard_de.json');
    } else {
      jsonString = await rootBundle.loadString('assets/json/leaderboard_en.json');
    }

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
    final locale = Localizations.localeOf(context);
    if (localizedStrings == null || locale.languageCode != localizedStrings!['language']) {
      _loadLocalizedStrings();
    }

    if (localizedStrings == null) {
      return Center(child: CircularProgressIndicator());
    }

    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(brightness),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 40),

              _buildInviteFriendsCard(context),

              SizedBox(height: 24),

              Text(
                localizedStrings!['leaderboard_title'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor(brightness),
                ),
              ),

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
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: _buildBoxDecoration(brightness),
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
                  color: AppColors.textColor(brightness),
                ),
              ),
              SizedBox(height: 8),
              Text(
                localizedStrings!['invite_friends_description'],
                style: TextStyle(color: AppColors.textColor(brightness)),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor(brightness),
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
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: _buildBoxDecorationWithBorder(user['rank']),
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor(brightness),
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
                      color: AppColors.textColor(brightness),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${user['score']} ${localizedStrings!['points']}',
                    style: TextStyle(
                      color: AppColors.textColor(brightness),
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


    final brightness = Theme.of(context).brightness;
    return BoxDecoration(
      color: AppColors.cardColor(brightness),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor, width: 3),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildTrophyIcon(int rank) {
    final brightness = Theme.of(context).brightness;
    Color trophyColor;

    if (rank == 1) {
      trophyColor = AppColors.gold;
    } else if (rank == 2) {
      trophyColor = AppColors.silver;
    } else if (rank == 3) {
      trophyColor = AppColors.bronze;
    } else {
      trophyColor = AppColors.primaryColor(brightness);
    }

    return Icon(Icons.emoji_events, color: trophyColor);
  }

  BoxDecoration _buildBoxDecoration(Brightness brightness) {
    return BoxDecoration(
      color: AppColors.cardColor(brightness),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
}
