<!-- #include file=conexion.asp -->
<!DOCTYPE html>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="style.css" rel="stylesheet" type="text/css" media="screen"/>
		<script src="js.js" type="text/javascript"></script>
		<title>Companias</title>
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
				<h2>Busqueda de compañía</h2> 
					<div class="Quienes.somos">
						<table class="tabla">
						<%
				if (session("login")=false) then
					Response.Redirect("index.asp")
				end if

				compania=request.querystring("compania")

				if (request.querystring("eliminar")="true") then
					Set rs_delete = Conexion.Execute("delete from COMPANIA where IDCOMPANIA=" & compania)
					Response.Redirect("login.asp")
				end if

				if (request.form("1")<>"") then
					Set rs_update = Conexion.Execute("update COMPANIA set COMPANIA='" & request.form("1") & "' where IDCOMPANIA=" & compania)
					response.write("<tr><td colspan='4'>Se han modificado correctamente los datos de la compañia</td></tr>")
				end if
				
				Set rs_compania=Conexion.Execute("select * from COMPANIA where " & compania & "=IDCOMPANIA")

			%>
				<tr><td>Id Compañia</td><td>Compañia</td>
				<%
					
					response.write("<form action='companias.asp?compania=" & compania & "' method='post'><tr><td>" & rs_compania("IDCOMPANIA") & "</td>")
					response.write("<td><input type='text' value='" & rs_compania("COMPANIA") & "' name='1'/>" & "</td>")
					response.write("<tr><td colspan='4'><input id='submit' type='submit' value='Modificar'/></td></tr>")
					response.write("</tr></form>")	
					response.write("<tr><td colspan='4'><a href='companias.asp?compania=" & compania & "&eliminar=true'><input type='button' value='Eliminar'</td></tr>")
				%>
			</table>
		</div>
	</div>
			</section>
			<footer class="footer">
				<p>
					NOVA TUR, S.L
					CIF:B54970413	
					<br>
					Telf: 965 48 46 68			
				</p>
			</div>
		</div>
	</body>
</html>