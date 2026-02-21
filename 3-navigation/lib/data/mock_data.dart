// =============================================================================
// Mock Data — Hard-coded Articles for Demo
// =============================================================================
// Concepts demonstrated:
// - Static mock data for prototyping without a backend
// - Using model classes with named constructors
// - Organizing data by category for easy lookup
// - DateTime.parse for ISO 8601 date strings
//
// In a real app, this data would come from a REST API or local database.
// Mock data lets us focus on navigation patterns without network setup.
// =============================================================================

import '../models/models.dart';

// -----------------------------------------------------------------------------
// Mock Articles
// -----------------------------------------------------------------------------
// Each article has a unique ID following the pattern: category-index.
// This makes deep linking easy: /article/tech-1

/// Provides hard-coded article data for all categories.
///
/// Access articles by category using [articlesByCategory], or get all
/// articles with [allArticles].
class MockData {
  // Private constructor prevents instantiation — this is a utility class.
  MockData._();

  /// All articles in the app, organized by category.
  static final Map<NewsCategory, List<Article>> articlesByCategory = {
    NewsCategory.tech: _techArticles,
    NewsCategory.sports: _sportsArticles,
    NewsCategory.science: _scienceArticles,
    NewsCategory.health: _healthArticles,
    NewsCategory.business: _businessArticles,
    NewsCategory.entertainment: _entertainmentArticles,
  };

  // ---------------------------------------------------------------------------
  // All articles flattened
  // ---------------------------------------------------------------------------

  /// Returns every article across all categories.
  static List<Article> get allArticles =>
      articlesByCategory.values.expand((list) => list).toList();

  // ---------------------------------------------------------------------------
  // Lookup helpers
  // ---------------------------------------------------------------------------

  /// Finds an article by its [id], or returns null if not found.
  ///
  /// Iterates through all categories — O(n) but fine for mock data.
  static Article? findById(String id) {
    for (final articles in articlesByCategory.values) {
      for (final article in articles) {
        if (article.id == id) return article;
      }
    }
    return null;

    // Alternative using collection firstWhereOrNull:
    // return allArticles.firstWhereOrNull((a) => a.id == id);
  }

