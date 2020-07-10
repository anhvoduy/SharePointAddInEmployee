'use strict';
(function () {
	'use strict';
	angular.module('appDocument', [])
		.directive('searchContainer', searchContainer)
		.controller('searchController', searchController)
		.factory('searchService', searchService)
		.filter('searchFor', searchFor);

	/* directive */
	searchContainer.$inject = [];
	function searchContainer() {
		return {
			restrict: 'EA',
			replace: true,
			transclude: true,
			controller: 'searchController',
			template: function () {
				var template =
					'	<div id="#instantSearch" class="instantSearch">																				 	       ' +
					'		<div class="bar">        																									 	   ' +
					'			<input type="text" ng-model="searchString" ng-change="changeSearch(searchString)"                                              ' +
					'                  placeholder="Enter your search terms" ng-keyup="$event.keyCode == 13 && submitSearch(searchString)"/>                   ' +
					'		</div>																														 	   ' +
					'		<ul>        																												 	   ' +
					'			<li ng-repeat="i in items | searchFor:searchString">																	 	   ' +
					'				<a href="{{i.url}}">																								 	   ' +
					'					<img ng-src="{{i.image}}" />																					 	   ' +
					'				</a>																												 	   ' +
					'				<p>{{i.title}}</p>																									 	   ' +
					'			</li>																													 	   ' +
					'		</ul>            																											 	   ' +
					'	</div>																															 	   ';
				return template;
			},
			link: function (scope, element, attrs, ngCtrl) {
				//console.log('init directive search-container.....');
			}
		};
	};

	/* controller */
	searchController.$inject = ['$scope', '$q', 'searchService'];
	function searchController($scope, $q, searchService) {
		// models
		$scope.searchString = '';
		$scope.items = [
			{
				url: '../Images/logo.png',
				title: '50 Must-have plugins for extending Twitter Bootstrap',
				image: '../Images/logo.png'
			},
			{
				url: '../Images/logo.png',
				title: 'Making a Super Simple Registration System With PHP and MySQL',
				image: '../Images/logo.png'
			},
			{
				url: '../Images/logo.png',
				title: 'Create a slide-out footer with this neat z-index trick',
				image: '../Images/logo.png'
			},
			{
				url: '../Images/logo.png',
				title: 'How to Make a Digital Clock with jQuery and CSS3',
				image: '../Images/logo.png'
			},
			{
				url: '../Images/logo.png',
				title: 'Smooth Diagonal Fade Gallery with CSS3 Transitions',
				image: '../Images/logo.png'
			},
			{
				url: '../Images/logo.png',
				title: 'Mini AJAX File Upload Form',
				image: '../Images/logo.png'
			},
			{
				url: '../Images/logo.png',
				title: 'Your First Backbone.js App – Service Chooser',
				image: '../Images/logo.png'
			}
		];

		// functions
		var activate = function () {
			$scope.appweburl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));
			$scope.hostweburl = decodeURIComponent(getQueryStringParameter("SPHostUrl"));
		}

		var getQueryStringParameter = function (paramToRetrieve) {
			var params = document.URL.split("?")[1].split("&");
			var strParams = "";
			for (var i = 0; i < params.length; i = i + 1) {
				var singleParam = params[i].split("=");
				if (singleParam[0] == paramToRetrieve)
					return singleParam[1];
			}
		}

		$scope.changeSearch = function (keyword) {
			console.log('- changeSearch():', keyword);
		}

		$scope.submitSearch = function (keyword) {
			var siteUrl = $scope.hostweburl || _spPageContextInfo.siteAbsoluteUrl;
			searchService.getData(siteUrl, keyword).then(function (result) {
				if (result) {
					console.log(result.d.query.PrimaryQueryResult);
				}
			}, function (error) {
				console.log(error);
			})
		};

		// start
		activate();
	};

	/* service */
	searchService.$inject = ['$http', '$q'];
	function searchService($http, $q) {		
		var searchService = function () {
		}
		searchService.prototype.getData = function (siteUrl, keyword) {
			var url = String.format("{0}/_api/search/query?querytext='{1}'", siteUrl, keyword);
			var q = $q.defer();
			$http({
				url: url,
				method: 'GET',
				headers: {
					"Accept": "application/json;odata=verbose"
				}
			}).then(function (result) {
				q.resolve(result);
			}, function (error, status) {
				q.reject(error);
			});
			return q.promise;
		}
		return new searchService;
	};

	/* instance search filter */
	function searchFor() {
		return function (arr, searchString) {
			if (!searchString) return arr;
			var result = [];
			searchString = searchString.toLowerCase();
			// Using the forEach helper method to loop through the array
			angular.forEach(arr, function (item) {
				if (item.title.toLowerCase().indexOf(searchString) !== -1) {
					result.push(item);
				}
			});
			return result;
		}
	};

	/* angular bootstrap */
	angular.element(function () {
		angular.bootstrap(appDocument, ['appDocument']);
	});
})();


/* prevent default form submit */
(function () {
	$(document).ready(function() {
		angular.element("#aspnetForm").submit(function(e){
			e.preventDefault();
			return false;
		});
	});	
})();