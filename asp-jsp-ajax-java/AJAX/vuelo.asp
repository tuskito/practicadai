<!-- #include file=conexion.asp -->

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="style.css" rel="stylesheet" type="text/css" media="screen"/>
		<script src="js.js" type="text/javascript"></script>
		<title>Buscador de vuelos</title>
	</head>
	<body>
		<div class="med">
			<header id="cabecera">
				<img title="Nova tur" src="./img/Logo-Web.png" alt="Logo"/>
				<h1>Tu Agencia de vuelos mas barata del mundo</h1>

				<% 
					usuario = Request.form("user")
					password= Request.form("pass")

					if (((usuario = "admin") AND (password="admin")) OR (session("login")=true)) then
						response.write("<div>")
							response.write("Hola Admin</br>")
							response.write("<a href='login.asp'>Mi cuenta</a></br>")
							response.write("<a href='cerrar_sesion.asp'>Cerrar sesión</a>")
						response.write("</div>")
					End if
				%>
			</header>
			<nav id="menu">
				<ul>
					<li class="submenu">
						<a href="index.asp">Inicio</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								Página de inicio
							</div>
						</div>
					</li>

				<li class="submenu">

						<a href="productos.html">Productos</a>
						
						<div class="submenu_contenido">
							<div id="leyenda">
								Productos disponibles
							</div>
							<a href="inicio.html">Inicio</a>
							<a href="basico.html" >Basico</a>
							<a href="avanzado.html">avanzado</a>
						</div>
					</li>

				<li class="submenu">
						<a href="compraproductos.html">Comprar</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								El mejor precio
							</div>
						</div>
					</li>

				

				<li class="submenu">
						<a href="servicios.html">Servicios</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								Servicios disponibles
							</div>
						</div>
					</li>

				<li class="submenu">
						<a href="descargas.html">Descargas</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								Descarga los CMS mas destacados
							</div>
						</div>
					</li>

				<li class="submenu">
						<a href="contacto.html">Contacto</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								Envíanos tu consulta
							</div>
						</div>
					</li>
				</ul>
			</nav>
			<section class="body_product">
				<h2>Busqueda de vuelos</h2>
					<div class="Quienes.somos">
						<table class="tabla">
						<%
							idvuelo = Request.QueryString("idvuelo")
							

							if (idvuelo<>"") then
								Set rs_idOrigen=Conexion.Execute("Select * from VUELO where IDVUELO='" & idvuelo & "'")
								id_origen = CInt(rs_idOrigen("IDCIUDADDESTINO"))
								id_destino = CInt(rs_idOrigen("IDCIUDADORIGEN"))

								Set rs_origen=Conexion.Execute("Select * from CIUDAD where IDCIUDAD='" & id_origen & "'")
								origen = rs_origen("CIUDAD")

								Set rs_destino=Conexion.Execute("Select * from CIUDAD where IDCIUDAD='" & id_destino & "'")
								destino = rs_destino("CIUDAD")

							else
								origen = Request.QueryString("origen")
								destino= Request.QueryString("destino")
							end if

						

							if (origen="" AND destino="") then
								Set rs_vuelo=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO")

							elseif (origen="" AND destino <>"") then
								Set rs_vuelo=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where CIUDAD_DESTINO='" & Ucase(destino) & "'")

							elseif (origen<>"" AND destino ="") then
								Set rs_vuelo=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where  CIUDAD_ORIGEN='" & Ucase(origen) & "'")
							else 
								Set rs_vuelo=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where CIUDAD_ORIGEN='" & Ucase(origen) & "' AND CIUDAD_DESTINO='" & Ucase(destino) & "'")

							end if
							
							if (rs_vuelo.EOF) then
								Response.write("<tr><td>No se han encontrado resultados.</td></tr>")
							else
								Response.write("<tr><td>ORIGEN</td><td>DESTINO</td><td>PRECIO</td><td>PLAZAS</td></tr>")
								do while not rs_vuelo.EOF
									if (idVuelo <> "") then
										Response.write("<form action='reserva.asp?idvuelo=" & rs_vuelo("IDVUELO") & "&vuelta=true' method='post'>")
									else
										Response.write("<form action='reserva.asp?idvuelo=" & rs_vuelo("IDVUELO") & "' method='post'>")
									end if
	 								Response.write("<tr><td>" & rs_vuelo("CIUDAD_ORIGEN") & " </td><td>	" & rs_vuelo("CIUDAD_DESTINO") & "</td><td>" & Round(rs_vuelo("PRECIO"),2) & "€</td><td><input type='number' name='plazas' required  min='1'/></td><td><input type='submit' value='Reservar'/></td></tr>")
	 								Response.write("</form>")
								rs_vuelo.MoveNext
								loop
							end if
						%>
						</table>
					</div>
			</section>
			<footer class="footer">
				<p>
					NOVA TOUR, S.L
					CIF:B54970413	
					<br>
					Telf: 965 48 46 68			
				</p>
			</div>
		</div>
	</body>
</html>
