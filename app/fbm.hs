module Main where

import Data.VectorSpace
import Hylogen
import Hylogen.Expr
import SandboxCanvasBoilerplate

main = printGLSLSandbox $ toProgram color

dot :: Vec2 -> Vec2 -> Vec1
dot = op2pre' "dot"

mrandom :: Vec2 -> Vec1
mrandom pos = sin (dot (xy_ pos) (vec2 (12.9898, 78.233))) * 43758.8453123

noise :: Vec2 -> Vec1
noise pos = (mix (x_ u) a b) + (c - a) * (y_ u) * (1.0 - x_ u) + (d - b) * (x_ u) * (y_ u)
    where
        i = floor_ pos
        f = fract pos
        a = mrandom $ i + vec2 (0.0, 0.0)
        b = mrandom $ i + vec2 (1.0, 0.0)
        c = mrandom $ i + vec2 (0.0, 1.0)
        d = mrandom $ i + vec2 (1.0, 1.0)
        u = f * f * (3.0 - 2.0 * f)

--TODO Expose monoToProgram and test these functions indvidiually
fbm :: Int -> Vec2 -> Vec1
fbm num_octaves pos = v
    where a = 0.5
          vinit = 0.5
          shift = vec2(100.0, 100.0) + mouse :: Vec2
          rot = mat22 ((cos 0.1) , (sin 0.5), (- sin 0.5), (cos 0.5)) :: M22
          fbmOctave (v,pos,a) = (v + a * noise pos, ((rot *^* pos) * 2.0) + shift + mouse, a * 0.5)
          xs = iterate fbmOctave (vinit, pos, a) --I hope this works
          (v, _, _) = xs !! num_octaves

octaves = 16

--NOTE: Be careful of the num and fractional typeclasses forcing Vec n
--TODO: Considering adding scalars to MulR and testing that
p = ((2.0 * xy_ gl_FragCoord) - xy_ resolution) * vec2(r_minrz, r_minrz):: Vec2
minrz = min_ (x_ resolution) (y_ resolution) :: Vec1
r_minrz = (1 / minrz)
time2 = 3.0 * time / 2.0 :: Vec1
q = vec2 ( fbm octaves p, fbm octaves (p + 1.0))

r = vec2 ( fbm octaves (p + 1.0 * q + vec2 (8.3, 2.8) + vec2 (0.15 * time2, 0.15 * time2)),
       ( fbm octaves (p + 1.0 * q + vec2 (8.3, 2.8) + vec2 (0.126 * time2, 0.126 * time2))))

f = fbm 16 (p + r)
--TODO UNLIFT THE CONTENT FOR THIS FUNCTION
color :: Vec4
--color = vec4 (x_ end_color, y_ end_color, z_ end_color, 1.0)
color = vec4 (noise (p + 1.0),
             (noise (p + 1.0 * q + vec2 (8.3, 2.8) + vec2 (0.15 * time2, 0.15 * time2))),
             (noise (p + 1.0 * q + vec2 (8.3, 2.8) + vec2 (0.126 * time2, 0.126 * time2))),
               1.0)

--Ideally vec2 / vec1 should work but the fractional instance forces a -> a -> a
--Making it expect a vec1 on the right side of the /
--0.15 * time2 is another hiccup due to Num constraining type


t1 = clamp ((f * f) * 4.0) (0.0 :: Vec1) (1.0 :: Vec1)
c1 = mix t1 (vec3 (-10, -10, 2)) (vec3 (0.3667, 15939, 0.367) * (vec3 (x_ mouse, y_ mouse, 1.0)))

t2 = clamp (len q) 0.1 5.0
c2 = mix t2 (vec3 (-10, -10, 0.5)) c1
--TODO double check mix ordering of arguments compared to original

t3 = clamp (len (x_ r)) 0.0 1.0
c3 = mix t3 (vec3 (1, 1, 0.5)) c2

fbunch = (f * f * f + 0.5 *f * f + 0.6 * f)
end_color = vec3 (fbunch, fbunch, fbunch) * c3 --TODO fix this last bit
