<!-- #include file=conexion.asp -->
<%
      ' Script ASP programado con VBScript
      ' Realiza consulta en la base de datos y genera como resultato una lista de vuelos en formato XML
      ' Accedemos a la compañía desde la pagina principal

	origen=request.form("origen") 

  
	 response.ContentType="text/xml"
	 response.CacheControl="no-cache, must-revalidate"


      ' Consulta SQL de las ciudades que son origen de algun vuelo

    if (origen="")then
      Set rs=Conexion.Execute("select distinct CIUDAD_DESTINO from LISTA_VUELOS_PRECIO")
    else
      Set rs=Conexion.Execute("select CIUDAD_DESTINO from LISTA_VUELOS_PRECIO where CIUDAD_ORIGEN='"& origen &"'")
    end if
       ' Se genera una salida XML con la lista de vuelos
	  
        if (not(rs.Eof)) then
          %><?xml version="1.0" encoding="UTF-8"?> <%

		    response.write("<XML>")
  	     
           ' Recorremos el Recorset
         do until rs.Eof

	        response.write("<ciudad>")
          response.write("<nombre>")
          response.write( rs("CIUDAD_DESTINO") )
          response.write("</nombre>")
          response.write("</ciudad>")
             
			 
		    rs.MoveNext
        loop

      response.write("</XML>")
    
     end if  
%>    