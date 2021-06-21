module Main where

import Hylogen
import Hylogen.Expr

main = print "Hello world"

output :: Program
output = toProgram color

{-
color :: Vec4
color = vec4 (a, a, a, 1)
    where
        k = 20
        f = (*k) . sin . (/k)
        a = sum [ cos (x_ uvN * f time + x_ mouse )
                , sin (y_ uvN * f time + y_ mouse )
                ]
-}

--works for glsl-canvas
color :: Vec4
color = vec4 (a, a, a, 1)
    where
        uvN = xy_ gl_fragcoord - ( 0.5 * xy_ u_resolution) / xy_ u_resolution :: Vec2
        k = 20
        f = (*k) . sin . (/k)
        a = sum [ cos (x_ uvN * f u_time + x_ u_mouse )
                , sin (y_ uvN * f u_time + y_ u_mouse )
                ]

--works for glslsandbox
color2 = vec4 (a, a, a, 1)
    where
        uvN = (xy_ gl_fragcoord - ( 0.5 * xy_ resolution)) / xy_ resolution :: Vec2
        k = 20
        f = (*k) . sin . (/k)
        a = sum [ cos (x_ uvN * f time + x_ mouse )
                , sin (y_ uvN * f time + y_ mouse )
                ]



--uvN = uniform "uvN" :: Vec2
time = uniform "time" :: Vec1
mouse = uniform "mouse" :: Vec2
resolution = uniform "resolution" :: Vec2
gl_fragcoord = uniform "gl_FragCoord" :: Vec4

--GLSL-canvas helpers
--u_mouse :: Vec2
u_mouse = uniform "u_mouse" :: Vec2
u_time = uniform "u_time" :: Vec1
u_resolution = uniform "u_resolution" :: Vec2
a_position = uniform "a_position" :: Vec4

printGLSLSandbox :: Program -> IO ()
printGLSLSandbox program = do
    putStrLn "#version 100"
    putStrLn "precision mediump float;"
    putStrLn "uniform float time;"
    putStrLn "uniform vec2 resolution;"
    putStrLn "uniform vec2 mouse;"
    putStr $ show program

printGLSLCanvas :: Program -> IO ()
printGLSLCanvas program = do
    putStrLn "#version 100"
    putStrLn "precision mediump float;"
    putStrLn "uniform float u_time;"
    putStrLn "uniform vec2 u_resolution;"
    putStrLn "uniform vec2 u_mouse;"
    putStrLn "vec4 a_position;"
    putStr $ show program
