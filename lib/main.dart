import 'package:flutter/material.dart';
import 'local_database.dart';

void main() => runApp(const AliMuizApp());

const navy = Color(0xFF102A43);
const blue = Color(0xFF1769AA);
const teal = Color(0xFF2A9D8F);
const correctGreen = Color(0xFF218838);
const wrongRed = Color(0xFFD62828);

const units = [
  ('Health','الصحة',Icons.health_and_safety),
  ('Law','القانون',Icons.gavel),
  ('Careers','المهن',Icons.work),
  ('Unit Four','الوحدة الرابعة',Icons.menu_book),
  ('Tourism','السياحة',Icons.travel_explore),
  ('Business','الأعمال',Icons.business_center),
  ('Learning','التعلّم',Icons.school),
  ('Nature','الطبيعة',Icons.nature),
];

class AliMuizApp extends StatelessWidget {
  const AliMuizApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner:false,
    title:"ALI MU'IZ ENGLISH",
    theme:ThemeData(
      useMaterial3:true,
      colorScheme:ColorScheme.fromSeed(seedColor:blue),
      scaffoldBackgroundColor:const Color(0xFFF3F7FA),
      appBarTheme:const AppBarTheme(backgroundColor:navy,foregroundColor:Colors.white),
    ),
    home:const MainScreen(),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override State<MainScreen> createState()=>_MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int tab=0;
  @override Widget build(BuildContext context) {
    final pages=[const HomePage(),const UnitsPage(),const LiteraturePage(),const ProgressPage()];
    final labels=['Home','Course Units','Literature','My Progress'];
    return Scaffold(
      appBar:AppBar(title:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(labels[tab],style:const TextStyle(fontWeight:FontWeight.bold)),
        const Text("ALI MU'IZ ENGLISH",style:TextStyle(fontSize:10,letterSpacing:1.5))
      ])),
      body:pages[tab],
      bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(v)=>setState(()=>tab=v),destinations:const[
        NavigationDestination(icon:Icon(Icons.home_outlined),label:'Home'),
        NavigationDestination(icon:Icon(Icons.menu_book_outlined),label:'Units'),
        NavigationDestination(icon:Icon(Icons.auto_stories_outlined),label:'Literature'),
        NavigationDestination(icon:Icon(Icons.insights_outlined),label:'Progress'),
      ]),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    Container(padding:const EdgeInsets.all(24),decoration:BoxDecoration(gradient:const LinearGradient(colors:[navy,blue]),borderRadius:BorderRadius.circular(22)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text('Welcome back!',style:TextStyle(color:Colors.white70)),
      SizedBox(height:8),Text('Learn English\nStep by Step',style:TextStyle(color:Colors.white,fontSize:28,fontWeight:FontWeight.bold)),
      SizedBox(height:8),Text('Your learning journey starts here.',style:TextStyle(color:Colors.white70))
    ])),
    const SizedBox(height:22),const Heading('Explore','استكشف'),
    Wrap(spacing:10,runSpacing:10,children:[
      const Feature('Vocabulary','المفردات',Icons.translate,blue),
      const Feature('Grammar','القواعد',Icons.rule,teal),
      const Feature('Reading','القطع الخارجية',Icons.chrome_reader_mode,Color(0xFF805AD5)),
      InkWell(
        borderRadius:BorderRadius.circular(16),
        onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const ExercisesPage())),
        child:const Feature('Exercises','التمارين',Icons.quiz,Color(0xFFE09F3E)),
      ),
    ]),
    const SizedBox(height:22),const Heading('Course Units','الوحدات الدراسية'),
    ...List.generate(3,(i)=>UnitCard(index:i)),
    const SizedBox(height:8),
    FilledButton.icon(
      onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const ExercisesPage())),
      icon:const Icon(Icons.play_arrow),label:const Text('Try Sample Exercises'),
    )
  ]);
}
class Heading extends StatelessWidget {
 final String en,ar; const Heading(this.en,this.ar,{super.key});
 @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.only(bottom:10),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
  Text(en,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:navy)),Text(ar,style:const TextStyle(color:Colors.black54))
 ]));
}
class Feature extends StatelessWidget {
 final String en,ar; final IconData icon; final Color color;
 const Feature(this.en,this.ar,this.icon,this.color,{super.key});
 @override Widget build(BuildContext context)=>SizedBox(width:MediaQuery.sizeOf(context).width/2-24,child:Card(child:Padding(padding:const EdgeInsets.all(15),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  Icon(icon,color:color,size:28),const SizedBox(height:10),Text(en,style:const TextStyle(fontWeight:FontWeight.bold)),Text(ar,style:const TextStyle(color:Colors.black54,fontSize:12))
 ]))));
}
class UnitsPage extends StatelessWidget {
 const UnitsPage({super.key});
 @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
  const Text('Choose your unit',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold,color:navy)),
  const Text('اختر الوحدة الدراسية',style:TextStyle(color:Colors.black54)),const SizedBox(height:15),
  ...List.generate(8,(i)=>UnitCard(index:i))
 ]);
}
class UnitCard extends StatelessWidget {
 final int index; const UnitCard({required this.index,super.key});
 @override Widget build(BuildContext context){
  final u=units[index];
  return Card(margin:const EdgeInsets.only(bottom:10),child:ListTile(
   leading:CircleAvatar(backgroundColor:const Color(0xFFE7F0F8),child:Icon(u.$3,color:blue)),
   title:Text('Unit ${index+1} – ${u.$1}',style:const TextStyle(fontWeight:FontWeight.bold)),
   subtitle:Text(u.$2),trailing:const Icon(Icons.chevron_right),
   onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>UnitDetail(index:index)))
  ));
 }
}
class UnitDetail extends StatelessWidget {
 final int index; const UnitDetail({required this.index,super.key});
 @override Widget build(BuildContext context){final u=units[index];return Scaffold(appBar:AppBar(title:Text('Unit ${index+1} – ${u.$1}')),body:ListView(padding:const EdgeInsets.all(18),children:[
  Text(u.$2,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:navy)),
  ...['Target Vocabulary','Lessons','Grammar','Reading','Exercises','Unit Test'].map((s)=>Card(child:ListTile(
    title:Text(s),trailing:const Icon(Icons.chevron_right),
    onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const ExercisesPage()))
  )))
 ]));}
}
class LiteraturePage extends StatelessWidget {
 const LiteraturePage({super.key});
 @override Widget build(BuildContext context)=>const Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
  Icon(Icons.auto_stories,size:58,color:blue),SizedBox(height:12),Text('Literature',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold,color:navy)),Text('الأدب')
 ]));
}
class ProgressPage extends StatefulWidget {
 const ProgressPage({super.key});
 @override State<ProgressPage> createState()=>_ProgressPageState();
}
class _ProgressPageState extends State<ProgressPage> {
 late Future<List<Map<String,Object?>>> results;
 late Future<Map<String,Object?>> summary;
 void reload(){results=LocalDatabase.instance.getResults();summary=LocalDatabase.instance.getSummary();}
 @override void initState(){super.initState();reload();}
 @override Widget build(BuildContext context)=>RefreshIndicator(
  onRefresh:()async{setState(reload);await results;},
  child:ListView(padding:const EdgeInsets.all(18),children:[
   const Text('My Progress',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold,color:navy)),
   const Text('تقدّم الطالب',style:TextStyle(color:Colors.black54)),
   const SizedBox(height:15),
   FutureBuilder<Map<String,Object?>>(future:summary,builder:(context,snapshot){
    final d=snapshot.data??{'attempts':0,'earned':0,'possible':0};
    return Row(children:[
     Expanded(child:StatCard('Attempts','${d['attempts']??0}',Icons.assignment_turned_in)),
     const SizedBox(width:10),
     Expanded(child:StatCard('Points','${d['earned']??0}/${d['possible']??0}',Icons.stars)),
    ]);
   }),
   const SizedBox(height:20),
   const Text('Recent Results',style:TextStyle(fontWeight:FontWeight.bold,fontSize:18,color:navy)),
   const SizedBox(height:8),
   FutureBuilder<List<Map<String,Object?>>>(future:results,builder:(context,snapshot){
    if(snapshot.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
    final rows=snapshot.data??[];
    if(rows.isEmpty)return const Card(child:Padding(padding:EdgeInsets.all(18),child:Text('No results yet. Complete a practice quiz to see your scores here.\\nلا توجد نتائج بعد. أكمل اختباراً تجريبياً لعرض درجاتك.')));
    return Column(children:rows.map((r)=>Card(child:ListTile(
     leading:const CircleAvatar(child:Icon(Icons.quiz)),
     title:Text('${r['quiz_name']}'),
     subtitle:Text('${r['completed_at']}'),
     trailing:Text('${r['score']} / ${r['total']}',style:const TextStyle(fontWeight:FontWeight.bold,color:teal)),
    ))).toList());
   }),
  ])
 );
}
class StatCard extends StatelessWidget {
 final String title,value; final IconData icon;
 const StatCard(this.title,this.value,this.icon,{super.key});
 @override Widget build(BuildContext context)=>Card(child:Padding(padding:const EdgeInsets.all(15),child:Column(children:[
  Icon(icon,color:teal,size:28),const SizedBox(height:6),
  Text(value,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:navy)),
  Text(title,style:const TextStyle(color:Colors.black54))
 ])));
}

