<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,org.firebirdsql.management.*"%>

<html>
   <head>
      <title>Insertar Ciudades</title>
      <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link href="style/style.css" rel="stylesheet" type="text/css" media="screen"/>
      <script type="text/javascript" src="script/js.js"></script>
      <script type="text/javascript" src="script/funciones-ajax.js"></script>

   </head>
   <body>
		<div class="med">
			<header id="cabecera">
				<img title="Nova tur" src="./img/Logo-Web.png" alt="Logo"/>
				<h1>Tu Agencia de vuelos mas barata del mundo</h1>
				
			</head>
			<nav id="menu">
				<ul>
					<li class="submenu">
						<a href="http://localhost/DAI/index.asp">Inicio</a>
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
						<a href="consulta.html">Consultar</a>
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
				<h2>Insertar ciudades</h2> 
					<div class="Quienes.somos">
						 <table class="tabla">
						 <%
						String DB_SERVER_URL = "localhost";
					   int DB_SERVER_PORT = 3050;

					   String DB_PATH = "C:/DAI";

					   String DB_NAME = "AGENCIA.FDB";
					   String DB_USER = "SYSDBA";
					   String DB_PASSWORD = "masterkey";
					   String DB_CONNECTION_STRING = "jdbc:firebirdsql:"+DB_SERVER_URL+"/"+DB_SERVER_PORT+":"+DB_PATH+"/"+DB_NAME;


					   int id = Integer.parseInt(request.getParameter("id"));
					   String nombre= request.getParameter("nombre");

					   FBManager fbManager = new FBManager();

					   fbManager.setServer(DB_SERVER_URL);
					   fbManager.setPort(DB_SERVER_PORT);

					   fbManager.start();

					   Class.forName("org.firebirdsql.jdbc.FBDriver");

					   Connection connRSFind = DriverManager.getConnection(DB_CONNECTION_STRING, DB_USER, DB_PASSWORD);


					   String sqlString = "INSERT INTO CIUDAD VALUES("+id+",'"+nombre+"')";


					   PreparedStatement StatementRSFind = null;
					   ResultSet RSFind = null;
					   boolean resultException = false;
					   boolean rsReady = false;

					   try{
					      StatementRSFind = connRSFind.prepareStatement(sqlString);
					      RSFind = StatementRSFind.executeQuery();
					   }catch(SQLException e1){
					      resultException = true;
					   }


					   out.println("<tr><td>Se ha introducido correctamente.");

					out.println("</td></tr>");

					if (StatementRSFind != null)
					StatementRSFind.close();

					if (connRSFind != null)
					connRSFind.close();


					%>
                  </table>
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