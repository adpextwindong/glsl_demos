module SandboxCanvasBoilerplate where

import Hylogen
import Hylogen.Expr

--BOILER PLATE
--uvN = uniform "uvN" :: Vec2
time = uniform "time" :: Vec1
mouse = uniform "mouse" :: Vec2
resolution = uniform "resolution" :: Vec2
gl_FragCoord = uniform "gl_FragCoord" :: Vec4
sandbox_uvN = xy_ gl_FragCoord - ( 0.5 * xy_ resolution) / xy_ resolution :: Vec2

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
