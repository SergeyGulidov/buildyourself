app = angular.module("ST", ["ngResource"])

app.factory "Schedule", ["$resource", ($resource) ->
	$resource("/schedules/:id", {id: "@id"}, {update: {method: "PUT"}})]

@ScheduleCtrl = ["$scope", "Schedule", ($scope, Schedule) ->
	$scope.schedules = Schedule.query()

	$scope.addSchedule = ->
		schedule = Schedule.save($scope.newSchedule)
		$scope.schedules.push(schedule)
		$scope.newSchedule = {}
]