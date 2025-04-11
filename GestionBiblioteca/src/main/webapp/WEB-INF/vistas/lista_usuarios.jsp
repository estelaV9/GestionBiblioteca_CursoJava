<%-- 
    Document   : lista_usuarios
    Created on : 11 abr 2025, 9:23:30
    Author     : Formacion
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head><title>Lista de Usuarios</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f4f4f4;
            }
            h2 {
                color: #333;
                text-align: center;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: white;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #ddd;
            }
            button {
                background-color: #f44336;
                color: white;
                border: none;
                padding: 8px 16px;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            button:hover {
                background-color: #d32f2f;
            }
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
            <a class="navbar-brand" href="../../empleado/">Biblioteca</a>
            <a class="nav-link" href="../../empleado/libros/">Libros</a>
            <a class="nav-link" href="../../empleado/revistas/">Revistas</a>
            <a class="nav-link" href="../../empleado/audiovisuales/">Elementos Audiovisuales</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/lista">Lista de usuarios</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../../admin/usuarios/nuevo">Crear usuario</a>
            <a class="nav-link" style="background-color: #ff9ea2;" href="../../login">Cerrar sesión</a>
        </div>
        <h2 style="background-color: rgba(48, 63, 159, 0.9);">Socios</h2>
        <table>
            <tr><th style="color: black;">Nombre</th><th style="color: black;">DNI</th><th style="color: black;">Acciones</th></tr>
                    <c:forEach items="${socios}" var="s">
                <tr>
                    <td style="color: black;">${s.fullname}</td>
                    <td style="color: black;">${s.dni}</td>
                    <td style="color: black;">
                        <form action="${pageContext.request.contextPath}/admin/usuarios/eliminar/${s.userId}" method="post">
                            <button type="submit">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <h2 style="background-color: rgba(48, 63, 159, 0.9);">Empleados</h2>
        <table>
            <tr><th style="color: black;">Nombre</th><th style="color: black;">Número</th><th style="color: black;">Nivel</th><th style="color: black;">Acciones</th></tr>
                    <c:forEach items="${empleados}" var="e">
                <tr>
                    <td style="color: black;">${e.fullname}</td>
                    <td style="color: black;">${e.emplNum}</td>
                    <td style="color: black;">${e.adminLevel}</td>
                    <td style="color: black;">
                        <form action="${pageContext.request.contextPath}/admin/usuarios/eliminar/${e.userId}" method="post">
                            <button type="submit">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
