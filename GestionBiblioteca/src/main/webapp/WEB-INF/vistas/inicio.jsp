<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <style>
            body {
                background: linear-gradient(45deg, #F7F9F9, #BED8D4, #78D5D7, #63D2FF, #2081C3);
                background-size: 400% 400%;
                animation: gradientBG 15s ease infinite;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                text-align: center;
                align-content: center;
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

            /* Estilo para el mensaje de bienvenida */
            .welcome-message {
                font-size: 3rem;
                font-weight: 700;
                background: linear-gradient(45deg, #000, #434343, #222);
                -webkit-background-clip: text;
                color: transparent;
                text-shadow: 2px 2px 12px rgba(0, 0, 0, 0.7);
                margin-top: 250px;  /* Espacio desde la parte superior */
                padding: 10px;
                max-width: 80%;
                line-height: 1.4;
                margin-left: 150px;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <a class="navbar-brand">Biblioteca</a>
            <a class="nav-link" href="./libros/">Libros</a>
            <a class="nav-link" href="./revistas/">Revistas</a>
            <a class="nav-link" href="./audiovisuales/">Elementos Audiovisuales</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../admin/usuarios/lista">Lista de usuarios</a>
            <a class="nav-link" style="background-color: lightblue; color: black;" href="../admin/usuarios/nuevo">Crear usuario</a>
            <a class="nav-link" style="background-color: #ff9ea2;" href="../login">Cerrar sesión</a>
        </div>
        <div class="welcome-message">
            Bienvenido a la biblioteca T-Rexoteca
        </div>

    </body>
</html>