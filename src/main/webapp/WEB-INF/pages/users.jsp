<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Users</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <!-- Optional theme -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<body>
<div class="container">
    <!-- Static navbar -->
    <div class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<spring:url value="/" /> ">Issue Tracker</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <security:authorize access="isAuthenticated()">
                        <li><a href="<spring:url value="/create" /> ">Create issue</a></li>
                    </security:authorize>
                    <security:authorize access="hasRole('ROLE_ADMIN')">
                        <li><a href="<spring:url value="/users" /> ">Users</a></li>
                    </security:authorize>
                    <li><a href="<spring:url value="/register" /> ">Register</a></li>
                    <security:authorize access="! isAuthenticated()">
                        <li><a href="<spring:url value="/login" /> ">Login</a></li>
                    </security:authorize>
                    <security:authorize access="isAuthenticated()">
                        <li><a href="<spring:url value="/account" /> ">My account</a></li>
                        <li><a href="<spring:url value="/logout" /> ">Logout</a></li>
                    </security:authorize>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
    </div>

    <table class="table table-bordered table-hover table-striped">
        <thead>
            <tr>
                <th>user name</th>
            </tr>
        </thead>
        <tbody>
            <s:forEach items="${users}" var="user">
                <tr>
                    <td>
                        <a href="<spring:url value="/users/${user.id}" />">
                        ${user.name}
                        </a>
                    </td>
                </tr>

            </s:forEach>
        </tbody>
    </table>

</div>
</body>
</html>
