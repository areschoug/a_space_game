varying highp vec2 textureCoordinate;

uniform sampler2D textureFrame;

uniform lowp vec4 color;

void main() {
    gl_FragColor = texture2D(textureFrame, textureCoordinate) * color;
}
