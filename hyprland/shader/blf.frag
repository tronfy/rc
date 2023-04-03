// blue light filter

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
  vec4 pixColor = texture2D(tex, v_texcoord);

  pixColor[1] *= 0.9;
  pixColor[2] *= 0.8;

  gl_FragColor = pixColor;
}
