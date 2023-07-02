import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../models/index.dart' as models;
import '../providers/comments_provider.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final sentiment = Sentiment();

  int currentIndex = 0;

  final List<String> comments = [
    "I'm not sure about this.",
    "Great job! I love it!",
    "It needs improvement.",
    "This is amazing!",
    "I'm not a fan of this.",
    "Well done!",
    "Could be better.",
    "I'm really impressed!",
    "I don't like it at all.",
    "Fantastic work!",
    "This is excellent!",
    "I have mixed feelings about it.",
    "Impressive work!",
    "Not my cup of tea.",
    "Well executed.",
    "I expected more.",
    "Brilliant!",
    "It falls short of expectations.",
    "Thumbs up!",
    "Average performance.",
    "Incredible!",
    "I'm underwhelmed.",
    "Superb job!",
    "It lacks originality.",
    "Outstanding!",
    "Not what I was hoping for.",
    "Kudos!",
    "It needs more polish.",
    "Exceptional!",
    "Disappointing.",
    "Top-notch!",
  ];

  final List<Map<String, dynamic>> positive = [];
  final List<Map<String, dynamic>> neutral = [];
  final List<Map<String, dynamic>> negative = [];

  late List<Map<String, dynamic>> chartData = [];

  void analyze(String text) {
    final result = sentiment.analysis(text, emoji: true);

    if (result["comparative"] < 0) {
      negative.add({"comment": text, "comparative": result["comparative"]});
    } else if (result["comparative"] >= 1) {
      positive.add({"comment": text, "comparative": result["comparative"]});
    } else {
      neutral.add({"comment": text, "comparative": result["comparative"]});
    }
  }

  void onPressChart(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // Yorumlar geliyo ama error verıyor

    // List<models.Review> tempReviews =Provider.of<ReviewProvider>(context, listen: false).getReviews;
    // if(tempReviews.length != 0){
    //   for(int i = 0; i< tempReviews.length; i ++ ){
    //     analyze(tempReviews[i].text);
    //   }
    // }else{
    //   for (var comment in comments) {
    //     analyze(comment);
    //   }
    // }
    //hayyy

    for (var comment in comments) {
      analyze(comment);
    }


    chartData = [
      {
        "indicator": {
          "color": Colors.green,
          "title": "Positive comments",
        },
        "data": positive,
      },
      {
        "indicator": {
          "color": Colors.blue,
          "title": "Neutral comments",
        },
        "data": neutral,
      },
      {
        "indicator": {
          "color": Colors.red,
          "title": "Negative comments",
        },
        "data": negative,
      }
    ];

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<models.Review> tempReviews =Provider.of<ReviewProvider>(context, listen: false).getReviews;

    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(tempReviews[16].text),
          Chart(data: chartData, onPress: onPressChart),
          const SizedBox(height: 40),
          Text(
            chartData[currentIndex]["indicator"]["title"],
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Column(
            children: chartData[currentIndex]["data"].map<Widget>((item) {
              return CommentCard(text: item["comment"]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({super.key, required this.data, required this.onPress});

  final List<Map<String, dynamic>> data;
  final Function(int val) onPress;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = 0;

  late List<PieChartSectionData> sections;
  late List<Map<String, dynamic>> indicators;

  late num total = 0;

  @override
  void initState() {
    super.initState();

    for (var element in widget.data) {
      total = total + element["data"].length.toInt();
    }

    sections = widget.data.map((e) {
      double value = e["data"].length.toDouble();

      return PieChartSectionData(
        value: value,
        title: '${value * 100 ~/ total}%',
        color: e["indicator"]["color"],
      );
    }).toList();

    indicators = widget.data.map((e) {
      return e["indicator"] as Map<String, dynamic>;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicators.map((item) {
            return Indicator(color: item["color"], text: item["title"]);
          }).toList(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 80),
          width: 200,
          height: 200,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (event is! FlTapUpEvent) {
                    return; // Ignore touch events other than tap up
                  }

                  setState(() {
                    if (pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    }
                  });

                  if (touchedIndex != -1) widget.onPress(touchedIndex);
                },
              ),
              sectionsSpace: 2,
              centerSpaceRadius: 60,
              sections: sections,
            ),
          ),
        ),
      ],
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(title: Text(text)),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: color,
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 5),
        ),
        Text(text),
      ],
    );
  }
}
