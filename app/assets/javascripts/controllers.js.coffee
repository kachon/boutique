
# boutiqueApp = angular.module('boutiqueApp', [])
boutiqueControllers = angular.module('boutiqueControllers', [])

boutiqueControllers.controller 'BoutiqueCtrl', ($scope) ->

  console.log "constructor?"
  video = document.getElementsByTagName('video')[0];
  canvas = document.getElementsByTagName('canvas')[0];

  $scope.clothings = [
      'name': 'dress 1'
      'unit_price': 100
    ,
      'name': 'dress 2'
      'unit_price': 200
    ,
      'name': 'dress 3'
      'unit_price': 300
  ]

  # $scope.message = "hello?"

  $scope.takeSnapshot = () ->
    console.log "Snapshot is clicked"
    $scope.msg = "clicked!!"
    ctx = canvas.getContext('2d');
    ctx.drawImage(video, 0, 0, 640, 480);
    $scope.imageUrl = canvas.toDataURL('image/png')
  $scope.startMedia = () =>
    #$scope.msg = "wtf"
    
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
          $scope.$apply ->
            $scope.msg = "???"
          
          console.log "why it is not changed?"
          return
      )
    catch e
      console.log "got exception #{e}"
      $scope.msg = e

  return
