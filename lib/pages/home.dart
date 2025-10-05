import 'package:flutter/material.dart';
import 'package:quiz_basic_app/pages/safe_scaffold.dart';
import 'dart:math' as math;
import 'dart:async';
import 'subject.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<Map<String, String>> classes = [
    {"name": "Class 1", "image": "assets/images/class4.png"},
    {"name": "Class 2", "image": "assets/images/class4.png"},
    {"name": "Class 3", "image": "assets/images/class4.png"},
    {"name": "Class 4", "image": "assets/images/class4.png"},
    {"name": "Class 5", "image": "assets/images/class4.png"},
    {"name": "Class 6", "image": "assets/images/class4.png"},
  ];

  final List<String> sliderImages = [
    "assets/images/class5.png",
    "assets/images/kids.png",
    "assets/images/class4.png",
    "assets/images/gk1.png",
    "assets/images/math1.png",
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _sliderTimer;

  bool isDarkTheme = false;
  late AnimationController _cardAnimationController;
  late AnimationController _loadingAnimationController;
  bool _isLoading = false;
  String _selectedClass = '';

  // 🔹 AI Voice + Mouth Animation
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  int _mouthFrame = 0;
  late Timer _mouthTimer;

  List<String> _mouthImages = [
    'assets/images/kkk.png',
    'assets/images/kkk.png',
    'assets/images/kkk.png',
  ];

  @override
  void initState() {
    super.initState();

    _cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _cardAnimationController.forward();

    _loadingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _pageController = PageController(initialPage: 0);

    // 🔹 Auto image slider
    _sliderTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_currentPage < sliderImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });

    // 🔹 Auto welcome voice
    _speakWelcome();
  }

  Future<void> _speakWelcome() async {
    setState(() => isSpeaking = true);

    _mouthTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (!isSpeaking) {
        timer.cancel();
      } else {
        setState(() {
          _mouthFrame = (_mouthFrame + 1) % _mouthImages.length;
        });
      }
    });

    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak("Welcome to BrainBoost! Ready to explore, learn, and boost your brainpower?");
   // await flutterTts.speak("हैलो! हमारे मज़ेदार लर्निंग वर्ल्ड में आपका स्वागत है। अपनी कक्षा चुनें और नए ज्ञान की यात्रा शुरू करें!");

    flutterTts.setCompletionHandler(() {
      setState(() => isSpeaking = false);
      _mouthTimer.cancel();
      _mouthFrame = 0;
    });
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _loadingAnimationController.dispose();
    _pageController.dispose();
    _sliderTimer?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  void _onTapClass(String className) {
    setState(() {
      _isLoading = true;
      _selectedClass = className;
    });
    _loadingAnimationController.repeat();
    _navigateToSubjectPage();
  }

  _navigateToSubjectPage() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SubjectPage(className: _selectedClass),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ).then((_) {
        _loadingAnimationController.stop();
        _loadingAnimationController.reset();
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        isDarkTheme ? Colors.blueGrey[900] : const Color(0xFF1B033A);
    final secondaryColor = isDarkTheme
        ? const Color.fromARGB(255, 164, 192, 196)
        : const Color.fromARGB(255, 219, 224, 220);
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final bgColor = isDarkTheme
        ? const Color.fromARGB(255, 245, 230, 230)
        : const Color(0xFFF0F2F5);

    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 80, 110),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _loadingAnimationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _loadingAnimationController.value * 2 * math.pi,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: secondaryColor!.withOpacity(0.8),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.7),
                            blurRadius: 25,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.5),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateX(
                            _loadingAnimationController.value * 2 * math.pi,
                          )
                          ..rotateY(
                            _loadingAnimationController.value * 2 * math.pi,
                          ),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [secondaryColor, primaryColor!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.school,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                "Loading $_selectedClass Data...",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leadingWidth: 70,
          leading: SizedBox(
            height: 120,
            width: 100,
            child: Image.asset(
              'assets/images/slogo.png',
              fit: BoxFit.contain,
            ),
          ),
          automaticallyImplyLeading: false,
          title: null,
          centerTitle: false,
          backgroundColor: const Color.fromARGB(255, 37, 75, 107),
          elevation: 5,
          actions: [
            IconButton(
              icon: Icon(
                isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isDarkTheme = !isDarkTheme;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Welcome to Your Learning World Explore, Play, and Grow!” 🌟",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 26, 42, 112),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 240, 176, 195)
                              .withOpacity(0.25),
                          blurRadius: 5,
                          spreadRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        sliderImages[1],
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 25,
                child: Text(
                  "Start Your Learning Journey Here",
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 238, 28), fontSize: 18),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: classes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (context, index) {
                    var cls = classes[index];
                    return AnimatedBuilder(
                      animation: _cardAnimationController,
                      builder: (context, child) {
                        final animation = CurvedAnimation(
                          parent: _cardAnimationController,
                          curve: Interval(
                            (index / classes.length) * 0.5,
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        );
                        return Transform.translate(
                          offset: Offset(0, 100 * (1 - animation.value)),
                          child: FadeTransition(
                            opacity: animation,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateX(0.1 * (1 - animation.value)),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => _onTapClass(cls["name"]!),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        secondaryColor!,
                                        primaryColor!
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(66, 221, 102, 22),
                                        blurRadius: 30,
                                        offset: Offset(4, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            cls["image"]!,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        cls["name"]!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // 🔹 Floating AI Icon (glowing + mouth animation)
        floatingActionButton: AvatarGlow(
          endRadius: isSpeaking ? 80 : 60,
          //glowColor: Colors.purple,
          glowColor: const Color.fromARGB(255, 159, 221, 135),
          animate: isSpeaking,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 235, 158, 15),
            onPressed: _speakWelcome,
            child: Image.asset(
              _mouthImages[_mouthFrame],
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
