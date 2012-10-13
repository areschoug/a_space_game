attribute vec4 position;
attribute vec4 inputTextureCoordinate;

uniform mat4 projection;
uniform mat4 modelview;

varying vec2 textureCoordinate;

void main() {
	gl_Position = projection * modelview * position;
	textureCoordinate = inputTextureCoordinate.xy;
}