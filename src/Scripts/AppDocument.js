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
	searchController.$inject = ['$scope', 'searchService'];
	function searchController($scope, searchService) {
		// models
		$scope.searchString = '';
		$scope.items = [];

		// functions
        var activate = function () {
            $scope.webAbsoluteUrl = _spPageContextInfo.webAbsoluteUrl;
			$scope.appweburl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));
			$scope.hostweburl = decodeURIComponent(getQueryStringParameter("SPHostUrl"));
		}

		var getQueryStringParameter = function (paramToRetrieve) {
			var params = document.URL.split("?")[1].split("&");
			for (var i = 0; i < params.length; i = i + 1) {
				var singleParam = params[i].split("=");
                if (singleParam[0] == paramToRetrieve) {
                    return singleParam[1];
                }
			}
		}

		$scope.changeSearch = function (keyword) {
			//console.log('- changeSearch():', keyword);
		}

		$scope.submitSearch = function (keyword) {
            searchService.getData($scope.webAbsoluteUrl, keyword).then(function (result) {
                var { query } = result.data.d;
                console.log('- query:', query);
                if (query) {                                        
                    angular.forEach(query.PrimaryQueryResult.RelevantResults.Table.Rows.results, function (item) {
                        var itemInfo = item.Cells.results;
                        $scope.items.push({
                            lastModifiedTime: itemInfo[9].Value, // LastModifiedTime
                            fileType: itemInfo[31].Value, // FileType
                            fileSize: itemInfo[5].Value, // Size
                            author: itemInfo[4].Value, // Author
                            siteName: itemInfo[29].Value, // SiteName
                            url: itemInfo[6].Value, // Path
                            image: itemInfo[17].Value, // ServerRedirectedPreviewURL
                            title: itemInfo[3].Value // Title
                        });
                    });
                }
            }, function (error) {
                console.log(error);
            });
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
                headers: { "Accept": "application/json;odata=verbose" }
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