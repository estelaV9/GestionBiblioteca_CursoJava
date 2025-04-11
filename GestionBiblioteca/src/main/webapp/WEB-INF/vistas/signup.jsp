<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            form {
                background-color: #fff;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 350px;
            }

            h2 {
                text-align: center;
                margin-bottom: 1.5rem;
            }

            div {
                margin-bottom: 1rem;
            }

            label {
                display: block;
                margin-bottom: 0.3rem;
            }

            input, select {
                width: 100%;
                padding: 0.5rem;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                width: 100%;
                padding: 0.6rem;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            button:hover {
                background-color: #218838;
            }

            p {
                text-align: center;
                margin-top: 1rem;
            }

            .error {
                color: red;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <form action="./register" method="post">
            <h2>Registrarse</h2>

            <div>
                <label for="type">Registrarse como:</label>
                <select id="type" name="type" onchange="toggleUserFields()" required>
                    <option value="">Selecciona...</option>
                    <option value="empleado">Empleado</option>
                    <option value="socio">Socio</option>
                </select>
            </div>

            <div>
                <label for="username">Usuario:</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div>
                <label for="fullname">Nombre completo:</label>
                <input type="text" id="fullname" name="fullname" required>
            </div>

            <div>
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required>
            </div>


            <!-- Campos para Empleados -->
            <div id="empleado-fields" style="display: none;">
                <label for="employeeNumber">Número de empleado:</label>
                <input type="text" id="employeeNumber" name="employeeNumber">

                <label for="adminLevel">Nivel de administración:</label>
                <select id="adminLevel" name="adminLevel">
                    <option value="bajo">Bajo</option>
                    <option value="alto">Alto</option>
                </select>
            </div>

            <!-- Campos para Socios -->
            <div id="socio-fields" style="display: none;">
                <label for="dni">DNI:</label>
                <input type="text" id="dni" name="dni">

                <label for="dob">Fecha de nacimiento:</label>
                <input type="date" id="dob" name="dob">
            </div>

            <div>
                <button type="submit">Registrarse</button>
            </div>

            <p>¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/login">Inicia sesión aquí</a></p>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
        </form>

        <script>
            function toggleUserFields() {
                const tipo = document.getElementById('type').value;
                document.getElementById('empleado-fields').style.display = tipo === 'empleado' ? 'block' : 'none';
                document.getElementById('socio-fields').style.display = tipo === 'socio' ? 'block' : 'none';
            }
        </script>
    </body>
</html>
