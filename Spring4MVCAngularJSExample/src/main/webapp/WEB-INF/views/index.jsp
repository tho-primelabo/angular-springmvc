<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>  
    <title>AngularJS $http Example</title>  
    <style>
      .username.ng-valid {
          background-color: lightgreen;
      }
      .username.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .username.ng-dirty.ng-invalid-minlength {
          background-color: yellow;
      }

      .email.ng-valid {
          background-color: lightgreen;
      }
      .email.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .email.ng-dirty.ng-invalid-email {
          background-color: yellow;
      }

    </style>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
     <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
       <script data-require="ui-bootstrap@*" data-semver="0.12.1" src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.12.1.min.js"></script>
  </head>
  <body ng-app="myApp" class="ng-cloak">
      <div class="generic-container" ng-controller="TodoController">
          <h1>Todos</h1>
    <h4>{{items.length}} total</h4>
    <ul>
      <li ng-repeat="todo in filteredTodos">{{todo.id}}</li>
    </ul>
    <pagination 
      ng-model="currentPage"
      total-items="items.length"
      max-size="maxSize"  
      boundary-links="true">
    </pagination>
    
    </div>
     
      <script src="<c:url value='/static/js/app.js' />"></script>
      <script src="<c:url value='/static/js/service/contact_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/contact_controller.js' />"></script>
       <script src="<c:url value='/static/js/controller/script.js' />"></script>
    
    
  </body>
</html>