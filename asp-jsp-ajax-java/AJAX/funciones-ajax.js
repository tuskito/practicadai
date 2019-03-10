
	
// Creamos el objeto AJAX httprequest

function AJAXCrearObjeto(){   
  var obj;   
  if (window.XMLHttpRequest) { // no es IE   
    obj = new XMLHttpRequest();
	//alert('El navegador no es IE');
  }     
  else { // Es IE o no tiene el objeto    
    try {   
      obj = new ActiveXObject("Microsoft.XMLHTTP");
	   // alert('El navegador utilizado es IE');
    }
    catch (e) {
      // alert('El navegador utilizado no está soportado');
    }
  }
  //alert('realizado');
  return obj;
}



function leerDatos_Compania(){
	
	// Comprobamos que se han recibido los datos
	if (oXML.readyState == 4) {
		
		// Accedemos al XML recibido
		var xml = oXML.responseXML.documentElement;
		// Accedemos al componente html correspondiente a la tabla
		var tabla = document.getElementById('tabla_compania');
		// cadena con los datos para crear la tabla
		var definicion_tabla = new String("");

		definicion_tabla ='<tr><td>Id Compañia</td><td>Compañia</td>';

		var v;
		var item;      
		  
		for (i = 0; i < xml.getElementsByTagName('compania').length; i++){
		  // Accedemos al objeto XML 
		  item = xml.getElementsByTagName('compania')[i];
		  cont = 0;

		  // Recuperamos el identificador de compañia
		  compania = item.getElementsByTagName('idcompania')[0].firstChild.data;
				   
		  // Añadimos el campo a la tabla
		  definicion_tabla =definicion_tabla+'<tr><td>'+ compania +'</td>';

		  // Recuperamos el nombre de la compañia
		  v = item.getElementsByTagName('nombre')[0].firstChild.data;

		  // Añadimos el campo a la tabla
		  cont = cont + 1;
		  definicion_tabla =definicion_tabla+"<td><input type='text' value='"+ v +"' name='"+ cont +"' /></td>";
		  
		  
		  definicion_tabla = definicion_tabla + "<tr><td colspan='4'><input id='submit' type='submit' value='Modificar'/></td></tr>";

		  document.getElementById("form_compania").action = "companias.asp?compania="+ compania

		  definicion_tabla = definicion_tabla + "<tr><td colspan='4'><a href='companias.asp?compania=" + compania + "&eliminar=true'><input type='button' value='Eliminar'</td></tr>"; 
		}
		tabla.innerHTML = definicion_tabla;
	}
}


function leerDatos_Ciudad(){
  // Comprobamos que se han recibido los datos
  if (oXML.readyState == 4) {
    // Accedemos al XML recibido
    var xml = oXML.responseXML.documentElement;
    // Accedemos al componente html correspondiente a la tabla
    var destino = document.getElementById('destino');
 
 
    var definicion = new String("");
    
    // Iteramos cada vuelo
    var ciudad;
    var item;      
    definicion = "<option value=''>TODOS</option>"
    for (i = 0; i < xml.getElementsByTagName('ciudad').length; i++){
      // Accedemos al objeto XML 
      item = xml.getElementsByTagName('ciudad')[i];
      

      // Recuperamos el identificador de vuelo
      ciudad = item.getElementsByTagName('nombre')[0].firstChild.data;
               
      // Añadimos el campo a la tabla
      definicion = definicion + '<option>' + ciudad + '</option>';

    }
    destino.innerHTML = definicion;
  }
}



function leerDatos_Vuelo(){
  // Comprobamos que se han recibido los datos
  if (oXML.readyState == 4) {
    // Accedemos al XML recibido
    var xml = oXML.responseXML.documentElement;
    // Accedemos al componente html correspondiente a la tabla
    var tabla = document.getElementById('tabla_vuelos');
 
    var definicion_tabla = new String("");

    // cadena con los datos para crear la tabla
    definicion_tabla ='<tr><td>ORIGEN</td><td>DESTINO</td><td>PRECIO</td><td>PLAZAS</td></tr>';
    
    // Iteramos cada vuelo
    var item;      
      
    for (i = 0; i < xml.getElementsByTagName('vuelo').length; i++){
      // Accedemos al objeto XML 


      item = xml.getElementsByTagName('vuelo')[i];
      id = item.getElementsByTagName('idvuelo')[0].firstChild.data;


      definicion_tabla =definicion_tabla+"<form action='reserva.asp?idvuelo=" + id + "' method='post' id='" + i + "'></form>";

      

      // Recuperamos el identificador de vuelo
      origen = item.getElementsByTagName('origen')[0].firstChild.data;
               
      // Añadimos el campo a la tabla

      definicion_tabla =definicion_tabla+'<tr><td>'+ origen +'</td>';

      // Recuperamos el id de la ciudad de origen
      destino = item.getElementsByTagName('destino')[0].firstChild.data;

      // Añadimos el campo a la tabla
      definicion_tabla =definicion_tabla+"<td>" + destino + "</td>";

      // Recuperamos el id de la ciudad de origen
      precio = item.getElementsByTagName('precio')[0].firstChild.data;

      // Añadimos el campo a la tabla
      definicion_tabla =definicion_tabla+"<td>" + precio + "€" + "</td>";

      // Añadimos el campo a la tabla
      definicion_tabla =definicion_tabla+"<td><input type='number' name='plazas'  required  min='1' form='" + i + "'/></td>";

      // Recuperamos la fecha 
      definicion_tabla =definicion_tabla+"<td><input type='submit' value='Reservar' form='" + i + "'/></td></tr>";
      
    }

    tabla.innerHTML = definicion_tabla;
  }
}

  
function mostrar_companias(idCompania){  

  // crea el objeto httprequest 
  oXML = AJAXCrearObjeto();
  oXML.open('GET', 'consultar.asp?compania=' + idCompania);
  oXML.onreadystatechange = leerDatos_Compania;
  oXML.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

  // lanza la peticion 
  oXML.send();
}



function mostrar_vuelos(){  
var origen=document.getElementById("origen").value;
var destino=document.getElementById("destino").value;

  // crea el objeto httprequest 
  oXML = AJAXCrearObjeto();
  oXML.open('POST', 'consulta_vuelos.asp');
  oXML.onreadystatechange = leerDatos_Vuelo;
  oXML.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

  // lanza la peticion 
  oXML.send('origen=' + origen + '&destino='+ destino);
}


function mostrar_ciudades(){  
   
  var origen=document.getElementById("origen").value;
 //alert(origen)
  oXML = AJAXCrearObjeto();
  oXML.open('POST', 'consulta_ciudades.asp');
  //oXML.open('GET', 'consulta_ciudades.asp?ciudad=' + ciudad);
  oXML.onreadystatechange = leerDatos_Ciudad;

  oXML.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

  // lanza la peticion enviando los parametros 
  // oXML.send();
  oXML.send('origen=' + origen);
}