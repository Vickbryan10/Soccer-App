import 'package:soccerapp/models/fixture.dart';
import 'package:soccerapp/models/goal.dart';
import 'package:soccerapp/models/league.dart';
import 'package:soccerapp/models/match.dart';
import 'package:soccerapp/models/status.dart';
import 'package:soccerapp/models/team.dart';
import 'package:soccerapp/models/venue.dart';

/// Helper class to create and manage custom fixtures for the Vick Score app
class FixtureHelper {
  /// Create a new match fixture with all required data
  static SoccerMatch createFixture({
    required int fixtureId,
    required String date,
    required String referee,
    required Status status,
    required Venue venue,
    required Team homeTeam,
    required Team awayTeam,
    required Goal goals,
    required League league,
  }) {
    final fixture = Fixture(
      fixtureId,
      date,
      referee,
      status,
      venue,
    );

    return SoccerMatch(
      fixture,
      homeTeam,
      awayTeam,
      goals,
      league,
    );
  }

  /// Example: Create a sample fixture for testing
  static SoccerMatch createSampleFixture() {
    final fixture = Fixture(
      123456,
      '2026-01-25T19:00:00+00:00',
      'Andre Marriner',
      Status(45, 'Half Time'),
      Venue(
        1,
        'https://media.api-sports.io/venues/1.png',
        'Old Trafford',
        'Manchester',
        'Sir Matt Busby Way',
        76000,
      ),
    );

    final homeTeam = Team(
      33,
      'Manchester United',
      'https://media.api-sports.io/teams/33.png',
      'England',
      false,
      false,
    );

    final awayTeam = Team(
      34,
      'Newcastle United',
      'https://media.api-sports.io/teams/34.png',
      'England',
      false,
      false,
    );

    final goals = Goal(2, 1);

    final league = League(
      39,
      'Premier League',
      'PL',
      'https://media.api-sports.io/leagues/39.png',
      '2025',
    );

    return SoccerMatch(fixture, homeTeam, awayTeam, goals, league);
  }

  /// Add a new fixture to a list of matches
  static List<SoccerMatch> addFixtureToList(
    List<SoccerMatch> matches,
    SoccerMatch newFixture,
  ) {
    matches.add(newFixture);
    return matches;
  }

  /// Filter fixtures by league
  static List<SoccerMatch> filterByLeague(
    List<SoccerMatch> matches,
    int leagueId,
  ) {
    return matches
        .where((match) => match.league.id == leagueId)
        .toList();
  }

  /// Filter fixtures by status
  static List<SoccerMatch> filterByStatus(
    List<SoccerMatch> matches,
    String statusLong,
  ) {
    return matches
        .where((match) => match.fixture.status.long == statusLong)
        .toList();
  }

  /// Get upcoming fixtures
  static List<SoccerMatch> getUpcomingFixtures(
    List<SoccerMatch> matches,
  ) {
    return filterByStatus(matches, 'Not Started');
  }

  /// Get live fixtures
  static List<SoccerMatch> getLiveFixtures(List<SoccerMatch> matches) {
    return matches
        .where((match) =>
            match.fixture.status.long != 'Not Started' &&
            match.fixture.status.long != 'Match Finished')
        .toList();
  }

  /// Get finished fixtures
  static List<SoccerMatch> getFinishedFixtures(List<SoccerMatch> matches) {
    return filterByStatus(matches, 'Match Finished');
  }
}
