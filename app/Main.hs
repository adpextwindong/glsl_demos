module Main where

import Hylogen
import Hylogen.Expr

import SandboxCanvasBoilerplate

main = printGLSLCanvas output
--TODO we need some sort of way to look through the Hylogen AST and replace uniforms

output :: Program
output = toProgram color

color :: Vec4
color = vec4 (a, a, a, 1)
    where
        uvN = xy_ gl_FragCoord - ( 0.5 * xy_ u_resolution) / xy_ u_resolution :: Vec2
        k = 20
        f = (*k) . sin . (/k)
        a = sum [ cos (x_ uvN * f u_time + x_ u_mouse )
                , sin (y_ uvN * f u_time + y_ u_mouse )
                ]

--works for glslsandbox
color2 = vec4 (a, a, a, 1)
    where
        uvN = (xy_ gl_FragCoord - ( 0.5 * xy_ resolution)) / xy_ resolution :: Vec2
        k = 20
        f = (*k) . sin . (/k)
        a = sum [ cos (x_ uvN * f time + x_ mouse )
                , sin (y_ uvN * f time + y_ mouse )
                ]