#version 100
precision mediump float;
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

vec4 a_position;

void main() {
    vec2 _10 = gl_FragColor.xy;
    vec2 _12 = vec2(0.5, 0.5);
    vec2 _11 = (_12 * u_resolution);
    vec2 _9 = (_10 - _11);
    //vec2 _8 = (_9 / u_resolution);
    vec2 _8 = gl_FragCoord.xy - (0.5 * u_resolution.xy) / u_resolution.xy;

    float _7 = _8.x;
    float _15 = (u_time / 20.0);
    float _14 = sin(_15);
    float _13 = (_14 * 20.0);
    float _6 = (_7 * _13);
    float _16 = u_mouse.x;
    float _5 = (_6 + _16);
    float _4 = cos(_5);
    float _3 = (0.0 + _4);
    float _20 = _8.y;
    float _23 = (u_time / 20.0);
    float _22 = sin(_23);
    float _21 = (_22 * 20.0);
    float _19 = (_20 * _21);
    float _24 = u_mouse.y;
    float _18 = (_19 + _24);
    float _17 = sin(_18);
    float _2 = (_3 + _17);
    vec4 _1 = vec4(_2, _2, _2, 1.0);

    gl_FragColor = _1;
}