// Demonstration exercise engine: multiple choice, fill-in, dropdown, written and matching.
class ExercisesPage extends StatefulWidget {
 const ExercisesPage({super.key});
 @override State<ExercisesPage> createState()=>_ExercisesPageState();
}
class _ExercisesPageState extends State<ExercisesPage> {
 int step=0, score=0;
 String? selected;
 final textController=TextEditingController();
 final answers=[false,false,false,false,false];
 final questions=[
  ('Multiple Choice','Choose the correct answer.','She ___ to school every day.',['go','goes','going','gone'],'goes','اخترنا goes لأن الفاعل She مفرد غائب، لذلك نضيف s للفعل في المضارع البسيط.'),
  ('Fill in the Blanks','Complete the sentence.','They are interested ___ science.',['in'],'in','حرف الجر الصحيح بعد interested هو in.'),
  ('Dropdown','Select the correct word.','If I study hard, I ___ pass the exam.',['will','would','was','has'],'will','نستخدم will في الجملة الشرطية الحقيقية من النوع الأول.'),
  ('Written Exercise','Write the correct past form.','Yesterday, Ali ___ (visit) his friend.',['visited'],'visited','الفعل visit منتظم، ونضيف ed لتكوين الماضي البسيط.'),
  ('Matching','Choose the matching meaning.','“Environment” means:',['البيئة','القانون','المهنة','الصحة'],'البيئة','Environment تعني البيئة.'),
 ];
 @override void dispose(){textController.dispose();super.dispose();}
 void check(){
  final q=questions[step];
  final response=step==3?textController.text.trim().toLowerCase():(selected??'').toLowerCase();
  final ok=response==q.$5.toLowerCase();
  setState(()=>answers[step]=ok);
  if(ok)score++;
  showDialog(context:context,builder:(_)=>AlertDialog(
   title:Row(children:[
    Icon(ok?Icons.check_circle:Icons.cancel,color:ok?correctGreen:wrongRed),
    const SizedBox(width:8),Text(ok?'Correct!':'Not quite')
   ]),
   content:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(ok?'إجابة صحيحة، أحسنت!':'الإجابة غير صحيحة. حاول فهم القاعدة ثم أعد المحاولة.',style:TextStyle(color:ok?correctGreen:wrongRed,fontWeight:FontWeight.bold)),
    const SizedBox(height:10),Text('Correct answer: ${q.$5}',style:const TextStyle(fontWeight:FontWeight.bold)),
    const SizedBox(height:8),Text(q.$6),
   ]),
   actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Continue'))],
  ));
 }
 void next(){
  if(step<questions.length-1){setState(()=>step++);selected=null;textController.clear();}
  else {
  LocalDatabase.instance.saveQuizResult('Sample Practice',score,questions.length);
  showDialog(context:context,builder:(_)=>AlertDialog(
    title:const Text('Practice completed'),
    content:Text('Your sample score: $score / ${questions.length}\nنتيجتك في هذا التدريب التجريبي'),
    actions:[TextButton(onPressed:(){Navigator.pop(context);setState((){step=0;score=0;answers.fillRange(0,answers.length,false);selected=null;textController.clear();});},child:const Text('Try Again'))],
  ));}
 }
 @override Widget build(BuildContext context){
  final q=questions[step];
  return Scaffold(
   appBar:AppBar(title:const Text('Practice Exercises')),
   body:ListView(padding:const EdgeInsets.all(18),children:[
    Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
     Text('Question ${step+1} of ${questions.length}',style:const TextStyle(fontWeight:FontWeight.bold,color:navy)),
     Text('Score: $score',style:const TextStyle(fontWeight:FontWeight.bold,color:teal))
    ]),
    const SizedBox(height:8),LinearProgressIndicator(value:(step+1)/questions.length,color:teal,backgroundColor:Colors.black12),
    const SizedBox(height:20),
    Card(child:Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
     Text(q.$1,style:const TextStyle(color:blue,fontWeight:FontWeight.bold)),
     const SizedBox(height:8),Text(q.$2,style:const TextStyle(color:Colors.black54)),
     const SizedBox(height:18),Text(q.$3,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:navy)),
     const SizedBox(height:18),
     if(step==3) TextField(controller:textController,decoration:const InputDecoration(border:OutlineInputBorder(),hintText:'Type your answer here'))
     else ...q.$4.map((option)=>Padding(padding:const EdgeInsets.only(bottom:8),child:InkWell(
      onTap:()=>setState(()=>selected=option),
      child:Container(width:double.infinity,padding:const EdgeInsets.all(14),decoration:BoxDecoration(
       color:selected==option?const Color(0xFFE4F1FA):Colors.white,
       border:Border.all(color:selected==option?blue:Colors.black12,width:selected==option?2:1),
       borderRadius:BorderRadius.circular(12)),
       child:Text(option,style:TextStyle(fontWeight:selected==option?FontWeight.bold:FontWeight.normal))
      )
     ))),
    ]))),
    const SizedBox(height:14),
    FilledButton.icon(onPressed:(step==3?textController.text.trim().isNotEmpty:selected!=null)?check:null,icon:const Icon(Icons.check),label:const Text('Check Answer')),
    const SizedBox(height:8),
    OutlinedButton(onPressed:next,child:Text(step==questions.length-1?'Finish Practice':'Next Question')),
    const SizedBox(height:14),
    const Text('Note: These are sample questions to test the interface. Your curriculum questions will be added from your approved materials.',style:TextStyle(color:Colors.black54,fontSize:12)),
   ]),
  );
 }
}
