module Main where

import Data.VectorSpace
import Hylogen
import Hylogen.Expr
import SandboxCanvasBoilerplate

main = printGLSLCanvas $ toProgram color

dot :: Vec2 -> Vec2 -> Vec1
dot = op2pre' "dot"

mrandom :: Vec2 -> Vec1
mrandom pos = fract (c * sin dt)
    where
        a = 12.9898
        b = 78.233
        c =  43758.844 --NOTE BE CAREFUL OF TRUNCATION/ROUNDING? TODO LOOK AT THE SHOW INSTANCE
        --c =  43758.5453123
        v = vec2 (a, b)
        dt = dot pos v :: Vec1

noise :: Vec2 -> Vec1
noise pos = mix a b (x_ u) +
            ((c - a) * (y_ u) * (1.0 - x_ u)) +
            ((d - b) * (x_ u) * (y_ u))
    where
        i = floor_ pos :: Vec2
        f = fract pos :: Vec2
        a = mrandom $ (i + vec2 (0.0, 0.0)) :: Vec1
        b = mrandom $ (i + vec2 (1.0, 0.0)) :: Vec1
        c = mrandom $ (i + vec2 (0.0, 1.0))
        d = mrandom $ (i + vec2 (1.0, 1.0))
        u = f * f * (3.0 - (2.0 * f))

--TODO Expose monoToProgram and test these functions indvidiually
fbm :: Int -> Vec2 -> Vec1
fbm num_octaves pos = v
    where
          vinit = 0.0
          a = 0.5
          shift = vec2(100.0, 100.0) :: Vec2
          rot = mat22 ((cos 0.1) , (sin 0.5), (- sin 0.5), (cos 0.5)) :: M22

          fbmOctave (v,pos,a) = (v + (a * noise pos),
                                ((rot *^* pos) * 2.0) + shift,
                                a * 0.5)

          xs = iterate fbmOctave (vinit, pos, a) --I hope this works
          (v, _, _) = xs !! num_octaves

octaves = 16

--NOTE: Be careful of the num and fractional typeclasses forcing Vec n
--TODO: Considering adding scalars to MulR and testing that

color :: Vec4
color = vec4(c4, 1.0)
    where
        minrz = min_ (x_ u_resolution) (y_ u_resolution) :: Vec1
        r_minrz = (1 / minrz)
        p = ((2.0 * xy_ gl_FragCoord) - xy_ u_resolution) * vec2(r_minrz, r_minrz):: Vec2

        u_time2 = 3.0 * u_time / 2.0 :: Vec1

        q = vec2 ( fbm octaves (p), fbm octaves (p + 1.0))

        x = 0.15 * u_time2
        y = 0.126 * u_time2

        r = vec2 (fbm octaves (p + (1.0 * q) + vec2 (1.7, 9.2) + vec2(x,x)),
                  fbm octaves (p + (1.0 * q) + vec2 (8.3, 2.8) + vec2(y,y)))

        f = fbm 16 (p + r)
        --TODO UNLIFT THE CONTENT FOR THIS FUNCTION


        --Ideally vec2 / vec1 should work but the fractional instance forces a -> a -> a
        --Making it expect a vec1 on the right side of the /
        --0.15 * u_time2 is another hiccup due to Num constraining type

        c1 = mix (vec3 (-10, -10, 2))
                 (vec3 (0.3667, 1.5939, 0.367))
                 (clamp ((f*f) * 4.0) 0.0 1.0)

        c2 = mix c1
                 (vec3 (-10, -10, 0.5))
                 (clamp (len q) 0.1 5.0)

        c3 = mix c2
                 (vec3 (1, 1, 0.5))
                 (clamp (len (x_ r)) 0.0 1.0)

        f2 = f * f * f + 0.5 * f * f + 0.6 * f
        --TODO no instance for ToVec3 Vec1???
        c4 = c3 * vec3(f2,f2,f2)
