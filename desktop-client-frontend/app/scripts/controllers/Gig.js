angular.module('app').controller('GigCtrl', function($scope) {
	$scope.other = {
		newTag: ""
	};

    $scope.gig = {
    	// Server cares about these ones
        cost: 0,
        start_datetime: '',
        end_datetime: '',
        name: "",
        link_to_source: "",
        description: "",
        tags: [{
            name: "music"
        }],
        eighteen_plus: false,

        venue: {
            name: "",
            location: "",
            latitude: null,
            longitude: null,
            website: ""
        }
    };

    $scope.removeTag = function($index) {
    	$scope.gig.tags.splice($index, 1);
    };

    $scope.addTag = function() {
    	var tag = $scope.other.newTag;
    	if(tag == '') return;
    	var tagToAdd = { name: tag };
    	if(_.where($scope.gig.tags, tagToAdd).length) return;
    	$scope.gig.tags.push(tagToAdd);
    	$scope.other.newTag = '';
    };


})
.directive('ngEnter', function () {
    return function (scope, element, attrs) {
        element.bind("keydown keypress", function (event) {
            if(event.which === 13) {
                scope.$apply(function(){
                    scope.$eval(attrs.ngEnter);
                });

                event.preventDefault();
            }
        });
    };
});