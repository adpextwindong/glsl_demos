-- Fork of http://glslsandbox.com/e#73452.0
module Main where

import SandboxCanvasBoilerplate

import Hylogen
import Hylogen.Expr

main = printGLSLCanvas $ toProgram color

--color = vec4 (0.0 0.0 0.0 0.0)
color = vec4 (c, 0.5 * c, cos ( c + u_time / 3.0 ) * 0.75, 1.0)
    where
        pos = (xy_ gl_FragCoord / xy_ u_resolution )
        p1 = sin (x_ pos * cos (u_time / 15.0) * 80.0) + cos (y_ pos * cos ( u_time / 15.0 ) * 10.0) :: Vec1
        p2 = sin (y_ pos * sin (u_time / 10.0 ) * 40.0) + cos ( x_ pos * sin ( u_time / 25.0) * 40.0)
        p3 = sin (x_ pos * sin ( u_time / 5.0 ) * 10.0 ) + sin (y_ pos * sin( u_time / 35.0) * 80.0)
        p4 = 0.5 * (sin $ u_time / 10.0)
        c = p1 + p2 + p3 + p4
