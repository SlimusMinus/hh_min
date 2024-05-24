<%@ page import="com.urize.webapp.model.ContactType" %>
<%@ page import="com.urize.webapp.model.ListSection" %>
<%@ page import="com.urize.webapp.model.OrganizationSection" %>
<%@ page import="com.urize.webapp.model.SectionType" %>
<%@ page import="com.urize.webapp.sql.Config" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../../css/style.css">
    <jsp:useBean id="resume" type="com.urize.webapp.model.Resume" scope="request"/>
    <title>Резюме ${resume.fullName}</title>
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<form method="post" action="resumes" enctype="application/x-www-form-urlencoded">
    <input type="hidden" name="uuid" value="${resume.uuid}">
    <div class="scrollable-panel">
        <div class="form-wrapper">
            <div class="section">ФИО</div>
            <input class="field" type="text" name="fullName" size=55 aria-required="true" placeholder="ФИО"
                   value="${resume.fullName}"
                   required aria-placeholder="input name">

            <div class="section">Контакты</div>

            <c:forEach var="type" items="<%=ContactType.values()%>">
                <input class="field" type="text" name="${type.name()}" size=30 placeholder="${type.title}"
                       value="${resume.getContact(type)}">
            </c:forEach>

            <div class="spacer"></div>

            <div class="section">Секции</div>

            <c:forEach var="type" items="<%=SectionType.values()%>">
                <c:set var="section" value="${resume.getSection(type)}"/>
                <jsp:useBean id="section" type="com.urize.webapp.model.Section"/>
                <div class="field-label">${type.title}</div>
                <c:choose>
                    <c:when test="${type=='OBJECTIVE' || type=='PERSONAL'}">
                        <textarea class="field" name='${type}'><%=section%></textarea>
                    </c:when>
                    <c:when test="${type=='QUALIFICATIONS' || type=='ACHIEVEMENT'}">
                        <textarea class="field"
                                  name='${type}'><%=String.join("\n", ((ListSection) section).getList())%></textarea>
                    </c:when>
                    <c:when test="${type=='EXPERIENCE' || type=='EDUCATION'}">
                        <c:forEach var="org" items="<%=((OrganizationSection) section).getList()%>" varStatus="counter">
                            <c:choose>
                                <c:when test="${counter.index == 0}">
                                </c:when>
                                <c:otherwise>
                                    <div class="spacer"></div>
                                </c:otherwise>
                            </c:choose>

                            <input class="field" type="text" placeholder="Название" name='${type}' size=100
                                   value="${org.homePage.name}">
                            <input class="field" type="text" placeholder="Ссылка" name='${type}url' size=100
                                   value="${org.homePage.url}">

                            <c:forEach var="pos" items="${org.positions}">
                                <jsp:useBean id="pos" type="com.urize.webapp.model.Organization.Position"/>

                                <div class="date-section">
                                    <input class="field date" name="${type}${counter.index}startDate"
                                           placeholder="ММ/ГГГГ"
                                           size=10
                                           value="<%=pos.getStartDate()==null ? "" : pos.getStartDate()%>">
                                    <input class="field date date-margin" name="${type}${counter.index}endDate"
                                           placeholder="ММ/ГГГГ"
                                           size=10
                                           value="<%=pos.getEndDate()==null ? "" : pos.getEndDate()%>">
                                </div>

                                <input class="field" type="text" placeholder="Заголовок"
                                       name='${type}${counter.index}title' size=75
                                       value="${pos.title}">
                                <textarea class="field" placeholder="Описание"
                                          name="${type}${counter.index}description">${pos.description}</textarea>

                            </c:forEach>
                        </c:forEach>
                    </c:when>
                </c:choose>
            </c:forEach>

            <div class="spacer"></div>

            <div class="button-section">
                <button class="red-cancel-button" type="button" onclick="window.history.back()">Отменить</button>
                <c:if test="<%=!Config.getInstance().isImmutable(resume.getUuid())%>">
                    <button class="green-submit-button" type="submit">Сохранить</button>
                </c:if>
            </div>

        </div>
    </div>
</form>
<jsp:include page="fragments/footer.jsp"/>
</body>
</html>