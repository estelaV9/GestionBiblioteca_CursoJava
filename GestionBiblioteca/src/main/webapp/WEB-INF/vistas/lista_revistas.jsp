<%@ page import="Modelos.RevistaDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, Modelos.Revista, Modelos.Elemento" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Revistas</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(45deg, #F7F9F9, #BED8D4, #78D5D7, #63D2FF, #2081C3);
                background-size: 400% 400%;
                animation: gradientBG 15s ease infinite;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
            }

            .navbar {
                background-color: rgba(48, 63, 159, 0.9);
                opacity: 0.9;
                z-index: 100;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
                flex-wrap: wrap;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                border-bottom: 2px solid #2081C3;
            }

            .navbar-brand {
                color: #fff;
                text-decoration: none;
                font-size: 24px;
                font-weight: bold;
            }

            .nav-link {
                color: #fff;
                text-decoration: none;
                font-size: 18px;
                padding: 8px 16px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .nav-link:hover {
                background-color: rgba(255, 255, 255, 0.2);
            }

            .container {
                margin-top: 20px;
                background: rgba(48, 63, 159, 0.8);
                border-radius: 15px;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3);
                padding: 20px 40px;
                color: #fff;
                max-width: 1200px;
                margin-left: auto;
                margin-right: auto;
                text-align: left;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
            }

            table, th, td {
                border: 1px solid #BED8D4;
            }

            th, td {
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #2081C3;
                color: #fff;
            }

            td {
                background-color: rgba(255, 255, 255, 0.1);
                color: #fff;
            }

            .btn {
                padding: 10px 20px;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background-color: #63D2FF;
                border: none;
                color: white;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            }

            .btn-primary:hover {
                background-color: #2081C3;
            }

            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 8px;
                border-radius: 8px;
                border: none;
                margin-bottom: 10px;
            }

            h1, h2 {
                text-align: center;
                color: #3affef;
            }

            .form-container {
                background: rgba(255, 255, 255, 0.1);
                padding: 20px;
                border-radius: 10px;
                margin-top: 20px;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #3affef;
            }

            .form-control {
                width: 100%;
                padding: 8px;
                border-radius: 8px;
                border: none;
                background-color: rgba(255, 255, 255, 0.8);
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
                border: none;
            }

            .btn-danger:hover {
                background-color: #bb2d3b;
            }

            .btn-success {
                background-color: #28a745;
                color: white;
                border: none;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <a class="navbar-brand" href="../">Biblioteca</a>
            <a class="nav-link" href="../libros/">Libros</a>
            <a class="nav-link">Revistas</a>
            <a class="nav-link" href="../audiovisuales/">Elementos Audiovisuales</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/lista">Lista de usuarios</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/nuevo">Crear usuario</a>
            <a class="nav-link" style="background-color: #ff9ea2;" href="../../login">Cerrar sesión</a>
        </div>

        <div class="container">
            <h1>Revistas</h1>
            <!-- Mensajes de éxito/error -->
            <% String success = (String) request.getAttribute("success"); %>
            <% if (success != null && !success.isEmpty()) {%>
            <div class="alert alert-success"><%= success%></div>
            <% } %>

            <!-- Botón para mostrar formulario -->
            <button id="btnNuevaRevista" class="btn btn-primary" onclick="mostrarFormulario()">
                <% RevistaDTO revistaForm = (RevistaDTO) request.getAttribute("revistaForm");%>
                <%= (revistaForm != null && revistaForm.getRevistaId() != null) ? "Editar Revista" : "Nueva Revista"%>
            </button>
            <br>
            <br>

            <!-- Formulario de creación/edición -->
            <div id="formularioRevista" class="form-container <%= (revistaForm != null && revistaForm.getRevistaId() != null) ? "" : "hidden"%>">
                <h2><%= (revistaForm != null && revistaForm.getRevistaId() != null) ? "Editar Revista" : "Nueva Revista"%></h2>
                <form action="${pageContext.request.contextPath}/empleado/revistas/guardar" method="post">
                    <input type="hidden" name="revistaId" value="<%= (revistaForm != null) ? revistaForm.getRevistaId() : ""%>">

                    <div class="form-group">
                        <label for="elementoId">ID de Elemento</label>
                        <input id="elementoId" name="elementoId" class="form-control" 
                               type="number" required 
                               value="<%= (revistaForm != null && revistaForm.getElementoId() != null) ? revistaForm.getElementoId() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="titulo">Título</label>
                        <input id="titulo" name="titulo" class="form-control" 
                               type="text" required
                               value="<%= (revistaForm != null && revistaForm.getTitulo() != null) ? revistaForm.getTitulo() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="autor">Autor</label>
                        <input id="autor" name="autor" class="form-control" 
                               type="text" required
                               value="<%= (revistaForm != null && revistaForm.getAutor() != null) ? revistaForm.getAutor() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="fechaPublicacion">Fecha de Publicación</label>
                        <input id="fechaPublicacion" name="fechaPublicacion" class="form-control" 
                               type="date" required
                               value="<%= (revistaForm != null && revistaForm.getFechaPublicacion() != null) ? revistaForm.getFechaPublicacion() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="numero">Número de Publicación</label>
                        <input id="numero" name="numero" class="form-control" 
                               type="number" required min="1"
                               value="<%= (revistaForm != null && revistaForm.getNumero() != null) ? revistaForm.getNumero() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="numEjemDispo">Ejemplares Disponibles</label>
                        <input id="numEjemDispo" name="numEjemDispo" class="form-control" 
                               type="number" required min="0"
                               value="<%= (revistaForm != null && revistaForm.getNumEjemplaresDisponibles() != null) ? revistaForm.getNumEjemplaresDisponibles() : ""%>">
                    </div>

                    <button type="submit" class="btn btn-success">Guardar</button>
                    <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                </form>
            </div>

            <!-- Tabla de revistas -->
            <table>
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Fecha Publicación</th>
                        <th>Ejemplares Disponibles</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<RevistaDTO> revistas = (List<RevistaDTO>) request.getAttribute("revistas");
                        List<Elemento> elementos = (List<Elemento>) request.getAttribute("elementos");

                        if (revistas != null && elementos != null) {
                            for (RevistaDTO revista : revistas) {
                                Elemento elemento = null;
                                for (Elemento e : elementos) {
                                    if (e.getElementoId() == revista.getElementoId()) {
                                        elemento = e;
                                        break;
                                    }
                                }
                    %>
                    <tr>
                        <td><%= revista.getTitulo()%></td>
                        <td><%= revista.getAutor()%></td>
                        <td><%= revista.getFechaPublicacion()%></td>
                        <td><%= revista.getNumEjemplaresDisponibles()%></td>

                        <td>
                            <a href="${pageContext.request.contextPath}/empleado/revistas/editar/<%= revista.getRevistaId()%>" class="btn btn-primary">Editar</a>
                            <a href="${pageContext.request.contextPath}/empleado/revistas/eliminar/<%= revista.getRevistaId()%>" class="btn btn-danger" 
                               onclick="return confirm('¿Estás seguro de eliminar esta revista?')">Eliminar</a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script>
            // Mostrar formulario si estamos editando
            window.onload = function () {
                <% if (revistaForm != null && revistaForm.getRevistaId() != null) { %>
                    mostrarFormulario();
                <% } %>
            };

            function mostrarFormulario() {
                document.getElementById('formularioRevista').classList.remove('hidden');
                document.getElementById('btnNuevaRevista').classList.add('hidden');
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            function ocultarFormulario() {
                document.getElementById('formularioRevista').classList.add('hidden');
                document.getElementById('btnNuevaRevista').classList.remove('hidden');
            }
        </script>
    </body>
</html>