  /// Returns articles matching a search query in title or summary.
  static List<Article> search(String query) {
    final lowerQuery = query.toLowerCase();
    return allArticles
        .where(
          (a) =>
              a.title.toLowerCase().contains(lowerQuery) ||
              a.summary.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Technology Articles
  // ---------------------------------------------------------------------------
  static final List<Article> _techArticles = [
    Article(
      id: 'tech-1',
      title: 'Flutter 4.0 Brings Native Compilation',
      summary:
          'The latest Flutter release introduces ahead-of-time compilation '
          'for web, improving startup performance by 60%.',
      body:
          'Flutter 4.0 marks a significant milestone in cross-platform '
          'development. The new AOT compilation pipeline for web targets '
          'eliminates the need for JavaScript compilation, resulting in '
          'near-native performance. Key highlights include:\n\n'
          '- 60% faster startup times on web\n'
          '- Reduced bundle sizes by 40%\n'
          '- New Material 4 components\n'
          '- Improved hot reload for complex widget trees\n\n'
          'The Flutter team has been working on this for over two years, '
          'and the results speak for themselves. Early adopters report '
          'significant improvements in user engagement metrics.',
      category: NewsCategory.tech,
      author: 'Sarah Chen',
      publishedAt: DateTime.parse('2025-12-15'),
      readTimeMinutes: 8,
    ),
    Article(
      id: 'tech-2',
      title: 'Dart 4 Introduces Pattern Matching 2.0',
      summary:
          'New pattern matching features in Dart 4 bring exhaustive '
          'switch expressions and guard clauses to the language.',
      body:
          'Dart 4 continues to evolve the language with powerful '
          'pattern matching capabilities. The new features include:\n\n'
          '- Exhaustive switch expressions with sealed hierarchies\n'
          '- Guard clauses with `when` keyword\n'
          '- Destructuring in for-in loops\n'
          '- Pattern matching in if-case statements\n\n'
          'These features make Dart more expressive while maintaining '
          'its strong type safety guarantees.',
      category: NewsCategory.tech,
      author: 'James Park',
      publishedAt: DateTime.parse('2025-12-10'),
      readTimeMinutes: 6,
    ),
    Article(
      id: 'tech-3',
      title: 'AI-Powered Code Reviews Gain Traction',
      summary:
          'Major tech companies adopt AI code review tools that catch '
          'bugs before human reviewers even see the PR.',
      body:
          'The adoption of AI-powered code review tools has accelerated '
          'dramatically in 2025. Companies report catching 30% more '
          'bugs in the review stage, with particular improvements in '
          'identifying security vulnerabilities and performance '
          'regressions.\n\n'
          'Key benefits reported:\n'
          '- Faster review turnaround (2 hours vs 2 days)\n'
          '- Consistent style enforcement\n'
          '- Automatic test generation suggestions\n'
          '- Security vulnerability detection',
      category: NewsCategory.tech,
      author: 'Maria Rodriguez',
      publishedAt: DateTime.parse('2025-12-08'),
      readTimeMinutes: 5,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Sports Articles
  // ---------------------------------------------------------------------------
  static final List<Article> _sportsArticles = [
    Article(
      id: 'sports-1',
      title: 'World Cup 2026 Venues Finalized',
      summary:
          'FIFA confirms all 48 match venues across the US, Canada, '
          'and Mexico for the expanded World Cup.',
      body:
          'FIFA has finalized the venue selections for the 2026 World Cup, '
          'the first to feature 48 teams. The tournament will be spread '
          'across 16 cities in three countries, with the final scheduled '
          'at MetLife Stadium in New Jersey.\n\n'
          'Notable venue highlights:\n'
          '- Opening match at Estadio Azteca (Mexico City)\n'
          '- Semi-finals at AT&T Stadium (Dallas)\n'
          '- New state-of-the-art facilities in Toronto\n\n'
          'Organizers expect record attendance figures across all venues.',
      category: NewsCategory.sports,
      author: 'Carlos Mendez',
      publishedAt: DateTime.parse('2025-12-12'),
      readTimeMinutes: 7,
    ),
    Article(
      id: 'sports-2',
      title: 'E-Sports Olympic Debut Set for 2028',
      summary:
          'The IOC confirms competitive gaming will be a medal event '
          'at the 2028 Los Angeles Olympics.',
      body:
          'In a historic decision, the International Olympic Committee '
          'has confirmed that e-sports will debut as a full medal event '
          'at the 2028 Los Angeles Olympics. Five game titles have been '
          'selected, spanning strategy, fighting, and racing genres.\n\n'
          'This decision comes after years of deliberation and successful '
          'demonstration events at recent Olympic games.',
      category: NewsCategory.sports,
      author: 'Kim Tanaka',
      publishedAt: DateTime.parse('2025-12-05'),
      readTimeMinutes: 4,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Science Articles
  // ---------------------------------------------------------------------------
  static final List<Article> _scienceArticles = [
    Article(
      id: 'science-1',
      title: 'Mars Sample Return Mission Launches Successfully',
      summary:
          'NASA and ESA celebrate the successful launch of the first '
          'mission to bring Martian soil samples back to Earth.',
      body:
          'After years of planning and development, the Mars Sample '
          'Return mission has launched successfully from Cape Canaveral. '
          'The spacecraft will rendezvous with the samples collected by '
          'the Perseverance rover and return them to Earth by 2033.\n\n'
          'Scientists expect the samples to provide definitive answers '
          'about whether Mars once harbored microbial life. The mission '
          'represents the most complex robotic space mission ever attempted.',
      category: NewsCategory.science,
      author: 'Dr. Elena Vasquez',
      publishedAt: DateTime.parse('2025-12-14'),
      readTimeMinutes: 9,
    ),
    Article(
      id: 'science-2',
      title: 'Quantum Computing Reaches 1000-Qubit Milestone',
      summary:
          'IBM announces a 1000-qubit quantum processor, opening new '
          'possibilities for drug discovery and cryptography.',
      body:
          'IBM has unveiled its latest quantum processor, achieving the '
          'long-anticipated 1000-qubit milestone. This breakthrough enables '
          'quantum advantage for a broader range of real-world problems.\n\n'
          'Potential applications include:\n'
          '- Drug molecule simulation\n'
          '- Financial risk modeling\n'
          '- Supply chain optimization\n'
          '- Post-quantum cryptography research',
      category: NewsCategory.science,
      author: 'Dr. Raj Patel',
      publishedAt: DateTime.parse('2025-12-01'),
      readTimeMinutes: 6,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Health Articles
  // ---------------------------------------------------------------------------
  static final List<Article> _healthArticles = [
    Article(
      id: 'health-1',
      title: 'Personalized Nutrition Apps Show Real Results',
      summary:
          'A large-scale study confirms that AI-driven personalized '
          'nutrition plans outperform generic dietary guidelines.',
      body:
          'A landmark study involving 50,000 participants has shown that '
          'AI-powered personalized nutrition apps lead to significantly '
          'better health outcomes than one-size-fits-all dietary advice.\n\n'
          'Key findings:\n'
          '- 35% greater weight loss compared to control group\n'
          '- Improved blood sugar regulation in diabetic participants\n'
          '- Higher adherence rates due to personalized recommendations\n'
          '- Better gut microbiome diversity after 6 months',
      category: NewsCategory.health,
      author: 'Dr. Lisa Wong',
      publishedAt: DateTime.parse('2025-12-11'),
      readTimeMinutes: 7,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Business Articles
  // ---------------------------------------------------------------------------
  static final List<Article> _businessArticles = [
    Article(
      id: 'business-1',
      title: 'Remote Work Becomes the Global Default',
      summary:
          'Fortune 500 survey shows 70% of companies now offer fully '
          'remote positions as standard policy.',
      body:
          'The shift to remote work, accelerated by the pandemic, has '
          'become permanent for most major corporations. A new Fortune 500 '
          'survey reveals that 70% now offer fully remote positions, '
          'up from 30% in 2022.\n\n'
          'Factors driving the change:\n'
          '- Talent acquisition from global pool\n'
          '- Reduced real estate costs (avg 40% savings)\n'
          '- Employee satisfaction and retention improvements\n'
          '- Advanced collaboration tools maturity',
      category: NewsCategory.business,
      author: 'Michael Torres',
      publishedAt: DateTime.parse('2025-12-09'),
      readTimeMinutes: 5,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Entertainment Articles
  // ---------------------------------------------------------------------------
  static final List<Article> _entertainmentArticles = [
    Article(
      id: 'entertainment-1',
      title: 'Interactive Streaming Redefines Cinema',
      summary:
          'Major studios embrace interactive storytelling, letting '
          'viewers choose plot directions in real-time.',
      body:
          'Interactive cinema has evolved far beyond simple branching '
          'narratives. New streaming technology allows real-time audience '
          'voting on plot decisions, creating a communal viewing experience '
          'that combines gaming and traditional cinema.\n\n'
          'Early adopters report:\n'
          '- 3x longer average viewing sessions\n'
          '- Higher subscription retention rates\n'
          '- New revenue from "director\'s cut" unlockable paths\n'
          '- Social media engagement spikes during live events',
      category: NewsCategory.entertainment,
      author: 'Alex Rivera',
      publishedAt: DateTime.parse('2025-12-07'),
      readTimeMinutes: 6,
    ),
  ];
}
