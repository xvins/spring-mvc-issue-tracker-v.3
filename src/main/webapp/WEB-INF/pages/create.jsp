<!doctype html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://tiles.apache.org/tags-tiles-extras" prefix="tilesx" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Spring MVC Application</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <!-- Optional theme -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript"
            src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
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

    <div class="row">
        <div class="span8 offset2">

            <h1>Issue Tracker</h1>

            <form:form method="post" action="create" commandName="issue" class="form-horizontal issueForm">
            <div class="control-group">
                <form:label cssClass="control-label" path="name">Name:</form:label>
                <div class="controls">
                    <form:input path="name"/>
                </div>
            </div>
            <div class="control-group">
                <form:label cssClass="control-label" path="author">Author:</form:label>
                <div class="controls">
                    <form:input path="author"/>
                </div>
            </div>
            <div class="control-group">
                <form:label cssClass="control-label" path="description">Description:</form:label>
                <div class="controls">
                        <%--<form:input path="description"/>--%>
                    <form:input path="description" type="textarea" class="form-control" rows="3" />
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <input type="submit" value="Add Issue" class="btn"/>
                    </form:form>
                </div>
            </div>

            <script type="text/javascript">
                $(document).ready(function() {
                    $(".issueForm").validate(
                            {
                                rules: {
                                    name: {
                                        required : true,
                                        minlength : 1
                                    },
                                    author: {
                                        required : true,
                                        minlength : 3
                                    }
                                },
                                highlight: function(element) {
                                    $(element).closest('.control-group').removeClass('has-success').addClass('has-error');
                                },
                                unhighlight: function(element) {
                                    $(element).closest('.control-group').removeClass('has-error').addClass('has-success');
                                }
                            }
                    );
                })
            </script>

        </div>
    </div>
</div>

</body>
</html>