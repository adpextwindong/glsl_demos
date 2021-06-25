module Main where

import Hylogen
import Hylogen.Expr

import SandboxCanvasBoilerplate


toTestFunction = monoToProgram . toMono

position = (((xy_ gl_FragCoord) * 2.0) - resolution) / (vec2 (mrez, mrez))
mrez = (min_ (x_ resolution) (y_ resolution))
destColor = vec3(0.0, 0.25, 1.0)

-- ORIGINAL REFERENCE: http://glslsandbox.com/e#73582.0
main = printGLSLSandbox output
--TODO we need some sort of way to look through the Hylogen AST and replace uniforms

output :: Program
output = toProgram color

num_lines = 10

color :: Vec4
color = vec4 (destColor * destForm, 1.0)
    where
        xs = iterate destFormIter (vec3 (0.0,0.0,0.0), y_ position, 0.0)
        destFormIter (destForm, ypos, i) = (destForm + vec3 (l,l,l), q, i + 1)
            where
                q = ypos + ( 0.05 * (sin ((x_ position) * 2.0 + time * 1.2 * (cos (i * 1.314)))))
                l = 0.0035 / (abs q)

        (destForm, _, _) = xs !! num_lines
