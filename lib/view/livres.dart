import 'package:flutter/material.dart';
import 'package:my_app3/models/Book.dart';
import 'dart:math' as math;

import 'package:my_app3/widgets/language_button.dart';

class Livres extends StatefulWidget {
  const Livres({Key? key}) : super(key: key);

  @override
  _LivresState createState() => _LivresState();
}

class _LivresState extends State<Livres> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Book> frenchBooks = [
    Book(
        title: "Je Comprends Tout",
        publisher: "Éditions Nathan / Hatier",
        description:
            "Available for CP to 6e (1ère année to 6ème année). Covers Math, French, Science, History/Geography.",
        examples: [
          "Je comprends tout – Français 4e année",
          "Je comprends tout – Mathématiques 5e année"
        ],
        image: 'images/livres/je_comprends_tout.jpg'),
    Book(
        title: "Tout le programme… en un seul cahier",
        publisher: "Éditions Bordas / Hatier",
        description:
            "Full-year revision books. Great for reinforcing everything learned in a given school year.",
        examples: [
          "Tout le programme CE2 (équivalent à 3ème année)",
          "Tout le programme CM1 (équivalent à 4ème année)"
        ],
        image: 'images/livres/tout_programme.jpg'),
    Book(
        title: "Cahiers de Vacances",
        publisher: "Nathan / Passeport / Hachette",
        description:
            "Summer workbooks (vacation books) for revision during holidays. Align well with Tunisian curriculum.",
        examples: [
          "Passeport du CE2 au CM1 (3e to 4e année)",
          "Cahier de vacances Hachette – CM2 vers 6e (6e année prep for collège)"
        ],
        image: 'images/livres/cahiers_vacances.jpg'),
    Book(
        title: "Sami et Julie",
        publisher: "Éditions Hachette",
        description:
            "Beginner readers and mini-stories. Excellent for reading fluency and comprehension.",
        examples: [
          "Sami et Julie CP Niveau 1 : Sami à l'école",
          "Sami et Julie CE1 : La sortie scolaire"
        ],
        image: 'images/livres/sami_et_julie.jpg'),
  ];

  final List<Book> arabicBooks = [
    Book(
        title: "سلسلة أقرأ وأتعلم",
        publisher: "I Read and Learn Series",
        description:
            "Excellent for Arabic reading and comprehension (early years). Includes colorful illustrations, short stories, questions.",
        examples: [],
        image: 'images/livres/read_and_learn.jpg'),
    Book(
        title: "تمارين في اللغة العربية والرياضيات",
        publisher: "Local Tunisian workbooks",
        description:
            "Sold in small stationery shops. Practice books for dictation, grammar, and problem-solving.",
        examples: [],
        image: 'images/livres/exercies_en_arabic_and_math.png'),
  ];

  final List<Book> bilingualBooks = [
    Book(
        title: "Cahiers bilingues Tunisie",
        publisher: "Local Publishers",
        description:
            "Locally made, includes exercises in both French and Arabic.",
        examples: ["Lecture - Calcul - Dictée"],
        image: 'images/livres/cahier_bilingues.jpg'),
    Book(
        title: "Cartes éducatives / Flashcards bilingues",
        publisher: "Various Publishers",
        description:
            "For home learning and visual memory. Available in French and Arabic.",
        examples: [],
        image: 'images/livres/cartes_educatives.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        // Back button and language toggle row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // back button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: 35,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.black54),
                ),
              ),
              const Text(
                "Livres Recommandés",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Language button
              LanguageButton()
            ],
          ),
        ),
        const SizedBox(height: 30),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue[700],
          labelColor: Colors.blue[800],
          unselectedLabelColor: Colors.blue[300],
          tabs: const [
            Tab(text: "🇫🇷 Français"),
            Tab(text: "🇸🇦 Arabe"),
            Tab(text: "🌍 Bilingue"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBookList(frenchBooks, Colors.blue[100]!),
              _buildBookList(arabicBooks, Colors.blue[100]!),
              _buildBookList(bilingualBooks, Colors.blue[100]!),
            ],
          ),
        ),
        const SizedBox(height: 70),
      ],
    );
  }

  Widget _buildBookList(List<Book> books, Color baseColor) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Hero(
          tag: 'book-${books[index].title}',
          child: BookCard(
            book: books[index],
            color: baseColor,
            onTap: () => _showBookDetails(books[index]),
            index: index,
          ),
        );
      },
    );
  }

  // Filter options have been removed as requested

  void _showBookDetails(Book book) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return BookDetailsScreen(book: book);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ));
  }
}

class BookCard extends StatefulWidget {
  final Book book;
  final Color color;
  final VoidCallback onTap;
  final int index;

  const BookCard({
    Key? key,
    required this.book,
    required this.color,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Staggered animation based on item index
    Future.delayed(Duration(milliseconds: 50 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        shadowColor: Colors.blue.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: widget.color,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for future image
                    Container(
                      width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Image.asset(widget.book.image),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.book.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.book.publisher,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.book.description,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.book.examples.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text(
                    "Exemples:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...widget.book.examples.map((example) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          "• $example",
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )),
                ],
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                      label: const Text("Acheter"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue[700],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: 35,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Icon(Icons.arrow_back, color: Colors.black54),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.lightBlue[100],
            child: Hero(
              tag: 'book-${book.title}',
              child: Center(
                child: Transform.rotate(
                  angle: -math.pi / 60,
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(book.image),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.publisher,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: const TextStyle(fontSize: 16),
                ),
                if (book.examples.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    "Exemples",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...book.examples.map((example) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          "• $example",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )),
                ],
                const SizedBox(height: 32),
                const Text(
                  "Ce livre est recommandé pour les élèves de l'école primaire qui veulent améliorer leurs compétences et leurs connaissances.",
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text("Acheter maintenant"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                      color: Colors.blue[700],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
