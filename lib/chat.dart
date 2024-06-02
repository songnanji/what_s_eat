import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘 뭐 먹지',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _addBotMessage(String text) {
    setState(() {
      _messages.add({'text': text, 'isBot': true});
    });
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add({'text': text, 'isBot': false});
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _addUserMessage(text);

    if (text.toLowerCase() == '응') {
      _showInitialOptions();
    } else if (text == '1') {
      _showFoodOptions();
    } else if (text == '2') {
      _showIngredientOptions();
    } else if (text == '3') {
      _showTasteOptions();
    } else {
      _addBotMessage("죄송합니다... 이해하지 못했습니다.");
    }
  }

  void _showInitialOptions() {
    _addBotMessage("다음 질문 중 하나를 선택해 주세요(답변은 숫자만 입력해주세요)");
    _addBotMessage("1. 먹고 싶은 음식의 종류는 무엇인가요?");
    _addBotMessage("2. 어떤 종류의 식재료를 먹고 싶나요?");
    _addBotMessage("3. 원하는 느낌의 음식이 있나요?");
  }

  void _showFoodOptions() {
    _addBotMessage("-한식: 비빔밥, 된장찌개, 김치찌개, 미역국, 떡국, 불고기, 떡볶이, 잔치국수, 칼국수, 쫄면, 비빔국수, 오징어볶음, 찜닭, 삼계탕, 삼겹살");
    _addBotMessage("-일식: 초밥, 라멘, 우동, 소바, 텐동, 규동, 사케동, 가츠동, 가라아게, 덴뿌라, 야끼니꾸");
    _addBotMessage("-양식: 파스타, 리조또, 피자, 스테이크, 뇨끼, 스프, 그라탕, 에그인헬, 라자냐, 샐러드, 감바스");
    _addBotMessage("-중식: 짜장면, 짬뽕, 탕수육, 마라탕, 꿔바로우, 마라샹궈, 울면, 마파두부, 고추잡채, 양장피, 팔보채, 깐풍기, 깐풍새우");
  }

  void _showIngredientOptions() {
    _addBotMessage("어떤 종류의 식재료를 원하시나요?");
    _addBotMessage("-고기 요리: 치킨, 찜닭, 불고기, 삼겹살, 돼지국밥, 제육볶음, LA갈비, 돼지갈비, 닭갈비, 오리주물럭, 곱창, 막창, 갈비탕");
    _addBotMessage("-채소 요리: 비빔밥, 샐러드, 월남쌈, 포케, 파전, 부추전, 야채스튜, 버섯볶음, 시금치나물, 콩나물국");
    _addBotMessage("-해산물 요리: 초밥, 해물탕, 해물찜, 해물파전, 물회, 회덮밥, 오징어볶음, 새우볶음밥, 문어숙회, 생선구이, 생선조림, 연어덮밥");
  }

  void _showTasteOptions() {
    _addBotMessage("원하는 느낌의 음식이 있나요?");
    _addBotMessage("-매운맛: 엽기떡볶이, 불닭볶음면, 닭발, 매운족발, 매운갈비찜, 매운탕, 낙지볶음, 마라탕");
    _addBotMessage("-안 매운맛: 비빔밥, 김밥, 미역국, 불고기, 삼계탕, 순대국, 갈비탕, 콩나물국밥, 북엇국, 해물파전");
    _addBotMessage("-국물 요리: 김치찌개, 된장찌개, 미역국, 순대국, 갈비탕, 콩나물국밥, 북엇국, 해물탕, 육개장, 닭개장");
    _addBotMessage("-볶음 요리: 제육볶음, 오징어볶음, 낙지볶음, 불고기, 닭갈비, 해물볶음밥, 김치볶음밥, 새우볶음밥, 소고기볶음밥, 볶음우동, 볶음밥");
    _addBotMessage("-시원한 음식: 냉면, 콩국수, 물냉면, 메밀국수, 초계탕, 냉우동, 냉모밀, 물회, 냉국, 냉채");
    _addBotMessage("-따뜻한 음식: 국밥, 떡국, 순대국, 갈비탕, 김치찌개, 된장찌개, 순두부 찌개, 삼계탕, 북엇국, 육개장, 닭개장");
  }

  @override
  void initState() {
    super.initState();
    _addBotMessage("안녕하세요! 식사 메뉴 선택을 도와드릴까요?(응 or 아니)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatting'),
      ),
      backgroundColor: Color(0xFFE6F7E9), // 파스텔톤 연두색 배경
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessage(message);
              },
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isBot = message['isBot'];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBot)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text('Bot'),
              ),
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isBot ? Colors.white : Colors.green[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                message['text'],
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          if (!isBot)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                child: Text('You'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: '메시지를 입력하세요'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
