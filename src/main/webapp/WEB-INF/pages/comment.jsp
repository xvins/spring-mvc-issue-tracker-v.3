<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Comment Issue - Spring MVC Application</title>
    <meta charset="utf-8">
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
        <strong>${issue.name}</strong><br><br>


        <table width="300">
            <tr><td><strong>Author</strong></td><td><c:out value="${issue.author}" /></td></tr>
            <tr><td><strong>Status</strong></td><td><c:out value="${issue.status}" /></td></tr>
            <tr><td><strong>Start Date</strong></td><td><fmt:formatDate value="${issue.date}" pattern="MM/d/yyyy hh:mm" /></td></tr>
        </table><br>
        <strong>Description:</strong><br>
       <c:out value="${issue.description}" /><br><br>

        <strong>Comments:</strong><br>
        <c:forEach items="${comments}" var="comment">
            Update by ${comment.author} <fmt:formatDate value="${comment.date}" pattern="MM/d/yyyy hh:mm" />:<br>
            <p style="text-indent: 15"><i>Status changed to ${comment.status}</i></p>
            ${comment.text}
        </c:forEach>

        <h4>Add comment</h4>
        <form:form commandName="comment" class="commentForm">
                <div class="control-group">
                    <label>Status:</label>
                    <div class="controls">
                        <form:select path="status" items="${statusList}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label>Author:</label>
                    <div class="controls">
                        <form:input path="author" />
                    </div>
                </div>
                <div class="control-group">
                    <label>Text:</label>
                    <div class="controls">
                        <form:input path="text" type="textarea" class="form-control" rows="3"/>
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input type="submit" value="Save" class="" />
                    </div>
                </div>
            </form:form>
        <script type="text/javascript">
            $(document).ready(function() {
                $(".commentForm").validate(
                        {
                            rules: {
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
</body>
</html>
