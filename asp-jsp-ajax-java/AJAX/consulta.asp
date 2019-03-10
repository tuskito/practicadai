<!-- #include file=conexion.asp -->

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="style.css" rel="stylesheet" type="text/css" media="screen"/>
		<script src="js.js" type="text/javascript"></script>
		<script type="text/javascript" src="funciones-ajax.js"></script>
		<title>Consulta</title>
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
				<h2>Consulta tu vuelo</h2>
					<div class="Quienes.somos">
						<table class="tabla">
							<%
								nif = request.form("nif")
								idreserva = request.form("idreserva")

								cancelar = request.form("cancelar")

								if (cancelar="true") then
									Set rs_idVuelo=Conexion.Execute("select * from RESERVA where IDRESERVA=" & idreserva)
									idVuelo = rs_idVuelo("IDVUELO")
									Set rs_vuelo=Conexion.Execute("select * from VUELO where IDVUELO=" & idVuelo)
									fecha = rs_vuelo("FECHA")

									fecha_actual= DateAdd("d",2,Date()) 

									if ((cdate(fecha_actual) < cdate(fecha))) then
										if ( (cint(rs_idVuelo("CANCELADO")) = 0)) then
											plazas = cint(rs_vuelo("N_PLAZAS_DISPONIBLES"))+cint(rs_idVuelo("N_ASIENTOS"))
											Set rs_update = Conexion.Execute("update VUELO set N_PLAZAS_DISPONIBLES='" & plazas & "' where IDVUELO=" & idVuelo)
											Set rs_update_cancelar = Conexion.Execute("update RESERVA set CANCELADO=1 where IDRESERVA=" & idreserva)
											Response.write("<tr><td>Se ha cancelado con exito.</td></tr>")
											response.write("<tr><td><a href='index.asp'><button class='boton_form'>Inicio</button></a></td></tr>")
										else
											Response.write("<tr><td>No se puede cancelar, el vuelo ya ha sido cancelado con anterioridad.</td></tr>")
										end if

									else
										Response.write("<tr><td>No se puede cancelar, solo se puede 48 horas antes del vuelo.</td></tr>")
									end if

								else
									if (nif <> "") then
										Set rs_consulta=Conexion.Execute("select * from RESERVA where IDRESERVA='" & idreserva & "' AND NIF='" & nif & "'")
										
										if (rs_consulta.EOF) then
											Response.write("<tr><td>No se han encontrado resultados.</td></tr>")
										else
											if (rs_consulta("CANCELADO")="0") then
												cancelado = "No"
											else
												cancelado = "Si"
											end if

											response.write("<tr><td>Id Reserva</td><td>Apellidos</td><td>Nombre</td><td>Nif</td><td>Id Vuelo</td><td>Nº Asientos</td><td>Cancelado</td></tr>")
											response.write("<form action='consulta.asp' method='post'>")
											Do Until rs_consulta.EOF
				    							response.write("<tr><td>" & rs_consulta("IDRESERVA") & "</td><td>" & rs_consulta("APELLIDOS") & "</td><td>" & rs_consulta("NOMBRE") & "</td><td>" & rs_consulta("NIF") & "</td><td>" & rs_consulta("IDVUELO") & "</td><td>" & rs_consulta("N_ASIENTOS") & "</td><td>" & cancelado & "</td></tr>")
												rs_consulta.MoveNext
											Loop
											response.write("<input type='hidden' name='cancelar' value='true'/>")
											response.write("<input type='hidden' name='idreserva' value='" & idreserva & "'/>")
											response.write("<tr><td colspan='7'><input class='boton_form' type='submit' value='Cancelar'/></td></tr>")
											response.write("</form>")
										end if
									else

							%>
							<tr><td>Nif</td><td>Id Reserva</td></tr>
							<%
										response.write("<form action='consulta.asp' method='post'>")

										response.write("<tr><td><input type='text' name='nif' required/></td>")
										response.write("<td><input type='text' name='idreserva' required/></td></tr>")

		    							response.write("<tr><td colspan='2'><input type='submit' value='Consultar'/></td></tr>")
		    							
		    							response.write("</form>")

		    						end if
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