module Main where

import Prelude hiding (floor)

import Hylogen
import Hylogen.Expr
import SandboxCanvasBoilerplate

main = printGLSLSandbox $ toProgram color

dot :: Vec2 -> Vec2 -> Vec1
dot = op2pre' "dot"

floor = op1pre'' "floor"

mrandom :: Vec2 -> Vec1
mrandom pos = sin (dot (xy_ pos) (vec2 (12.9898, 78.233))) * 43758.8453123

noise :: Vec2 -> Vec1
noise pos = (mix (x_ u) a b) + (c - a) * (y_ u) * (1.0 - x_ u) + (d - b) * (x_ u) * (y_ u)
    where
        i = floor pos
        f = fract pos
        a = mrandom $ i + vec2 (0.0, 0.0)
        b = mrandom $ i + vec2 (1.0, 0.0)
        c = mrandom $ i + vec2 (0.0, 1.0)
        d = mrandom $ i + vec2 (1.0, 1.0)
        u = f * f * (3.0 - 2.0 * f)

--TODO Expose monoToProgram and test these functions indvidiually
fbm :: Vec2 -> Int -> Vec1
fbm pos num_octaves = v
    where a = 0.5
          vinit = 0.5
          shift = vec2(100.0, 100.0) + mouse
          rot = mat22 ((cos 0.1) , (sin 0.5), (- sin 0.5), (cos 0.5))
          fbmOctave (v,pos,a) = (v + a * noise pos, mul rot (pos * 2.0 + shift + mouse), a * 0.5)
          xs = iterate fbmOctave (vinit, pos, a)
          (v, _, _) = xs !! num_octaves


color :: Vec4
color = undefined --TODO!!
