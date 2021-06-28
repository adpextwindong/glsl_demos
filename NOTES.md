# NOTE ABOUT FIDDLING WITH HYLOGEN LOCALLY

If GHCI gives you any stink after you run cabal v2-install --lib then edit your %appdata%/ghc/.../environments/default file to get rid of multiple Hylogen instances.

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

### FBM Example

The [FBM example](app/fbm.hs) is my first Hylogen example that uses matrix support. Its literally one usage of the *^* operator in the fbm function but it works for now.

Doing this example has shown the rough spots of this DSL. The num and fractional typeclasses railroad you into rewriting expressions because they constrain to Vec n -> Vec n -> Vec n.

This isn't bad when you're multiplying up but diving by a float is annoying.

Another thing to note that I realized is the floating point constants get mangled during compilation. It might be worth assigning constants to uniforms or something honestly. I have to look into this.

----

Further reading

https://www.iquilezles.org/www/material/nvscene2008/rwwtt.pdf

TODO: We need to figure out a good way to compose distance fields and their respective coloring.

[Domain Specific Languages for Small Embedded Systems](https://www.ittc.ku.edu/research/thesis/documents/mark_grebe_thesis.pdf)
