<%-- 
    Document   : lista_prestamos
    Created on : 11 abr 2025, 9:24:03
    Author     : Formacion
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Lista de Préstamos</title></head>
<body>
<h2>Préstamos Actuales</h2>
<table border="1">
    <tr>
        <th>Socio</th><th>Libro</th><th>Fecha Préstamo</th><th>Devolución</th><th>Acciones</th>
    </tr>
    <c:forEach items="${prestamos}" var="p">
        <tr>
            <td>${p.socio.fullname}</td>
            <td>${p.libro.editorial}</td>
            <td>${p.fechaPrestamo}</td>
            <td>${p.fechaDevolucion != null ? p.fechaDevolucion : 'Pendiente'}</td>
            <td>
                <form action="/admin/prestamos/devolver/${p.prestamoId}" method="post">
                    <button type="submit">Devolver</button>
                </form>
                <a href="/admin/prestamos/multa/${p.prestamoId}">Generar Multa</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
