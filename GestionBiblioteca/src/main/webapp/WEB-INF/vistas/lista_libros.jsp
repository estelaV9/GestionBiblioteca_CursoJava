<%@page import="java.util.Date"%>
<%@page import="Modelos.LibroConElementoDTO"%>
<%@page import="Modelos.Elemento"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, Modelos.Libro, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Libros</title>
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
            <a class="nav-link">Libros</a>
            <a class="nav-link" href="../revistas/">Revistas</a>
            <a class="nav-link" href="../audiovisuales/">Elementos Audiovisuales</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/lista">Lista de usuarios</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/nuevo">Crear usuario</a>
            <a class="nav-link" style="background-color: #ff9ea2;" href="../../login">Cerrar sesión</a>
        </div>

        <div class="container">
            <h1>Libros</h1>
            <% String success = (String) request.getAttribute("success"); %>
            <% if (success != null && !success.isEmpty()) {%>
            <div class="alert alert-success"><%= success%></div>
            <% } %>

            <!-- Botón para mostrar formulario -->
            <button id="btnNuevoLibro" class="btn btn-primary" onclick="mostrarFormulario()">
                <% Libro libroForm = (Libro) request.getAttribute("libroForm");%>
                <%= (libroForm != null && libroForm.getLibroId() != null) ? "Editar Libro" : "Nuevo Libro"%>
            </button>
            <br><br>

            <!-- Formulario de creación/edición -->
            <div id="formularioLibro" class="form-container <%= (libroForm != null && libroForm.getLibroId() != null) ? "" : "hidden"%>">
                <h2><%= (libroForm != null && libroForm.getLibroId() != null) ? "Editar Libro" : "Nuevo Libro"%></h2>
                <form action="${pageContext.request.contextPath}/empleado/libros/guardar" method="post">
                    <input type="hidden" name="libroId" value="<%= (libroForm != null && libroForm.getLibroId() != null) ? libroForm.getLibroId() : ""%>">

                    <!-- Campos del elemento (solo para creación) -->
                    <% if (libroForm == null || libroForm.getLibroId() == null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    %>
                    <div class="form-group">
                        <label>Título del Elemento</label>
                        <input type="text" name="titulo" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Autor del Elemento</label>
                        <input type="text" name="autor" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Fecha de Publicación</label>
                        <input type="date" name="fechaPublicacion" class="form-control" required
                               value="<%= sdf.format(new Date())%>">
                    </div>

                    <div class="form-group">
                        <label>Ejemplares Disponibles</label>
                        <input type="number" name="numEjemDispo" class="form-control" min="1" value="1" required>
                    </div>
                    <% } else {%>
                    <input type="hidden" name="elementoId" value="<%= libroForm.getElementoId()%>">
                    <% }%>

                    <!-- Campos del libro -->
                    <div class="form-group">
                        <label>Género</label>
                        <input type="text" name="genero" class="form-control" 
                               value="<%= (libroForm != null) ? libroForm.getGenero() : ""%>" required>
                    </div>

                    <div class="form-group">
                        <label>Número de Páginas</label>
                        <input type="number" name="numPaginas" class="form-control" min="1"
                               value="<%= (libroForm != null) ? libroForm.getNumPaginas() : ""%>" required>
                    </div>

                    <div class="form-group">
                        <label>Editorial</label>
                        <input type="text" name="editorial" class="form-control"
                               value="<%= (libroForm != null) ? libroForm.getEditorial() : ""%>" required>
                    </div>

                    <button type="submit" class="btn btn-success">Guardar</button>
                    <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                </form>
            </div>

            <!-- Tabla de libros -->
            <table>
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Fecha Publicación</th>
                        <th>Ejemplares</th>
                        <th>Género</th>
                        <th>Páginas</th>
                        <th>Editorial</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<LibroConElementoDTO> librosConElementos = (List<LibroConElementoDTO>) request.getAttribute("librosConElementos");
                        if (librosConElementos != null) {
                            for (LibroConElementoDTO dto : librosConElementos) {
                                Libro libro = dto.getLibro();
                                Elemento elemento = dto.getElemento();
                    %>
                    <tr>
                        <td><%= elemento != null ? elemento.getTitulo() : "N/A"%></td>
                        <td><%= elemento != null ? elemento.getAutor() : "N/A"%></td>
                        <td><%= elemento != null ? elemento.getFechaPublicacion() : "N/A"%></td>
                        <td><%= elemento != null ? elemento.getNumEjemDispo() : "N/A"%></td>
                        <td><%= libro != null ? libro.getGenero() : "N/A"%></td>
                        <td><%= libro != null ? libro.getNumPaginas() : "N/A"%></td>
                        <td><%= libro != null ? libro.getEditorial() : "N/A"%></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/empleado/libros/editar/<%= libro.getLibroId()%>" 
                               class="btn btn-primary">Editar</a>
                               <br><br>
                            <a href="${pageContext.request.contextPath}/empleado/libros/eliminar/<%= libro.getLibroId()%>" 
                               class="btn btn-danger"
                               onclick="return confirm('¿Estás seguro de eliminar este libro?')">Eliminar</a>
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
            <% if (libroForm != null && libroForm.getLibroId() != null) { %>
                mostrarFormulario();
            <% }%>
            };

            function mostrarFormulario() {
                document.getElementById('formularioLibro').classList.remove('hidden');
                document.getElementById('btnNuevoLibro').classList.add('hidden');
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            function ocultarFormulario() {
                document.getElementById('formularioLibro').classList.add('hidden');
                document.getElementById('btnNuevoLibro').classList.remove('hidden');
                document.querySelector('form').reset();
            }

             function sortTable() {
                const table = document.querySelector("table");
                const tbody = table.querySelector("tbody") || table;
                const rows = Array.from(tbody.rows);

                rows.sort((a, b) => {
                    const valA = parseInt(a.cells[3].innerText);
                    const valB = parseInt(b.cells[3].innerText);
                    return ascending ? valA - valB : valB - valA;
                });

                ascending = !ascending;

                rows.forEach(row => tbody.appendChild(row));
            }
        </script>
    </body>
</html>