<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, Modelos.Revista" %>
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
        </style>
    </head>
    <body>
        <div class="navbar">
            <a class="navbar-brand" href="../">Biblioteca</a>
            <a class="nav-link" href="../libros/">Libros</a>
            <a class="nav-link">Revistas</a>
            <a class="nav-link" href="../audiovisuales/">Elementos Audiovisuales</a>
        </div>

        <div class="container">
            <h1>Revistas</h1>
            <table>
                <thead>
                    <tr>
                        <th>Elemento ID</th>
                        <th onclick="sortTable()" style="cursor: pointer;">Número de Publicación ⬍</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Revista> revistas = (List<Revista>) request.getAttribute("revistas");
                        if (revistas != null) {
                            for (Revista revista : revistas) {
                    %>
                    <tr>
                        <td><%= revista.getElementoId()%></td>
                        <td><%= revista.getNumPublicacion()%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script>
            let ascending = true;

            function sortTable() {
                const table = document.querySelector("table");
                const tbody = table.querySelector("tbody") || table;
                const rows = Array.from(tbody.rows);

                rows.sort((a, b) => {
                    const valA = parseInt(a.cells[1].innerText);
                    const valB = parseInt(b.cells[1].innerText);
                    return ascending ? valA - valB : valB - valA;
                });

                ascending = !ascending;

                rows.forEach(row => tbody.appendChild(row));
            }
        </script>
    </body>
</html>