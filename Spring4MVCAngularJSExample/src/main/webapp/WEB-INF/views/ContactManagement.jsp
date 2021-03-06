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
  </head>
  <body ng-app="myApp" class="ng-cloak">
      <div class="generic-container" ng-controller="ContactController as ctrl">
          <div class="panel panel-default">
              <div class="panel-heading"><span class="lead">{{headerTitle}}</span></div>
              <div class="formcontainer">
                  <form ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">
                      <input type="hidden" ng-model="ctrl.contact.id" />
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Name</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.contact.name" name="uname" class="username form-control input-sm" placeholder="Enter your name" required ng-minlength="3"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.uname.$error.required">This is a required field</span>
                                      <span ng-show="myForm.uname.$error.minlength">Minimum length required is 3</span>
                                      <span ng-show="myForm.uname.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>
                        
                      
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Address</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.contact.address" class="form-control input-sm" placeholder="Enter your Address. [This field is validation free]"/>
                              </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Email</label>
                              <div class="col-md-7">
                                  <input type="email" ng-model="ctrl.contact.email" name="email" class="email form-control input-sm" placeholder="Enter your Email" required/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.email.$error.required">This is a required field</span>
                                      <span ng-show="myForm.email.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>
                      
                       <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Telephone</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.contact.telephone" ng-keypress="filterValue($event)" class="form-control input-sm" placeholder="Enter your Phone. [This field is validation free]"/>
                              </div>
                          </div>
                      </div>

                      <div class="row">
                          <div class="form-actions floatRight">
                              <!--<input type="button"  value="{{!ctrl.contact.id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">-->
                              
                             <input type="button" ng-if="!ctrl.contact.id === false" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal" value="Update" data-toggle="modal" data-target="#myModal" ng-click="ctrl.setValue4Update()"></input>
                             
                              <input type="button" ng-if="!ctrl.contact.id  === true "class="btn btn-primary btn-sm" ng-click="ctrl.createContact(ctrl.contact)" value="Add" ng-disabled="myForm.$invalid"></input>
                                                          
                              <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
          <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Contacts </span></div>
              <div class="tablecontainer">
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name</th>
                              <th>Address</th>
                              <th>Email</th>
                               <th>Telephone</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="u in ctrl.contacts">
                              <td><span ng-bind="u.id"></span></td>
                              <td><span ng-bind="u.name"></span></td>
                              <td><span ng-bind="u.address"></span></td>
                              <td><span ng-bind="u.email"></span></td>
                               <td><span ng-bind="u.telephone"></span></td>
                              <td>
                              <button type="button" ng-click="ctrl.edit(u.id)" class="btn btn-sm btn-success custom-width">Edit</button>
                              <!--<button type="button" confirmed-click="ctrl.remove(u.id)" class="btn btn-danger custom-width"  ng-confirm-click="Would you like to delete contact?">Remove</button>-->
                              <input type="button"  class="btn btn-danger btn-sm btn-sm" data-toggle="modal" data-target="#myModal"  ng-click="ctrl.setValue4Del()" value="Remove"  data-toggle="modal" data-target="#myModal"></input>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog" >
      <div class="modal-dialog">
      
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">{{title}}</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure?.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-info" data-dismiss="modal">No</button>
            <button ng-if = "isUpdateOrDel === false" type="button" ng-click="ctrl.updateContact(ctrl.contact, ctrl.contact.id)"class="btn btn-danger" data-dismiss="modal">Update</button>
            <button ng-if = "isUpdateOrDel === true" type="button" ng-click="ctrl.remove(ctrl.contact.id)"class="btn btn-danger" data-dismiss="modal">Delete</button>
          </div>
        </div>
        
      </div>
    </div>
    
  </div>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
      <script src="<c:url value='/static/js/app.js' />"></script>
      <script src="<c:url value='/static/js/service/contact_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/contact_controller.js' />"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </body>
</html>