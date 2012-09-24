attribute vec4 position;
attribute vec4 inputTextureCoordinate;

varying vec2 textureCoordinate;

uniform mat4 projection;

void main()
{
    //gl_Position = projection * position;
	gl_Position = position;
	textureCoordinate = inputTextureCoordinate.xy;
}