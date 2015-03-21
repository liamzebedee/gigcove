angular.module('app').controller('UserCtrl', function($scope, Session) {
    $scope.userInfo = {
        email: '',
        password: ''
    };
    $scope.authError = null;
    $scope.login = function() {
        $scope.authError = null;

        Session.login($scope.userInfo.email, $scope.userInfo.password)
            .then(function(response) {
                $scope.authError = 'Success!';
            }, function(response) {
                $scope.authError = 'Server offline, please try later';
            });
    };
});