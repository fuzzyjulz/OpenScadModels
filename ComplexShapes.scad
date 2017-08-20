module cubeoid(front_face, rear_face, length) {
    front_offset = [front_face.x/2, front_face.y/2, -length/2];
    rear_offset = [rear_face.x/2, rear_face.y/2, length/2];
    
    CubePoints = [
      [  -front_offset.x,  front_offset.z, -front_offset.y ],  //0
      [ front_face.x-front_offset.x,  front_offset.z,  -front_offset.y ],  //1
      [ rear_face.x-rear_offset.x,  rear_offset.z,  -rear_offset.y ],  //2
      [  -rear_offset.x,  rear_offset.z,  -rear_offset.y ],  //3
      [  -front_offset.x,  front_offset.z,  front_face.y-front_offset.y ],  //4
      [ front_face.x-front_offset.x,  front_offset.z,  front_face.y-front_offset.y ],  //5
      [ rear_face.x-rear_offset.x,  rear_offset.z,  rear_face.y-rear_offset.y ],  //6
      [  -rear_offset.x,  rear_offset.z,  rear_face.y-rear_offset.y ]]; //7
  
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
  
    polyhedron( CubePoints, CubeFaces );
}
