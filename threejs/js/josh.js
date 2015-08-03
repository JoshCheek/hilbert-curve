"use strict"

var Josh = {}

Josh.renderCurve = function(cameraPosition, lookAt, lineWidth, domElement, vertices) {
  var scene = new THREE.Scene()

  // lights
  scene.add(Josh.ambientlight({colour: 0x000033}))

  // curve
  //   we can also use:
  //     linecap — Define appearance of line ends. Default is 'round'.
  //     linejoin — Define appearance of line joints. Default is 'round'.
  var material = new THREE.LineBasicMaterial({
    color:        0x0000ff,
    linewidth:    lineWidth,
    vertexColors: THREE.VertexColors,
  });

  var geometry = new THREE.Geometry()
  vertices.forEach(function(vertex) {
    geometry.vertices.push(new THREE.Vector3(vertex[0], vertex[1], vertex[2]))
  })

  var line = new THREE.Line(geometry, material)
  scene.add(line);

  // add to DOM
  var renderer = new THREE.WebGLRenderer()
  renderer.setClearColor(0x333333, 1.0)
  renderer.setSize(domElement.offsetWidth, domElement.offsetHeight)
  domElement.appendChild(renderer.domElement)

  // render
  var camera = Josh.camera({
    from:        cameraPosition,
    aspectRatio: domElement.offsetWidth / domElement.offsetHeight,
  });
  camera.lookAt(new THREE.Vector3(lookAt[0], lookAt[1], lookAt[2]))

  var render    = function() { renderer.render(scene, camera) }
  render.camera = camera
  render.scene  = scene
  render.line   = line
  return render
}

Josh.ambientlight = function(attrs) {
  if(attrs == undefined) attrs = {}
  var colour = attrs.colour || 0xffffff
  var light  = new THREE.AmbientLight(colour)
  return light
}

// only works on MeshLambertMaterial and MeshPhongMaterial
Josh.spotlight = function(attrs) {
  if(attrs == undefined) attrs = {}
  var colour = attrs.colour || 0xffffff
  var from   = attrs.from   || [0, 0, 0]
  // var width  = attrs.width  || 1024
  // var height = attrs.height ||
  var light  = new THREE.SpotLight(colour)
  light.position.set(from[0], from[1], from[2])

  light.castShadow       = true

  light.shadowMapWidth   = 1024
  light.shadowMapHeight  = 1024

  light.shadowCameraNear = 500
  light.shadowCameraFar  = 4000
  light.shadowCameraFov  = 30

  light.intensity        = 0.9

  return light
}

// what we can see of the scene
Josh.camera = function(attrs) {
  if(attrs == undefined) attrs = {}
  var from   = attrs.from        || [0, 0, 0]
  var to     = attrs.to          || [0, 0, 0]
  var ar     = attrs.aspectRatio || 16/9
  var fov    = attrs.fieldOfView || 45
  var near   = attrs.nearPlane   || 0.1  // closest thing you can see
  var far    = attrs.farPlane    || 1000 // farthest thing you can see
  var camera = new THREE.PerspectiveCamera(fov, ar, 0.1, 100)
  camera.position.x = from[0]
  camera.position.y = from[1]
  camera.position.z = from[2]
  camera.lookAt(new THREE.Vector3(to[0], to[1], to[2]))

  return camera
}
