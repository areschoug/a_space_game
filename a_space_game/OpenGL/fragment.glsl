varying highp vec2 textureCoordinate;

uniform sampler2D textureFrame;

void main() {
    gl_FragColor = texture2D(textureFrame, textureCoordinate);
}
