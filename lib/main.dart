
import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userQuestion='';
  var userAnswer='';


  final List<String> buttons = [


    'AC','C','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','+/-','=',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black ,
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox( height: 100),
                    Container(
                      padding:EdgeInsets.all(30) ,
                        alignment:Alignment.centerRight ,
                        child: Text(userQuestion, style: TextStyle(color: Colors.white,fontSize:30 ),)),


                    Container(
                        padding:EdgeInsets.all(15) ,
                        alignment: Alignment.centerRight,
                        child: Text(userAnswer, style: TextStyle(color: Colors.white, fontSize: 30),)),


                  ],
                ),

              )
          ),
          Expanded(
            flex: 2,
              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: Container(
             child : GridView.builder(
             itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:(BuildContext context, int index){
                   if (index ==0) {
                  return MyButton(
                    buttonTapped:(){
                      setState(() {
                        userQuestion ='';
                        userAnswer =''; //  null that means nothing is returned
                      });



                    } ,
                    buttonText: buttons[index],
                    color: Colors.grey[50],
                    textcolor: Colors.black,
                  ) ;
                  }
                   else if (index ==1)
                     {
                       return MyButton(
                         buttonTapped: () {
                           setState(() {
                             userQuestion=userQuestion.substring(0,userQuestion.length-1);
                           });

                         },
                         buttonText: buttons[index],
                         color: Colors.grey[50],
                         textcolor: Colors.black,
                       );
                     }

                   //for equal button  at last
                   else if (index == buttons.length-1)
                   {
                     return MyButton(
                       buttonTapped: () {
                         setState(() {
                         equalPressed();
                         });
                       },
                       buttonText: buttons[index],
                       color: Colors.orange,
                       textcolor: Colors.white,
                     );
                   }

                   else if (index == buttons.length-2)
                   {
                     return MyButton(
                       buttonTapped: () {
                         setState(() {
                           userQuestion.toString().startsWith('-') ? userQuestion = userQuestion.toString().substring(1): userQuestion = '-'+userQuestion.toString();
                         });
                       },
                       buttonText: buttons[index],
                       color: Colors.grey[600],
                       textcolor: Colors.white,
                     );
                   }





                   else{
                   return  MyButton(
                     buttonTapped: (){
                       setState(() {
                         userQuestion=userQuestion +  buttons[index];

                       });
                     },
                       buttonText: buttons[index],
                       color: isOperator(buttons[index]) ? Colors.orange : Colors.grey[600],
                       textcolor: isOperator(buttons[index]) ? Colors.white : Colors.white,
                     );
                   }
                }
                  ),

                ),
              ),
          ),
        ],
      )

    );
  }
  bool isOperator (String y){
      if( y==' %'  || y== '/'  || y== 'x'  || y== '-' ||  y== '=' ||  y== '+') {
        return true;
      }
      return false;
    }

    void equalPressed(){
    String finalQuestion= userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer =eval.toString();



    }
}


