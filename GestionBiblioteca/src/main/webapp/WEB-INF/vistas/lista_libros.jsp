<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, Modelos.Libro" %>
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
        </div>

        <div class="container">
            <!-- Mensajes de éxito/error -->
            <% String success = (String) request.getAttribute("success"); %>
            <% if (success != null && !success.isEmpty()) {%>
            <div class="alert alert-success"><%= success%></div>
            <% } %>

            <!-- Botón para mostrar formulario -->
            <button id="btnNuevoLibro" class="btn btn-primary" onclick="mostrarFormulario()">
                <% Libro libroForm = (Libro) request.getAttribute("libroForm");%>
                <%= (libroForm != null && libroForm.getLibroId() != null) ? "Editar Libro" : "Nuevo Libro"%>
            </button>

            <!-- Formulario de creación/edición -->
            <div id="formularioLibro" class="form-container <%= (libroForm != null && libroForm.getLibroId() != null) ? "" : "hidden"%>">
                <h2><%= (libroForm != null && libroForm.getLibroId() != null) ? "Editar Libro" : "Nuevo Libro"%></h2>
                <form action="${pageContext.request.contextPath}/libros/guardar" method="post">
                    <input type="hidden" name="libroId" value="<%= (libroForm != null) ? libroForm.getLibroId() : ""%>">

                    <div class="form-group">
                        <label for="elementoId">ID de Elemento</label>
                        <input id="elementoId" name="elementoId" class="form-control" 
                               type="number" required value="<%= (libroForm != null) ? libroForm.getElementoId() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="genero">Género</label>
                        <input id="genero" name="genero" class="form-control" 
                               type="text" required value="<%= (libroForm != null) ? libroForm.getGenero() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="numPaginas">Número de páginas</label>
                        <input id="numPaginas" name="numPaginas" class="form-control" 
                               type="number" required value="<%= (libroForm != null) ? libroForm.getNumPaginas() : ""%>">
                    </div>

                    <div class="form-group">
                        <label for="editorial">Editorial</label>
                        <input id="editorial" name="editorial" class="form-control" 
                               type="text" required value="<%= (libroForm != null) ? libroForm.getEditorial() : ""%>">
                    </div>

                    <button type="submit" class="btn btn-success">Guardar</button>
                    <button type="button" class="btn btn-secondary" onclick="ocultarFormulario()">Cancelar</button>
                </form>
            </div>

            <!-- Tabla de libros -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Elemento ID</th>
                        <th>Género</th>
                        <th onclick="sortTable()" style="cursor: pointer;">Páginas ⬍</th>
                        <th>Editorial</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Libro> libros = (List<Libro>) request.getAttribute("libros");
                        if (libros != null) {
                            for (Libro libro : libros) {
                    %>
                    <tr>
                        <td><%= libro.getLibroId()%></td>
                        <td><%= libro.getElementoId()%></td>
                        <td><%= libro.getGenero()%></td>
                        <td><%= libro.getNumPaginas()%></td>
                        <td><%= libro.getEditorial()%></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/libros/editar/<%= libro.getLibroId()%>" class="btn btn-primary">Editar</a>
                            <a href="${pageContext.request.contextPath}/libros/eliminar/<%= libro.getLibroId()%>" class="btn btn-danger" 
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

            // Resto del código JavaScript permanece igual
            function mostrarFormulario() {
                document.getElementById('formularioLibro').classList.remove('hidden');
                document.getElementById('btnNuevoLibro').classList.add('hidden');
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            function ocultarFormulario() {
                document.getElementById('formularioLibro').classList.add('hidden');
                document.getElementById('btnNuevoLibro').classList.remove('hidden');
            }

            let ascending = true;

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