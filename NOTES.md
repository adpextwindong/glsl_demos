example.glsl from http://glslsandbox.com/e#73520.2

## 6/25/21
Lines.hs from http://glslsandbox.com/e#73582.0

```glsl
uniform vec2 resolution;
vec2 position = (gl_FragCoord.xy * 2.0 - resolution) / min(resolution.x, resolution.y);
```

Heres a simple example from the Lines sandbox that is hard to deal with when porting.

```
((gl_FragCoord.xy * 2.0) - resolution)
(gl_FragCoord.xy * (2.0 - resolutuion)) //Does not typecheck
```

While it obviously doesn't typecheck if you keep the type of resolution in mind, its a different story when you're reading a line that tons of paren-less operations floating about.

It might be reasonable to use a parser to parse this code and spit out a version with parens everywhere.

### Lines example

http://glslsandbox.com/e#73601.0

The current port of this [Lines.hs](app/Lines.hs) nearly works. The math for the lines doesn't add up correctly but at least draws somewhat like it should.

http://glslsandbox.com/e#73601.0

Heres what it looks like on GLSLSandbox at least
