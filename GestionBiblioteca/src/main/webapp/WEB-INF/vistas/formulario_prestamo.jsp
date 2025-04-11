<%-- 
    Document   : formulario_prestamo
    Created on : 11 abr 2025, 9:22:42
    Author     : Formacion
--%>

<form action="/admin/prestamos/guardar" method="post">
    <label>Socio:</label>
    <select name="socio.userId">
        <c:forEach items="${socios}" var="s">
            <option value="${s.userId}">${s.fullname}</option>
        </c:forEach>
    </select>

    <label>Libro:</label>
    <select name="libro.libroId">
        <c:forEach items="${libros}" var="l">
            <option value="${l.libroId}">${l.genero} - ${l.editorial}</option>
        </c:forEach>
    </select>

    <button type="submit">Guardar préstamo</button>
</form>

