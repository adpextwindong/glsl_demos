#version 100
precision mediump float;
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
vec4 a_position;
void main() {
    vec2 _11 = gl_FragCoord.xy;
    vec2 _12 = u_resolution.xy;
    vec2 _10 = (_11 / _12);
    float _9 = _10.x;
    float _14 = (u_time / 15.0);
    float _13 = cos(_14);
    float _8 = (_9 * _13);
    float _7 = (_8 * 80.0);
    float _6 = sin(_7);
    float _18 = _10.y;
    float _20 = (u_time / 15.0);
    float _19 = cos(_20);
    float _17 = (_18 * _19);
    float _16 = (_17 * 10.0);
    float _15 = cos(_16);
    float _5 = (_6 + _15);
    float _25 = _10.y;
    float _27 = (u_time / 10.0);
    float _26 = sin(_27);
    float _24 = (_25 * _26);
    float _23 = (_24 * 40.0);
    float _22 = sin(_23);
    float _31 = _10.x;
    float _33 = (u_time / 25.0);
    float _32 = sin(_33);
    float _30 = (_31 * _32);
    float _29 = (_30 * 40.0);
    float _28 = cos(_29);
    float _21 = (_22 + _28);
    float _4 = (_5 + _21);
    float _38 = _10.x;
    float _40 = (u_time / 5.0);
    float _39 = sin(_40);
    float _37 = (_38 * _39);
    float _36 = (_37 * 10.0);
    float _35 = sin(_36);
    float _44 = _10.y;
    float _46 = (u_time / 35.0);
    float _45 = sin(_46);
    float _43 = (_44 * _45);
    float _42 = (_43 * 80.0);
    float _41 = sin(_42);
    float _34 = (_35 + _41);
    float _3 = (_4 + _34);
    float _49 = (u_time / 10.0);
    float _48 = sin(_49);
    float _47 = (0.5 * _48);
    float _2 = (_3 + _47);
    float _50 = (0.5 * _2);
    float _54 = (u_time / 3.0);
    float _53 = (_2 + _54);
    float _52 = cos(_53);
    float _51 = (_52 * 0.75);
    vec4 _1 = vec4(_2, _50, _51, 1.0);

    gl_FragColor = _1;
}
