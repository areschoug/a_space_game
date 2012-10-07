attribute vec4 position;
attribute vec4 inputTextureCoordinate;

varying vec2 textureCoordinate;

void main() {

//    mat4 RotationMatrix = mat4( cos(1.0), -sin(1.0), 0.0, 0.0,
//                               sin(1.0),  cos(1.0), 0.0, 0.0,
//                               0.0,           0.0, 1.0, 0.0,
//                               0.0,           0.0, 0.0, 1.0 );
//
//
//
//	gl_Position = position * RotationMatrix;


	gl_Position = position;
	textureCoordinate = inputTextureCoordinate.xy;
}