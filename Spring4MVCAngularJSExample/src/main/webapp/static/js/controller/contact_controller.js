'use strict';

angular.module('myApp').controller('ContactController', function($scope, ContactService) {
    var self = this;
    self.contact={id:null,name:'',address:'',email:''};
    self.contacts=[];

    self.submit = submit;
    self.edit = edit;
    self.remove = remove;
    self.reset = reset;
    self.updateContact = updateContact;
    self.createContact = createContact;
    self.deleteContact = deleteContact;
    self.setValue4Del  = setValue4Del;
    self.setValue4Update  = setValue4Update;
    
    $scope.isUpdateOrDel = false;
    fetchAllContacts();
    $scope.headerTitle = 'Contact Registration Form';
    function fetchAllContacts(){
    	ContactService.fetchAllContacts()
            .then(
            function(d) {
                self.contacts = d;
            },
            function(errResponse){
                console.error('Error while fetching contacts');
            }
        );
    }

    function createContact(contact){
      console.log('create  Contact', self.contact);
    	ContactService.createContact(contact)
            .then(
    		fetchAllContacts,
            function(errResponse){
                console.error('Error while creating Contact');
            }
        );
    }

    function updateContact(contact, id){
     
    	ContactService.updateContact(contact, id)
            .then(
            		fetchAllContacts,
            function(errResponse){
                console.error('Error while updating Contact');
            }
        );
    }

    function deleteContact(id){
       $scope.title = 'Delete Contact';
    	ContactService.deleteContact(id)
            .then(
            		fetchAllContacts,
            function(errResponse){
                console.error('Error while deleting Contact');
            }
        );
    }

    function submit() {
        if(self.contact.id===null){
            console.log('Saving New Contact', self.contact);
            createContact(self.contact);
        }else{
        	 console.log('Contact updated with id ', self.contact.id);
            updateContact(self.contact, self.contact.id);
            console.log('Contact updated with id ', self.contact.id);
        }
        reset();
    }

    function edit(id){
        console.log('id to be edited', id);
         $scope.title = 'Update Contact';
        $scope.headerTitle = 'Contact Update Form';
        for(var i = 0; i < self.contacts.length; i++){
            if(self.contacts[i].id === id) {
                self.contact = angular.copy(self.contacts[i]);
                break;
            }
        }
    }

    function remove(id){
        console.log('id to be deleted', id);
        
        if(self.contact.id === id) {//clean form if the user to be deleted is shown there.
            reset();
        }
        deleteContact(id);
    }


    function reset(){
        self.contact={id:null,name:'',address:'',email:''};
       $scope.headerTitle = 'Contact Registration Form';
        $scope.myForm.$setPristine(); //reset Form
    }
    
    function setValue4Del(){
       $scope.title = 'Delete Contact';
       console.log('setValue4Del to be deleted');
        $scope.isUpdateOrDel = true;
    }
    function setValue4Update(){
       console.log('setValue4Update to be updated');
        $scope.isUpdateOrDel = false;
    }
    
    $scope.filterValue = function($event){
        if(isNaN(String.fromCharCode($event.keyCode))){
            $event.preventDefault();
        }
    };

});
