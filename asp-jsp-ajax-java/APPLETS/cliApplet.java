import java.net.*;
import java.io.*;
import java.util.*;
import java.awt.*;
import java.text.*;
import java.applet.*;
import java.awt.event.*;
import java.util.StringTokenizer;

public class cliApplet extends Applet {

// variables para la conexion con la pagina ASP / PHP
    
String hostName, applicationPath, webServerStr, applicationGet;
int port;  
int nlinea=0;

// Creación de los controles de controles
	
// Etiquetas	
Label etiqueta_idvuelo;
Label etiqueta_ciudadorigen;
Label etiqueta_ciudaddestino;
Label etiqueta_fecha;
Label etiqueta_compania;
Label etiqueta_avion;
Label etiqueta_duracion;
Label etiqueta_plazas;
	
// Campos de Texto
TextField campo_fecha;
TextField campo_duracion;
TextField campo_plazas;
    
    
// Listas desplegables
Choice lista_idvuelo;
Choice campo_compania;
Choice campo_avion;
Choice campo_ciudadorigen;
Choice campo_ciudaddestino;
// Botones		
Button boton_consultar;	

// Areas de texto		
TextArea ta;

@Override
public void init(){


etiqueta_idvuelo= new Label("BUSCAR ID");
etiqueta_idvuelo.setForeground(Color.RED);
etiqueta_ciudadorigen= new Label("Origen");
etiqueta_ciudaddestino= new Label("Destino");
etiqueta_fecha= new Label("Fecha");
etiqueta_compania= new Label("Compania");
etiqueta_avion= new Label("Avion");
etiqueta_duracion= new Label("Duracion");
etiqueta_plazas= new Label("Plazas");
    
	
lista_idvuelo = new Choice();
lista_idvuelo.add("Seleccione...");
//lista_idvuelo.add("1");
//lista_idvuelo.add("2");
//... aquí se rellenarían los valores de la lista desplegable...
	
campo_ciudadorigen = new Choice();
/*campo_ciudadorigen.add("1");
campo_ciudadorigen.add("2");*/
campo_ciudaddestino = new Choice();	
campo_compania = new Choice();
campo_avion = new Choice();

/*campo_ciudadorigen= new TextField(9);
campo_ciudaddestino= new TextField(9);*/
campo_fecha= new TextField(12);
//campo_compania= new TextField(9);
//campo_avion= new TextField(9);
campo_duracion= new TextField(20);
campo_plazas= new TextField(9);
	
boton_consultar=new Button(" Insertar / Modificar ");

	
ta=new TextArea(3,117);

// Disposicion de los controles en la pantalla     
    
GridBagLayout gbl=new GridBagLayout();
   
GridBagConstraints gbc=new GridBagConstraints(); 
// El objeto gbc tiene los valores por defecto para gridwidth, anchor, fill, etc. 
// el cambio permanece hasta que se vuelve a establecer otro valor.
    
// Establecer el gestor de diseño GridBagLayout mediante setLayout.
setLayout(gbl);
	
// Se añaden los controles por filas
gbc.anchor=GridBagConstraints.NORTH; 
// los objetos están anclados a la parte de arriba de su celda correspondiente
gbc.gridwidth=GridBagConstraints.REMAINDER;
gbc.insets=new Insets(20,20,0,0); 
// especifica el padding entre los componentes del objeto gbc (padding abajo,izquierda,derecha,arriba)
	
// Nueva fila
    
gbc.anchor=GridBagConstraints.WEST;  
// los componentes se anclan a la izquierda dentro de su celda correspondiente
gbc.gridwidth=1; 
// valor por defecto para la anchura, para que los objetos ocupen la anchura disponible
   
add(etiqueta_idvuelo, gbc);
add(etiqueta_ciudadorigen, gbc);
add(etiqueta_ciudaddestino, gbc);
add(etiqueta_fecha, gbc);
add(etiqueta_compania, gbc);
add(etiqueta_avion, gbc);
add(etiqueta_duracion, gbc);
gbc.gridwidth = GridBagConstraints.REMAINDER;  
// Esto hace que el siguiente componente sea el último de la fila
add(etiqueta_plazas, gbc);
	 
// Nueva fila
gbc.anchor=GridBagConstraints.WEST;
gbc.gridwidth=1;
add(lista_idvuelo, gbc);
add(campo_ciudadorigen, gbc);
add(campo_ciudaddestino, gbc);
add(campo_fecha, gbc);
add(campo_compania, gbc);
add(campo_avion, gbc);
add(campo_duracion, gbc);
add(campo_plazas, gbc);
gbc.gridwidth = GridBagConstraints.REMAINDER;

add(boton_consultar, gbc);
	
// Nueva fila
gbc.anchor=GridBagConstraints.WEST;
gbc.gridwidth=1;
gbc.gridx=1; // desplazo el area de texto 1 unidad a la derecha
gbc.gridwidth = GridBagConstraints.REMAINDER;
add(ta, gbc);


// Ejemplos de Inicializacion de los controles de lista
// llama a la pagina ASP con diferentes consultas
// vuelos origen, vuelos destino....y rellena las listas

    recibe_datos("Consulta1","0");	
     recibe_datos("ConsultaCiudad","0");		
       recibe_datos("ConsultaAvion","0");	
        recibe_datos("ConsultaCompania","0");	

} // termina public void init()

	



//  Función que llama a la pagina ASP indicando que solicita datos
// dependiando del valor del campo Accion recibiremos datos
// para rellenar los controles de ciudades, vuelos, avion, compañia...
   
