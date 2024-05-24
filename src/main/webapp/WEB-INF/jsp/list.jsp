<%@ page import="ru.javawebinar.basejava.model.ContactType" %>
<%@ page import="ru.javawebinar.basejava.Config" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Список всех резюме</title>
    <link rel="stylesheet" href="../../css/theme/${theme}.css">
    <link rel="stylesheet" href="../../css/styles.css">
    <link rel="stylesheet" href="../../css/edit-resume-styles.css">
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<table border="1">
    <tr>
        <th>num</th>
        <th>full name</th>
        <th>mail</th>
        <th></th>
        <th></th>
    </tr>
    <c:forEach items="${resumes}" var="list" varStatus="loop">
        <tr>
            <td>${loop.index+1}</td>
            <td><a href="resumes?uuid=${list.uuid}&action=view">${list.fullName}</a></td>
            <td>${list.contacts[ContactType.MAIL]}</td>
            <td><a href="resumes?uuid=${list.uuid}&action=delete"><img src="../../img/delete.png" alt=""></a></td>
            <td><a href="resumes?uuid=${list.uuid}&action=edit"><img src="../../img/pencil.png" alt=""></a></td>
        </tr>
    </c:forEach>
</table>
<form action="resumes" method="get">
    <input type="hidden" name="action" value="add">
    <button type="submit">Добавить новое резюме</button>
</form>
<jsp:include page="fragments/footer.jsp"/>
</body>
</html>
