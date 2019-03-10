<!-- #include file=conexion.asp -->
<html>
<head>
	
  <script type="text/javascript">

	// FUNCIONES JAVASCRIPT
	
	// Creamos el objeto AJAX httprequest

    function AJAXCrearObjeto(){
    
       var obj;
     
       if (window.XMLHttpRequest) { // no es IE
      
          obj = new XMLHttpRequest();
	
      } 
      
      else { // Es IE o no tiene el objeto
      
         try {
         
           obj = new ActiveXObject("Microsoft.XMLHTTP");
	   
         }
         catch (e) {
           
           // alert('El navegador utilizado no está soportado');
          }
      }

      //alert('realizado');
      return obj;
   }
	
	
	
	
	// Recibe y muestra los vuelos que pertenecen a la compania seleccionada

   function leerDatos(){
	     
     // Comprobamos que se han recibido los datos
     
     if (oXML.readyState == 4) {
		

        // Accedemos al XML recibido

        var xml = oXML.responseXML.documentElement;
		
		

        // Accedemos al componente html correspondiente a la tabla

        var tabla = document.getElementById('tabla_vuelos');
        
        // Vaciamos el DIV
	  var definicion_tabla = new String("");

        // cadena con los datos para crear la tabla

          definicion_tabla ='<th>Id Vuelo</th><th>ID Ciudad Origen</th><th>ID Ciudad Destino</th><th>Fecha</th><th>Compa&ntilde;&iacute;a</th><th>Plazas Disponibles</th><th>Duraci&oacute;n</th><th>ID Avi&oacute;n</th><tr>';
          


         // Iteramos cada vuelo

          var v;
	      var item;

          
		  
		  for (i = 0; i < xml.getElementsByTagName('vuelo').length; i++){
	    
             // Accedemos al objeto XML 

             item = xml.getElementsByTagName('vuelo')[i];

 	        // Recuperamos el identificador de vuelo

                 v = item.getElementsByTagName('idvuelo')[0].firstChild.data;
 	             
				 
				 // Añadimos el campo a la tabla
				 
				 definicion_tabla =definicion_tabla+'<td>'+ v +'</td>';
            

           // Recuperamos el id de la ciudad de origen

            v = item.getElementsByTagName('ciudad_origen')[0].firstChild.data;

           // Añadimos el campo a la tabla

            definicion_tabla =definicion_tabla+'<td>'+ v +'</td>';


           // Recuperamos el id de la ciudad destino

            v = item.getElementsByTagName('ciudad_destino')[0].firstChild.data;

           // Añadimos el campo a la tabla

            definicion_tabla= definicion_tabla+'<td>' + v +'</td>';

	         // Recuperamos la fecha

            v = item.getElementsByTagName('fecha')[0].firstChild.data;

           // Añadimos el campo a la tabla

            definicion_tabla= definicion_tabla+'<td>' + v + '</td>';


           // Recuperamos la compania

            v = item.getElementsByTagName('compania')[0].firstChild.data;

           // Añadimos el campo a la tabla

            definicion_tabla= definicion_tabla+'<td>' + v + '</td>';

           // Recuperamos el numero de planzas disponibles

            v = item.getElementsByTagName('n_plazas_disponibles')[0].firstChild.data;

           // Añadimos el campo a la tabla

            definicion_tabla= definicion_tabla+'<td>' + v + '</td>';

            // Recuperamos la duracion del vuelo

            v = item.getElementsByTagName('duracion')[0].firstChild.data;

           // Añadimos el campo a la tabla

            definicion_tabla= definicion_tabla+'<td>' + v + '</td>';


            // Recuperamos el id de avion

            v = item.getElementsByTagName('avion')[0].firstChild.data;

           // añadimo el campo a la tabla

            definicion_tabla= definicion_tabla+'<td>' + v + '</td></tr>';
		
	
        }
        // rellenamos el objeto html tabla con la definicion construida

        tabla.innerHTML = definicion_tabla;
         
      }
       

  }
		
	
	function mostrar_vuelos(){
	
	
	// recupera el objeto html desplegable de companias

	 
	 var valorx=document.getElementById("compania").value;
	 

     // crea el objeto httprequest 

     oXML = AJAXCrearObjeto();
     oXML.open('POST', 'consultar.asp');
     oXML.onreadystatechange = leerDatos;

     oXML.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

     // lanza la peticion enviando los parametros 

     //oXML.send('compania='+valorx);
     oXML.send();
	}
	
  
    
   </script>	
	
</head>

<body>

Seleccione una Compa&ntilde;&iacute;a de Vuelo: 
<select name="compania" id="compania" onChange="return mostrar_vuelos()">
	
<%
Set origen = Conexion.Execute("select IDCOMPANIA, COMPANIA from COMPANIA order by COMPANIA")
	'Recorreremos el RecordSet
	do while not origen.EOF
			Response.Write("<option value='" & origen("IDCOMPANIA") & "'>" & origen("COMPANIA") &"</option>")
			'Nos desplazamos por el RecordSet
			origen.MoveNext
	loop
%>
</select>


<br><br>

<table id="tabla_vuelos" name="tabla_vuelos" border=1> 
     </table>

</body>
</html>