 public void recibe_datos(String consulta, String idvuelo){

   try {
       
    
    // Pagina ASP destino
       
     // Obtiene la URL del documento donde el applet está incrustado
	 URL hostURL = getDocumentBase(); 
	 
	 // Sustituimos el nombre del fichero HTML por el nombre del archivo ASP destino
     applicationPath=hostURL.getPath().toString().replace("/administrador.asp","/servApplet.asp");
     
     // Obtenemos el nombre del host
     //hostName = hostURL.getHost();
	
	// Obtenemos el puerto
     port = hostURL.getPort();

     if (port == -1)
       port = 80;
       
     webServerStr = "http://localhost:" + port + applicationPath;
     
	 //webServerStr = "http://" + hostName + ":" + port + applicationPath;
	 


     if (consulta.equals("Modificacion") || consulta.equals("Inserccion")) {

     	 applicationGet = webServerStr + "?" + 

     URLEncoder.encode("Accion") + "=" + consulta+ "&" +

     URLEncoder.encode("idvuelo") + "=" + idvuelo

     	+ "&" + URLEncoder.encode("origen") + "=" + campo_ciudadorigen.getSelectedItem() + "&" +

       URLEncoder.encode("destino") + "=" + campo_ciudaddestino.getSelectedItem() + "&" +
       URLEncoder.encode("fecha") + "=" + campo_fecha.getText() + "&" +
       URLEncoder.encode("compania") + "=" + campo_compania.getSelectedItem() + "&" +
       URLEncoder.encode("avion") + "=" + campo_avion.getSelectedItem()+ "&" +
       URLEncoder.encode("duracion") + "=" + campo_duracion.getText() + "&" +
       URLEncoder.encode("plazas") + "=" + campo_plazas.getText();
     }
     else
     {
     	 applicationGet = webServerStr + "?" + 

     	URLEncoder.encode("Accion") + "=" + consulta+ "&" +

     	URLEncoder.encode("idvuelo") + "=" + idvuelo;
     }

     //ta.append(applicationGet);  // mostrar en una caja de texto la variable applicationGet

    
	/*   
	Si llamamos a esta función de la siguiente forma recibe_datos("Consulta1","0"); 
	
	Tendríamos en applicationGet:
	http://localhost:80/ruta_del_fichero_ASP/serv_applet.asp?Accion=Consulta1&idvuelo=0
	
	*/
	
	
	// Abrimos la conexion 
	
	/* Se crea una conexión http al servidor por el que fluyen los datos con varias clases Java que trabajan conjuntamente
	   a varios niveles   */
    
    URL servApplet = new URL(applicationGet);

    URLConnection servAppletConnection = servApplet.openConnection();

    DataInputStream dis = new DataInputStream(servAppletConnection.getInputStream());
   
    String inputLine; // obtebemos la cadena de texto que devuelve la página de servidor servapplet.asp

    
	
	// Leemos los datos y rellenamos el control que proceda
    // según la consulta que hemos realizado a través de la llamada correspondiente
	
	// mientras la consulta realizada al fichero serv_applet.asp vaya devolviendo tuplas, las tuplas empiezan por la fila 0
    while ((inputLine = dis.readLine()) != null) {      
	   // si la consulta ejecutada es la Consulta1, por cada vuelta del bucle, añadimos una vuelo al cuadro de lista idvuelo
	   if (consulta.equals("Consulta1"))
	   {
		if (nlinea==0) // si es la primera linea, es la sentencia sql a ejecutar, la escribo en la caja de texto
				ta.setText(inputLine);
		else	// si no es la primera linea, voy rellenando la lista idvuelo con cada uno de los ids de vuelo
				lista_idvuelo.addItem(inputLine);
	   }

	    if (consulta.equals("ConsultaCiudad"))
	   {
		if (nlinea==0) // si es la primera linea, es la sentencia sql a ejecutar, la escribo en la caja de texto
				ta.setText(inputLine);
		else{// si no es la primera linea, voy rellenando la lista idvuelo con cada uno de los ids de vuelo
				campo_ciudadorigen.addItem(inputLine);
				campo_ciudaddestino.addItem(inputLine);
			}
	   }

	    if (consulta.equals("ConsultaAvion"))
	   {
		if (nlinea==0) // si es la primera linea, es la sentencia sql a ejecutar, la escribo en la caja de texto
				ta.setText(inputLine);
		else	// si no es la primera linea, voy rellenando la lista idvuelo con cada uno de los ids de vuelo
				campo_avion.addItem(inputLine);
	   }

	    if (consulta.equals("ConsultaCompania"))
	   {
		if (nlinea==0) // si es la primera linea, es la sentencia sql a ejecutar, la escribo en la caja de texto
				ta.setText(inputLine);
		else	// si no es la primera linea, voy rellenando la lista idvuelo con cada uno de los ids de vuelo
				campo_compania.addItem(inputLine);
	   }

	   else if (consulta.equals("Consulta2"))
	   {
			StringTokenizer st = new StringTokenizer(inputLine,"-");
				campo_ciudadorigen.select(st.nextToken());
				campo_ciudaddestino.select(st.nextToken());
				campo_fecha.setText(st.nextToken());
				campo_compania.select(st.nextToken());
				campo_avion.select(st.nextToken());
				campo_duracion.setText(st.nextToken());
				campo_plazas.setText(st.nextToken());
				ta.setText(st.nextToken());

	   }

	   else if (consulta.equals("Modificacion"))
	   {
			ta.setText(inputLine);
	   }
	   else if (consulta.equals("Inserccion"))
	   {
			ta.setText(inputLine);
	   }
		  
       
       /* else if (consulta.equals("Consulta6"))
          // Códigos de vuelo disponibles
		  lista_idvuelo.addItem(inputLine); */
		  
		  
		  
		  nlinea=nlinea+1;
		  }
// Cerramos la conexion  
   dis.close();
  
 } 
 catch (MalformedURLException me) {
     System.out.println("MalformedURLException: " + me);
 } 
 catch (IOException ioe) {
     System.out.println("IOException: " + ioe);
 }

}   // Termina public void recibe_datos()
	

//Capturamos Evento clic sobre el botón


// Control del evento producido click, enter.....
    public boolean action( Event evt,Object obj ) {
	
	if( evt.target.equals( boton_consultar ) )
    {
		if (lista_idvuelo.getSelectedItem()!="Seleccione...")
			recibe_datos("Modificacion",lista_idvuelo.getSelectedItem());
		else
			recibe_datos("Inserccion",lista_idvuelo.getSelectedItem());

	}
	
	
	// Aquí podemos controlar los eventos sobre los distintos controles del interfaz ...
	
	if( evt.target.equals( lista_idvuelo ) )
			{
			recibe_datos("Consulta2",lista_idvuelo.getSelectedItem());
			}


	return true;
	}

}