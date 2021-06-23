module Main where

import Prelude hiding (floor)

import Hylogen
import Hylogen.Expr
import SandboxCanvasBoilerplate

main = printGLSLSandbox $ toProgram color

color :: Vec4
color = vec4 (0,0,0,0)

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
