import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakTracker {
  static const String lastUsedDateKey = 'lastUsedDate';
  static const String streakCountKey = 'streakCount';

  Future<void> checkAndUpdateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastUsedDate = prefs.getString(lastUsedDateKey);
    int streakCount = prefs.getInt(streakCountKey) ?? 0;

    if (lastUsedDate != null) {
      final lastUsed = DateTime.parse(lastUsedDate);
      final difference = now.difference(lastUsed).inDays;

      if (difference == 1) {
        // User has opened the app on consecutive days
        streakCount++;
      } else if (difference > 1) {
        // User missed a day, reset streak
        streakCount = 0;
      }
    } else {
      // First time opening the app
      streakCount = 1;
    }

    await prefs.setString(lastUsedDateKey, now.toIso8601String());
    await prefs.setInt(streakCountKey, streakCount);

    debugPrint('Current streak: $streakCount days');
  }

  Future<int> getCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakCountKey) ?? 0;
  }
}
