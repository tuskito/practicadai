<!-- #include file=conexion.asp -->
<%
      ' Script ASP programado con VBScript
      ' Realiza consulta en la base de datos y genera como resultado una lista de vuelos en formato XML
      ' Accedemos a la compañía desde la pagina principal

	origen=request.form("origen") 
  destino=request.form("destino") 
  'origen="ALICANTE"
    ' El contenido a devolver es XML


	 response.ContentType="text/xml"
	 response.CacheControl="no-cache, must-revalidate"


      ' Consulta SQL de las ciudades que son origen de algun vuelo



              if (origen="" AND destino="") then
                Set rs=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO")

              elseif (origen="" AND destino <>"") then
                Set rs=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where CIUDAD_DESTINO='" & Ucase(destino) & "'")

              elseif (origen<>"" AND destino ="") then
                Set rs=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where  CIUDAD_ORIGEN='" & Ucase(origen) & "'")
              else 
                Set rs=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where CIUDAD_ORIGEN='" & Ucase(origen) & "' AND CIUDAD_DESTINO='" & Ucase(destino) & "'")

              end if
              

       ' Se genera una salida XML con la lista de vuelos
	  
        if (not(rs.Eof)) then
          %><?xml version="1.0" encoding="UTF-8"?> <%

		response.write("<XML>")
  	     
           ' Recorremos el Recorset
         do until rs.Eof

	        response.write("<vuelo>")
          response.write("<idvuelo>")
          response.write( rs("IDVUELO") )
          response.write("</idvuelo>")
          response.write("<origen>")
          response.write( rs("CIUDAD_ORIGEN") )
          response.write("</origen>")
          response.write("<destino>")
          response.write( rs("CIUDAD_DESTINO") )
          response.write("</destino>")
          response.write("<precio>")
          response.write(Round(rs("PRECIO"),2))
          response.write("</precio>")
          response.write("</vuelo>")
             
			 
		    rs.MoveNext
        loop

      response.write("</XML>")
    
     end if  
%>    