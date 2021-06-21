precision mediump float;

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main() {

	vec2 uvN = (gl_FragCoord.xy - 0.5*u_resolution.xy)/ u_resolution.xy;
    float _7 = uvN.x;
    float _10 = (u_time / 20.0);
    float _9 = sin(_10);
    float _8 = (_9 * 20.0);
    float _6 = (_7 * _8);
    float _11 = u_mouse.x;
    float _5 = (_6 + _11);
    float _4 = cos(_5);
    float _3 = (0.0 + _4);
    float _15 = uvN.y;
    float _18 = (u_time / 20.0);
    float _17 = sin(_18);
    float _16 = (_17 * 20.0);
    float _14 = (_15 * _16);
    float _19 = u_mouse.y;
    float _13 = (_14 + _19);
    float _12 = sin(_13);
    float _2 = (_3 + _12);
    vec4 _1 = vec4(_2, _2, _2, 1.0);

    gl_FragColor = _1;
}
