<!-- #include file=conexion.asp -->

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="style.css" rel="stylesheet" type="text/css" media="screen"/>
		<script src="js.js" type="text/javascript"></script>
		<title>Reserva</title>
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
						<a href="consulta.asp">Consultar</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								Consulta los vuelos contratados
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
							idReserva = Request.form("0")
							idReserva = CInt(idReserva)

							apellidos = Request.form("1")
							nombre = Request.form("2")
							nif = Request.form("3")

							idVuelo = Request.QueryString("idvuelo")
							idVuelo = CInt(idVuelo)
							plazas = Request.form("plazas")
							plazas = CInt(plazas)

							Set rs_vuelo=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where IDVUELO=" & idVuelo)

							if (idReserva <> 0) then
								n_plazas = CInt(rs_vuelo("N_PLAZAS_DISPONIBLES")) - plazas
								precio_total = Round(CDbl(CDbl(rs_vuelo("PRECIO")) * plazas),2)
								Set rs_update = Conexion.Execute("update VUELO set N_PLAZAS_DISPONIBLES='" & n_plazas & "' where IDVUELO=" & idvuelo)
								Set rs_insert = Conexion.Execute("insert into RESERVA values(" & idReserva & ",'" & apellidos & "','" & nombre & "','" & nif & "'," &  idVuelo & "," & plazas & "," & 0 & ")")

								if (Request.QueryString("vuelta")<>"") then
									response.write("<form action='index.asp' method='post'>")
								else
									response.write("<form action='buscar_vuelo.asp?idvuelo=" & idVuelo & "' method='post'>")

								end if
									response.write("<tr><td>IdReserva</td><td>Precio Total</td></tr>")

									response.write("<tr><td><input type='text' name='idReserva' value='" & idReserva & "' readonly/></td>")
									response.write("<td><input type='text' name='precio_total' value='" & precio_total & "€' readonly/></td>")
							
									response.write("</tr>")

								if (Request.QueryString("vuelta")<>"") then
									response.write("<tr><td colspan='2'><input class='boton_form' type='submit' value='Terminar'/></td></tr>")
									response.write("</form>")
								else
									
									response.write("<tr><td colspan='2'><input class='boton_form' type='submit' value='Vuelos de vuelta'/></td></tr>")
									response.write("</form>")
									response.write("<tr><td colspan='2'><a href='index.asp'><button class='boton_form'>Inicio</button></a></td></tr>")
								end if

							else
	 							Response.write("<tr><td>Por favor elija un vuelo antes de reservar.</td></tr>")
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