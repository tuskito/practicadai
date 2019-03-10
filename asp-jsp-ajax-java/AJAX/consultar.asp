<!-- #include file=conexion.asp -->
<%
  ' Accedemos al compañía 

  compania=request.QueryString("compania") 

  response.ContentType="text/xml"
  response.CacheControl="no-cache, must-revalidate"

  ' Consulta SQL de las compañias

  Set rs=Conexion.Execute("select * from COMPANIA where " & compania & "=IDCOMPANIA")


  ' Salida XML con la lista de compañias

  if (not(rs.Eof)) then

  %><?xml version="1.0" encoding="UTF-8"?> <%
  response.write("<XML>")
   
     ' Recorremos el Recorset
     do until rs.Eof

    response.write("<compania>")
    response.write("<idcompania>")
    response.write( rs("IDCOMPANIA") )
    response.write("</idcompania>")

    response.write("<nombre>")
    response.write( rs("COMPANIA") )
    response.write("</nombre>")

    response.write("</compania>")
     
    rs.MoveNext
  loop

  response.write("</XML>")

  end if  
%>    