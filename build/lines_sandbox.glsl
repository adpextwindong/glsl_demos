#version 100
precision mediump float;
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
void main() {
    vec3 _3 = vec3(0.0, 0.25, 1.0);
    vec3 _14 = vec3(0.0, 0.0, 0.0);
    vec2 _23 = gl_FragCoord.xy;
    vec2 _24 = vec2(2.0, 2.0);
    vec2 _22 = (_23 * _24);
    vec2 _21 = (_22 - resolution);
    float _27 = resolution.x;
    float _28 = resolution.y;
    float _26 = min(_27, _28);
    vec2 _25 = vec2(_26, _26);
    vec2 _20 = (_21 / _25);
    float _19 = _20.y;
    float _33 = _20.x;
    float _32 = (_33 * 2.0);
    float _35 = (time * 1.2);
    float _37 = (0.0 * 1.314);
    float _36 = cos(_37);
    float _34 = (_35 * _36);
    float _31 = (_32 + _34);
    float _30 = sin(_31);
    float _29 = (5.0e-2 * _30);
    float _18 = (_19 + _29);
    float _17 = abs(_18);
    float _16 = (3.5e-3 / _17);
    vec3 _15 = vec3(_16, _16, _16);
    vec3 _13 = (_14 + _15);
    float _46 = _20.x;
    float _45 = (_46 * 2.0);
    float _48 = (time * 1.2);
    float _51 = (0.0 + 1.0);
    float _50 = (_51 * 1.314);
    float _49 = cos(_50);
    float _47 = (_48 * _49);
    float _44 = (_45 + _47);
    float _43 = sin(_44);
    float _42 = (5.0e-2 * _43);
    float _41 = (_18 + _42);
    float _40 = abs(_41);
    float _39 = (3.5e-3 / _40);
    vec3 _38 = vec3(_39, _39, _39);
    vec3 _12 = (_13 + _38);
    float _60 = _20.x;
    float _59 = (_60 * 2.0);
    float _62 = (time * 1.2);
    float _65 = (_51 + 1.0);
    float _64 = (_65 * 1.314);
    float _63 = cos(_64);
    float _61 = (_62 * _63);
    float _58 = (_59 + _61);
    float _57 = sin(_58);
    float _56 = (5.0e-2 * _57);
    float _55 = (_41 + _56);
    float _54 = abs(_55);
    float _53 = (3.5e-3 / _54);
    vec3 _52 = vec3(_53, _53, _53);
    vec3 _11 = (_12 + _52);
    float _74 = _20.x;
    float _73 = (_74 * 2.0);
    float _76 = (time * 1.2);
    float _79 = (_65 + 1.0);
    float _78 = (_79 * 1.314);
    float _77 = cos(_78);
    float _75 = (_76 * _77);
    float _72 = (_73 + _75);
    float _71 = sin(_72);
    float _70 = (5.0e-2 * _71);
    float _69 = (_55 + _70);
    float _68 = abs(_69);
    float _67 = (3.5e-3 / _68);
    vec3 _66 = vec3(_67, _67, _67);
    vec3 _10 = (_11 + _66);
    float _88 = _20.x;
    float _87 = (_88 * 2.0);
    float _90 = (time * 1.2);
    float _93 = (_79 + 1.0);
    float _92 = (_93 * 1.314);
    float _91 = cos(_92);
    float _89 = (_90 * _91);
    float _86 = (_87 + _89);
    float _85 = sin(_86);
    float _84 = (5.0e-2 * _85);
    float _83 = (_69 + _84);
    float _82 = abs(_83);
    float _81 = (3.5e-3 / _82);
    vec3 _80 = vec3(_81, _81, _81);
    vec3 _9 = (_10 + _80);
    float _102 = _20.x;
    float _101 = (_102 * 2.0);
    float _104 = (time * 1.2);
    float _107 = (_93 + 1.0);
    float _106 = (_107 * 1.314);
    float _105 = cos(_106);
    float _103 = (_104 * _105);
    float _100 = (_101 + _103);
    float _99 = sin(_100);
    float _98 = (5.0e-2 * _99);
    float _97 = (_83 + _98);
    float _96 = abs(_97);
    float _95 = (3.5e-3 / _96);
    vec3 _94 = vec3(_95, _95, _95);
    vec3 _8 = (_9 + _94);
    float _116 = _20.x;
    float _115 = (_116 * 2.0);
    float _118 = (time * 1.2);
    float _121 = (_107 + 1.0);
    float _120 = (_121 * 1.314);
    float _119 = cos(_120);
    float _117 = (_118 * _119);
    float _114 = (_115 + _117);
    float _113 = sin(_114);
    float _112 = (5.0e-2 * _113);
    float _111 = (_97 + _112);
    float _110 = abs(_111);
    float _109 = (3.5e-3 / _110);
    vec3 _108 = vec3(_109, _109, _109);
    vec3 _7 = (_8 + _108);
    float _130 = _20.x;
    float _129 = (_130 * 2.0);
    float _132 = (time * 1.2);
    float _135 = (_121 + 1.0);
    float _134 = (_135 * 1.314);
    float _133 = cos(_134);
    float _131 = (_132 * _133);
    float _128 = (_129 + _131);
    float _127 = sin(_128);
    float _126 = (5.0e-2 * _127);
    float _125 = (_111 + _126);
    float _124 = abs(_125);
    float _123 = (3.5e-3 / _124);
    vec3 _122 = vec3(_123, _123, _123);
    vec3 _6 = (_7 + _122);
    float _144 = _20.x;
    float _143 = (_144 * 2.0);
    float _146 = (time * 1.2);
    float _149 = (_135 + 1.0);
    float _148 = (_149 * 1.314);
    float _147 = cos(_148);
    float _145 = (_146 * _147);
    float _142 = (_143 + _145);
    float _141 = sin(_142);
    float _140 = (5.0e-2 * _141);
    float _139 = (_125 + _140);
    float _138 = abs(_139);
    float _137 = (3.5e-3 / _138);
    vec3 _136 = vec3(_137, _137, _137);
    vec3 _5 = (_6 + _136);
    float _158 = _20.x;
    float _157 = (_158 * 2.0);
    float _160 = (time * 1.2);
    float _163 = (_149 + 1.0);
    float _162 = (_163 * 1.314);
    float _161 = cos(_162);
    float _159 = (_160 * _161);
    float _156 = (_157 + _159);
    float _155 = sin(_156);
    float _154 = (5.0e-2 * _155);
    float _153 = (_139 + _154);
    float _152 = abs(_153);
    float _151 = (3.5e-3 / _152);
    vec3 _150 = vec3(_151, _151, _151);
    vec3 _4 = (_5 + _150);
    vec3 _2 = (_3 * _4);
    vec4 _1 = vec4(_2, 1.0);

    gl_FragColor = _1;
}