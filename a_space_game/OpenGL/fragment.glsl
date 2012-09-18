uniform sampler2D TextureSampler;

varying mediump vec2 FragmentTextureCoordinate;

void main( void )
{
    gl_FragColor = texture2D(TextureSample, FragmentTextureCoordinate);
}