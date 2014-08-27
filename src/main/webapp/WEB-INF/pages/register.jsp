<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Registration - Spring MVC Application</title>
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

        <form:form commandName="user" cssClass="form-horizontal registrationForm">
            
            <c:if test="${param.success eq true}">
                <div class="alert alert-success" >Registration successful!</div>
            </c:if>
            
            <div class="form-group">
                <label path="name" class="col-sm-2 control-label">Name:</label>
                <div class="col-sm-10">
                    <form:input path="name" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label path="email" class="col-sm-2 control-label">Email:</label>
                <div class="col-sm-10">
                    <form:input path="email" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label path="password" class="col-sm-2 control-label">Password:</label>
                <div class="col-sm-10">
                    <form:password path="password" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label path="password" class="col-sm-2 control-label">Password again:</label>
                <div class="col-sm-10">
                    <input type="password" name="password_again" id="password_again" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-10">
                    <input type="submit" value="Save" class="btn btn-Lg btn-primary">
                </div>
            </div>
        </form:form>

        <script type="text/javascript">
            $(document).ready(function() {
                $(".registrationForm").validate(
                    {
                        rules: {
                            name: {
                                required : true,
                                minlength : 3
                            },
                            email: {
                                required : true,
                                email : true
                            },
                            password: {
                                required : true,
                                minlength : 5
                            },
                            password_again: {
                                required : true,
                                minlength : 5,
                                equalTo: "#password"
                            }
                        },
                        highlight: function(element) {
                            $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                        },
                        unhighlight: function(element) {
                            $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
                        }
                    }
                )
            });
        </script>


    </div>
</body>
</html>
