<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, Modelos.Audiovisual" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Elementos Audiovisuales</title>
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
            <a class="nav-link" href="../revistas/">Revistas</a>
            <a class="nav-link">Elementos Audiovisuales</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/lista">Lista de usuarios</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/nuevo">Crear usuario</a>
            <a class="nav-link" style="background-color: #ff9ea2;" href="../../login">Cerrar sesión</a>
        </div>

        <div class="container">
            <h1>Elementos Audiovisuales</h1>

            <!-- Botón para mostrar el formulario -->
            <button id="btnNuevoAudiovisual" class="btn btn-primary" onclick="mostrarFormulario()">Añadir Nuevo Elemento Audiovisual</button>
            <br>
            <br>
            <!-- Formulario de creación (oculto al inicio) -->
            <div id="formularioAudiovisual" class="form-container hidden">
                <h2>Nuevo Elemento Audiovisual</h2>
                <form action="${pageContext.request.contextPath}/empleado/audiovisuales/guardar" method="post">
                    Elemento ID: <input type="number" name="elementoId" placeholder="Elemento ID" required>
                    Formato: <select name="formato" required>
                        <option value="CD">CD</option>
                        <option value="DVD">DVD</option>
                        <option value="BLURAY">BLURAY</option>
                    </select>
                    <br><br>
                    <button type="submit" class="btn btn-success">Guardar</button>
                    <button type="button" onclick="cerrarFormulario()" class="btn btn-secondary">Cancelar</button>
                </form>
            </div>

            <!-- Formulario de edición (escondido por defecto) -->
            <div id="editarForm" style="display:none;">
                <h2>Editar Elemento Audiovisual</h2>
                <form action="${pageContext.request.contextPath}/empleado/audiovisuales/editar" method="post">
                    <input type="hidden" id="audiovisualId" name="audiovisualId" />
                    <div>
                        <label for="elementoId">Elemento ID:</label>
                        <input type="number" id="elementoId" name="elementoId" required />
                    </div>
                    <div>
                        <label for="formato">Formato:</label>
                        <select id="formato" name="formato" required>
                            <option value="CD">CD</option>
                            <option value="DVD">DVD</option>
                            <option value="BLURAY">BLURAY</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar cambios</button>
                    <button type="button" onclick="cerrarEditarForm()" class="btn btn-primary">Cancelar</button>
                </form>
            </div>

            <!-- Mostrar los elementos existentes -->
            <table>
                <thead>
                    <tr>
                        <th>Elemento ID</th>
                        <th>Formato</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Audiovisual> audiovisuales = (List<Audiovisual>) request.getAttribute("audiovisuales");
                        if (audiovisuales != null) {
                            for (Audiovisual av : audiovisuales) {
                    %>
                    <tr>
                        <td><%= av.getElementoId()%></td>
                        <td><%= av.getFormato()%></td>
                        <td>
                            <!-- Botón para editar -->
                            <a href="#" onclick="editar(<%= av.getAudiovisualId()%>, <%= av.getElementoId()%>, '<%= av.getFormato()%>')" class="btn btn-primary">Editar</a>
                            <!-- Botón para eliminar -->
                            <a href="${pageContext.request.contextPath}/empleado/audiovisuales/eliminar/<%= av.getAudiovisualId()%>" class="btn btn-danger">Eliminar</a>


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
            function mostrarFormulario() {
                // Mostrar el formulario de creación
                document.getElementById('formularioAudiovisual').classList.remove('hidden');
                document.getElementById('btnNuevoAudiovisual').classList.add('hidden');
            }

            function cerrarFormulario() {
                // Ocultar el formulario de creación
                document.getElementById('formularioAudiovisual').classList.add('hidden');
                document.getElementById('btnNuevoAudiovisual').classList.remove('hidden');
            }

            function editar(audiovisualId, elementoId, formato) {
                // Mostrar el formulario de edición y llenar los campos
                document.getElementById('editarForm').style.display = 'block';
                document.getElementById('audiovisualId').value = audiovisualId;
                document.getElementById('elementoId').value = elementoId;
                document.getElementById('formato').value = formato;
            }

            function cerrarEditarForm() {
                // Ocultar el formulario de edición
                document.getElementById('editarForm').style.display = 'none';
            }
        </script>
    </body>
</html>