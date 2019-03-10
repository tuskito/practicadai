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
							idVuelo = Request.QueryString("idvuelo")
							if (idVuelo<>"") then
								plazas = Request.form("plazas")
								plazas = CInt(plazas)
								
								Set rs_vuelo=Conexion.Execute("Select * from LISTA_VUELOS_PRECIO where IDVUELO=" & idVuelo)

								if (rs_vuelo("N_PLAZAS_DISPONIBLES") >= plazas) then 
									if (Request.QueryString("vuelta")<>"") then
										Response.write("<form action='reserva_reserv.asp?idvuelo=" & rs_vuelo("IDVUELO") & "&vuelta=true' method='post'>")
									else
										response.write("<form action='reserva_reserv.asp?idvuelo=" & idVuelo & "' method='post'>")
									end if
									
										Set rs_id=Conexion.Execute("select MAX(IDRESERVA) AS ID from RESERVA")
										id= cint(rs_id("ID")) + 1
										response.write("<tr><td>IdReserva</td><td>Apellidos</td><td>Nombre</td><td>Nif</td></tr>")
										response.write("<tr><td><input type='text' name='0' value='" & id & "' readonly/></td>")
										for i=1 to 3
											response.write("<td><input type='text' name='" & i &"' required/></td>")
										next

										response.write("</tr>")
										response.write("<input type='hidden' name='plazas' value='" & plazas & "'/>")

										response.write("<tr><td colspan='4'><input class='boton_form' type='submit' value='Reservar'/></td></tr>")


									response.write("</form>")


								else
		 							Response.write("<tr><td>No hay plazas disponibles.</td><tr>")
		 						end if
		 					else
		 						Response.write("<tr><td>Seleccione un vuelo antes de reservar un vuelo.</td><tr>")
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