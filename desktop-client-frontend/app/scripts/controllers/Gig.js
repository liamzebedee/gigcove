angular.module('app').controller('GigCtrl', function($scope) {
	$scope.other = {
		newTag: ""
	};

    $scope.gig = {
    	// Server cares about these ones
        cost: 25,
        start_datetime: 'rfc3339',
        end_datetime: 'rfc3339',
        name: "Gig numero 1",
        link_to_source: "http://test-gig-1.com",
        description: "Words cannot \ndescribe this gig.",
        tags: [{
            name: "music"
        }, {
            name: "dance"
        }, {
            name: "hip"
        }, {
            name: "TheFestival"
        }],
        eighteen_plus: false,

        venue: {
            name: "Brisbane Powerhouse",
            location: "119 Lamington Street, New Farm QLD",
            latitude: -27.467882,
            longitude: 153.053568,
            website: "http://brisbanepowerhouse.org"
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