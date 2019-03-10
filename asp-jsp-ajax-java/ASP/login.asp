<!-- #include file=conexion.asp -->
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="style.css" rel="stylesheet" type="text/css" media="screen"/>
		<script src="js.js" type="text/javascript"></script>
		<title>Login</title>
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
				<h2>Busqueda de compañías</h2>
					<div class="Quienes.somos">
						<%
							if (((usuario = "admin") AND (password="admin")) OR (session("login")=true)) then
								session("Login") = true 
								%>
									<table class="tabla">
								<%
				if (Request.querystring("anadir")="true") then	
					response.write("<form action='login.asp' method='post'>")
					Set rs_id=Conexion.Execute("select MAX(IDCOMPANIA) AS ID from COMPANIA")
					id= cint(rs_id("ID")) + 1
					response.write("<tr><td>IdCompañia</td><td>Nombre</td></tr>")
					response.write("<tr><td><input type='text' name='0' value='" & id & "' readonly/></td>")
					response.write("<td><input type='text' name='1' required/></td>")
					response.write("</tr>")
					response.write("<tr><td colspan='4'><input id='submit' type='submit' value='Añadir'/></td></tr>")
				else
					if (request.form("0")<>"") then
						Set rs_insert = Conexion.Execute("insert into COMPANIA values(" & request.form("0") & ",'" & request.form("1") & "')")
					end if
					Set rs_compania=Conexion.Execute("select COMPANIA, IDCOMPANIA from COMPANIA")
					Do Until rs_compania.EOF
						%><tr><td><% 
						paginaASP = ("companias.asp?compania=" & rs_compania("IDCOMPANIA"))
						response.write("<a href=" & paginaASP & ">")
						response.write(rs_compania("compania"))
						response.write("</a>")
						%></td></tr><%
						rs_compania.MoveNext
					Loop
					response.write("<tr><td><a href='login.asp?anadir=true'><input type='button' value='Añadir'</td></tr>")
				end if
				%>
					</table>
				<%
			else
				Response.write("Usuario incorrecto, por favor vuelva a introducir sus credenciales.")			
			end if
			%>
		</div>
	
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