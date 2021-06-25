module Main where

import Hylogen
import Hylogen.Expr

import SandboxCanvasBoilerplate

main = printGLSLCanvas output
--TODO we need some sort of way to look through the Hylogen AST and replace uniforms

output :: Program
output = toProgram color

num_lines = 10

color :: Vec4
color = vec4 (destColor * destForm, 1.0)
    where
        position = (((xy_ gl_FragCoord) * 2.0) - resolution) / (vec2 (rhs, rhs))
        rhs = (min_ (x_ resolution) (y_ resolution))
        destColor = vec3(0.0, 0.25, 1.0)

        destFormIter (destForm, ypos, i) = (destForm + vec3 (l,l,l), q, i + 1)
            where
                j = i + 0.0
                ypos_update = (sin ((x_ position) * 2.0 + time * 1.2 * (cos (j * 1.314)) * 0.05))
                q = ypos + ypos_update
                l = 0.0035 / abs q
        xs = iterate destFormIter (vec3 (0.0,0.0,0.0), y_ position, 0.0)
        (destForm, _, _) = xs !! num_lines
