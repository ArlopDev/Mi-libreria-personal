

import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {

  const PantallaPrincipal();

  @override
  State<StatefulWidget> createState() {
    return _PantallaPrincipalState();
  }
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //APPBAR
      appBar: AppBar(

        //TITLE
        title: Text("Mi mejor app",),
        centerTitle: true,

        //LEADING - OPCION A LA IZQUIERDA
        leading: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.amber,
              height: 50,
              width: 100,
              child: IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.lightbulb, color: Colors.white,)
              ),
            )
          ],
        ),

        //ACTIONS - OPCIONES A LA DERECHA
        actions: [
          Column(
            children: [
              Icon(Icons.save_alt_rounded, size: 30,),
              Icon(Icons.save_alt_rounded, color: Colors.purple,),
            ],
          ),
          Column(
            children: [
              Icon(Icons.save_alt_rounded, color: Colors.amber,),
              Icon(Icons.save_alt_rounded, size: 15,),
            ],
          ),
        ],

        //ELEVATION - SOMBRITA DE LA APPBAR
        elevation: 10,
        shadowColor: Colors.red,


        //BackgroundColor - Color de fondo, se combina raro con el color del 
        //flexibleSpace
        backgroundColor: Colors.greenAccent,

        //flexibleSpace - aun no lo pruebo parece mas backgound color
        flexibleSpace: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.centerRight,
            //   end: Alignment.centerLeft,
            //   colors: [Colors.cyan[100]!, Colors.cyan[800]!]
            // ),
          ),
        ),

        //SHAPE - forma del appbar , funciona raro con el flexibleSpace,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(bottomRight: Radius.circular(100))
        ),


        bottom: PreferredSize(
          preferredSize: Size(20, 50),
          child: Container(
            child: ElevatedButton(onPressed: (){}, child: Text("NO hago nada")),
          ),
        ),

      ),
      

      //BODY - WIDGET DE DENTRO
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.purple,
              child: Text(
                "Esto es el body"
              ),

            ),
          ],
        ),
      ),
    );
  }
}