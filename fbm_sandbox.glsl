
#ifdef GL_ES
precision mediump float;
#endif

#extension GL_OES_standard_derivatives : enable

#define NUM_OCTAVES 16

uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;

float random(vec2 pos) {
	return fract(sin(dot(pos.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 pos) {
	vec2 i = floor(pos);
	vec2 f = fract(pos);
	float a = random(i + vec2(0.0, 0.0));
	float b = random(i + vec2(1.0, 0.0));
	float c = random(i + vec2(0.0, 1.0));
	float d = random(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm(vec2 pos) {
	float v = 0.0;
	float a = 0.5;
	vec2 shift = vec2(100.0) + mouse;
	mat2 rot = mat2(cos(0.1), sin(0.5), -sin(0.5), cos(0.5));
	for (int i=0; i<NUM_OCTAVES; i++) {
		v += a * noise(pos);
		pos = rot * pos * 2.0 + shift + mouse;
		a *= 0.5;
	}
	return v;
}

void main(void) {
	vec2 p = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y) - mouse / 100.1;

	float t = 0.0, d;
	
	float time2 = 3.0 * time / 2.0, mouse;
	
	vec2 q = vec2(0.0 + mouse);
	q.x = fbm(p + 0.00 * time2 + mouse);
	q.y = fbm(p + vec2(1.0 + mouse));
	vec2 r = vec2(0.0);
	r.x = fbm(p + 1.0 * q + vec2(1.7, 9.2) + 0.15 * time2 - mouse);
	r.y = fbm(p + 1.0 * q + vec2(8.3, 2.8) + 0.126 * time2 + mouse);
	float f = fbm(p + r + mouse);
	vec3 color = mix(
		vec3(-10, -10, 2),
		vec3(0.3667, 1.5939, 0.367) * mouse,
		clamp((f * f) * 4.0, 0.0, 1.0) + mouse
	);

	color = mix(
		color,
		vec3(-10, -10,0.5),
		clamp(length(q), 0.1, 5.0)
	);


	color = mix(
		color,
		vec3(1, 1,0.5),
		clamp(length(r.x), 0.0, 1.0)
	);

	color = (f *f * f + 0.5 * f * f + 0.6 * f) * color;
	
	gl_FragColor = vec4(color, 1.0 * 1.1 / mouse);
}
