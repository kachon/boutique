
angular.module('boutiqueControllers').controller(
  'NewClothingCtrl', ($scope, $modal) ->

    video = document.getElementsByTagName('video')[0];
    canvas = document.createElement('canvas')
    canvas.width = 160
    canvas.height = 120
    $scope.unitPrice = 0
    $scope.imageUrl = null
    $scope.date = null

    $scope.formats = ['dd-MMMM-yyyy', 'yyyy-MM-dd', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[1];

    $scope.today = () ->
      $scope.date = new Date()

    $scope.today()

    $scope.clear = () ->
      $scope.date = null

    $scope.open = ($event) =>
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true
  
    $scope.add = () =>
      console.log "Add clothing #{$scope.unitPrice} #{$scope.date}"

    $scope.startVideo = () =>
      try
        window.navigator.mozGetUserMedia(
          {video:true}
        , 
          (stream) =>
            video.mozSrcObject = stream;
            video.play();
        , 
          (err) =>
            console.log "got err #{err}"
            return
        )
      catch e
        console.log "got exception #{e}"

    $scope.takePic = () ->
      ctx = canvas.getContext('2d');
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
      $scope.imageUrl = canvas.toDataURL('image/png')

  
)