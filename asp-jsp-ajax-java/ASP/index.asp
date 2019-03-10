<!-- #include file=conexion.asp -->

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="style.css" rel="stylesheet" type="text/css" media="screen"/>
		<script src="js.js" type="text/javascript"></script>
		<title>NOVA TUR</title>
	</head>
	<body>
		<div class="med">
			<header id="cabecera">
				<a href="index.asp"><img title="Nova tur" src="./img/Logo-Web.png" alt="Logo"/></a>
				<h1>Tu Agencia de vuelos mas barata del mundo</h1>

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
						<a href="consulta.asp">Consultar</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								Consulta los vuelos contratados
							</div>
						</div>

				<li class="submenu">
						<a href="compraproductos.html">Comprar</a>
						<div class="submenu_contenido">
							<div class="leyenda">
								El mejor precio
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
			<section class="contenido">
				<div class="news">
					<h2>Buscador de vuelo</h2>
					<form action="vuelo.asp" method="get">
							<label for="origen">Origen:</label>
							<select id="origen" name="origen">
							<option value="">TODOS</option>
							<%
								Set origen = Conexion.Execute("select distinct CIUDAD_ORIGEN from LISTA_VUELOS_PRECIO")
								Set destino = Conexion.Execute("select distinct CIUDAD_DESTINO from LISTA_VUELOS_PRECIO")

								do while not origen.EOF
									Response.Write("<option value='" & origen("CIUDAD_ORIGEN") & "'>" & origen("CIUDAD_ORIGEN") &"</option>")
									origen.MoveNext
								loop
							%>
							</select>
							<label for="destino">Destino:</label>
							<select id="destino" name="destino">
							<option value="">TODOS</option>
							<%
								do while not destino.EOF
									Response.Write("<option value='" & destino("CIUDAD_DESTINO") & "'>" & destino("CIUDAD_DESTINO") &"</option>")
									destino.MoveNext
								loop
							%>
							</select>
							<input type="submit" value="Buscar"/>
					</form>
				</div>
				</section>
					<aside class="productos">
						<h2>Login</h2>
				<%
				if (session("login")=true) then
						response.write("<div>")
							response.write("Hola Admin</br>")
							response.write("<a href='login.asp'>Mi cuenta</a></br>")
							response.write("<a href='cerrar_sesion.asp'>Cerrar sesión</a>")
						response.write("</div>")
				else %>
				<form action="login.asp" method="post">
						<label for="user">Usuario:</label>
						<input type="text" id="user" name="user"/>
						<label for="pass">Contraseña:</label>
						<input type="password" id="pass" name="pass"/>
						<input type="submit" value="Entrar"/>
				</form>
				<% end if %>
			</aside>
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