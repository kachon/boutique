angular.module('boutiqueControllers').controller(
  'MainCtrl', ($scope, $modal) ->
    console.log "MainCtrl constructor"
)

angular.module('boutiqueControllers').controller(
  'LogoutCtrl', ($scope, $modal) ->
    console.log "Logout constructor"
    window.dropboxService.client.signOff()
)

angular.module('boutiqueControllers').controller(
  'NewClothingCtrl', ($scope, $modal, $http) ->

    console.log "NewClothingCtrl constructor"

    # client = new Dropbox.Client({ key: "uonyr25yyc5c53z" })
    # #client.signOff()
    # client.authenticate (err, client) =>
    #   if (err)
    #     alert "here #{JSON.stringify err.status}"
    #   # else
    #   #   console.log ("dropbox client login successful")
        
    #     client.getAccountInfo (error, accountInfo) ->
    #       if error
    #         alert( "#{error}")
    #       alert("#{JSON.stringify accountInfo}")  
          # client.signOff()
        
    video = document.getElementsByTagName('video')[0];
    canvas = document.createElement('canvas')
    canvas.width = 160
    canvas.height = 120
    $scope.unitPrice = 0
    $scope.imageUrl = null
    $scope.date = null
    $scope.desc = null
    $scope.imgLink = null
    $scope.formatDate = ""
    $scope.id = 0

    $scope.formats = ['dd-MMMM-yyyy', 'yyyy-MM-dd', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[1];

    $scope.today = () ->
      $scope.date = new Date()

    $scope.today()

    $scope.clear = () ->
      $scope.today()
      $scope.unitPrice = 0
      $scope.imgLink = null
      $scope.desc = null

    $scope.open = ($event) =>
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true

    $scope.add = () =>
      $scope.formatDate = "#{$scope.date.getFullYear()}/#{$scope.date.getMonth()+1}/#{$scope.date.getDate()}"
      console.log "Add clothing #{$scope.unitPrice} #{$scope.formatDate}"
      data = { clothing: {} }
      data.clothing.date = $scope.formatDate
      data.clothing.desc = $scope.desc
      data.clothing.unit_price = $scope.unitPrice
      data.clothing.img_link = $scope.imgLink
      $http.post("/clothings/", data)
        .success (data, status, headers, config) =>
          console.log ("success #{JSON.stringify data}")
          id = data.id
          filename = "#{id}.jpg"
          imgData = canvas.mozGetAsFile(filename)
          window.dropboxService.client.writeFile(filename, imgData, (error, stat) =>
            console.log ("writefile callback #{error} #{stat}")
          )
          alert("Successful create clothing #{id}")
          $scope.clear()
        .error (data, status, headers, config) =>
          console.log ("error #{JSON.stringify data}")
      #window.client.signOff()
      # data = canvas.mozGetAsFile('webcam.png')
      # window.dropboxService.client.writeFile("webcam.png", data, (error, stat) =>
      #   console.log ("writefile callback #{error} #{stat}")
      # )

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

    $scope.get = (id) =>
      $scope
      $http.get("/clothings/#{id}")
        .success (data, status, headers, config) =>
          console.log ("success #{JSON.stringify data}")
          $scope.formatDate = data.date
          $scope.unitPrice = data.unit_price
          console.log ("update complete")
          $scope.imageUrl = window.dropboxService.client.thumbnailUrl "#{id}.jpg", {size: 'l'}
          # $scope.$apply ->
          #   console.log( "here?")
            # $scope.date = new Date(data.date)
            # $scope.unitPrice = data.uni_price
          # id = data.id
          # filename = "#{id}.jpg"
          # imgData = canvas.mozGetAsFile(filename)
          # window.dropboxService.client.writeFile(filename, imgData, (error, stat) =>
          #   console.log ("writefile callback #{error} #{stat}")
          # )
          # alert("Successful create clothing #{id}")
          # $scope.clear()
        .error (data, status, headers, config) =>
          console.log ("error #{JSON.stringify data}")
  
)