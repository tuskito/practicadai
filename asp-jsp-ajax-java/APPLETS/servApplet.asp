<!-- #include file=conexion.asp -->
<%
' Script ASP
      ' Se utiliza para insertar, actualizar o consultar vuelos
      
      
      ' Recibe los siguientes parametros
      ' 
      '   Accion : Valores "ConsultaX",  "Insertar" o "Actualizar"
      '            Según este valor se realizara un select,insert o update
      '
      '   idvuelo: valor del codigo de vuelo
               

 
   '---- Leemos los parametros recibidos por GET */
  
   

' Recibimos el tipo de acción a realizar, mediante GET
variable1=request.querystring("Accion")
' Recibimos el id del vuelo mediante GET
variable2=request.querystring("idvuelo")

  
 ' Diferentes consultas SQL según el valor de los parametros de entrada

 ' Estas funciones seran utilizadas para llenar con datos los controles del applet

 if (variable1 = "Consulta1") then

    consulta = "SELECT DISTINCT IDVUELO from VUELO"
	'escribo el select ejecutado para el area de texto a modo de LOG
	
	Response.Write(consulta) & vbCrLf
	
	Set origen = Conexion.Execute(consulta)
	'Recorreremos el RecordSet
	do while not origen.EOF
			Response.Write(origen("IDVUELO") & vbCrLf)
			'Nos desplazamos por el RecordSet
			origen.MoveNext
	loop 
	
end if

if (variable1 = "ConsultaCiudad") then

    consulta = "SELECT DISTINCT IDCIUDAD from CIUDAD"
   
   Set origen = Conexion.Execute(consulta)
   'Recorreremos el RecordSet
   do while not origen.EOF
         Response.Write(origen("IDCIUDAD") & vbCrLf)
         'Nos desplazamos por el RecordSet
         origen.MoveNext
   loop 
   
end if

if (variable1 = "ConsultaAvion") then

    consulta = "SELECT DISTINCT IDAVION from AVION"
   
   Set origen = Conexion.Execute(consulta)
   'Recorreremos el RecordSet
   do while not origen.EOF
         Response.Write(origen("IDAVION") & vbCrLf)
         'Nos desplazamos por el RecordSet
         origen.MoveNext
   loop 
   
end if

if (variable1 = "ConsultaCompania") then

    consulta = "SELECT DISTINCT IDCOMPANIA from COMPANIA"
   
   Set origen = Conexion.Execute(consulta)
   'Recorreremos el RecordSet
   do while not origen.EOF
         Response.Write(origen("IDCOMPANIA") & vbCrLf)
         'Nos desplazamos por el RecordSet
         origen.MoveNext
   loop 
   
end if


 if (variable1 = "Consulta2") then

    consulta = "SELECT * from VUELO where IDVUELO=" & variable2

   Set origen = Conexion.Execute(consulta)
   'Recorreremos el RecordSet
   do while not origen.EOF
         Response.Write(origen("IDCIUDADORIGEN") & "-")
         Response.Write(origen("IDCIUDADDESTINO") & "-")
         Response.Write(origen("FECHA") & "-")
         Response.Write(origen("IDCOMPANIA") & "-")
         Response.Write(origen("IDAVION") & "-")
         Response.Write(origen("DURACION") & "-")
         Response.Write(origen("N_PLAZAS_DISPONIBLES") & "-")
         'Nos desplazamos por el RecordSet
         origen.MoveNext
   loop 
      Response.Write(consulta) & vbCrLf

end if


if (variable1 = "Modificacion") then


   origen=request.querystring("origen")
   destino=request.querystring("destino")
   fecha=request.querystring("fecha")
   compania=request.querystring("compania")
   avion=request.querystring("avion")
   duracion=request.querystring("duracion")
   plazas=request.querystring("plazas")

   dd = Left(Day(fecha), 2)
mm = Left( Month(fecha), 2)
yy = Year(fecha)

   fecha = yy &"/"& mm &"/"&dd

    update = "Update VUELO set IDVUELO=" & variable2 & " ,IDCIUDADORIGEN=" &origen&" ,IDCIUDADDESTINO=" &destino& " ,FECHA='" &fecha& "' ,IDCOMPANIA=" &compania& " ,IDAVION=" &avion& " ,DURACION=" &duracion& " ,N_PLAZAS_DISPONIBLES=" &plazas & " where IDVUELO=" & variable2 

   Set rs_update = Conexion.Execute(update)

      Response.Write(update) & vbCrLf

end if

if (variable1 = "Inserccion") then


   origen=request.querystring("origen")
   destino=request.querystring("destino")
   fecha=request.querystring("fecha")
   compania=request.querystring("compania")
   avion=request.querystring("avion")
   duracion=request.querystring("duracion")
   plazas=request.querystring("plazas")

   Set rs_id=Conexion.Execute("select MAX(IDVUELO) AS ID from VUELO")
   id= cint(rs_id("ID")) + 1

   dd = Left(Day(fecha), 2)
mm = Left( Month(fecha), 2)
yy = Year(fecha)

   fecha = yy &"/"& mm &"/"&dd

    insert = "Insert into VUELO values(" & id & " ," &origen&" ," &destino& " , '"&fecha& "'," &compania& " ," &avion& " ," &duracion& " ," &plazas & ")" 

   Set rs_insert = Conexion.Execute(insert)

      Response.Write(insert) & vbCrLf

end if


%>