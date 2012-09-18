uniform mediump mat4 ModelViewProjectionMatrix;

attribute mediump vec3 VertexPosition;
attribute mediump vec2 VertexTextureCoordinate;

varying mediump vec2 FragmentTextureCoordinate;

void main( void ) 
{
    gl_Position = ModelViewProjectionMatrix * vec4(VertexPosition, 1.0);
    FragmentTextureCoordinate = VertexTextureCoordinate;
} 