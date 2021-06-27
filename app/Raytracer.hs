{-# LANGUAGE ScopedTypeVariables #-}
module Raytracer where

--import Hylogen.WithHylide
import Hylogen.Expr

import Hylogen
import SandboxCanvasBoilerplate
uv = (xy_ gl_FragCoord) / (xy_ resolution)
--gl_FragCoord = uniform "gl_FragCoord" :: Vec4
main = printGLSLSandbox output

output = toProgram color

dot :: forall n. (Veccable n) => Vec n -> Vec n -> Vec1
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
          shift = vec2(100.0, 100.0) + mouse :: Vec2
          rot = mat22 ((cos 0.1) , (sin 0.5), (- sin 0.5), (cos 0.5)) :: M22

          fbmOctave (v,pos,a) = (v + (a * noise pos),
                                ((rot *^* pos) * 2.0) + shift + mouse,
                                a * 0.5)

          xs = iterate fbmOctave (vinit, pos, a)
          (v, _, _) = xs !! num_octaves

octaves = 16

--http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/
--https://www.youtube.com/watch?v=9g8CdctxmeU
--http://www.codinglabs.net/article_world_view_projection_matrix.aspx


iSphere :: Vec3 -> Vec3 -> Vec1
iSphere ro rd = result
    where
        r = 1.0
        b = 2.0 * (dot ro rd)
        c = (dot ro ro) - (r * r)
        h = b * b - (4.0 * c) :: Vec1

        result = sel (lt h 0.0) (-1.0) t :: Vec1

        t = (-b - sqrt h) / 2.0
-- A sphere centered at the origin has the equation |xyz| = r
-- meaning, |xyz|^2 = r^2, meaning <xyz, xyz> = r^2
-- now, xyz = ro + t*rd, therefore |ro|^2 + t^2 + 2<ro,rd>t - r^2 = 0
-- which is a quadratic equation so


intersect :: Vec3 -> Vec3 -> Vec1
intersect ro rd = t
    where
        t = iSphere ro rd

color :: Vec4
color = vec4(result, 1.0)
    where
        col = vec3(0.0, 0.0,0.0)

        --Ray Origin
        ro = vec3 (0.0, 1.0, 4.0)
        --Ray Direction
        rd = normalize( vec3( -1.0 + 2.0 * uv, -1.0))
        -- -1.0 + 2.0 * uv
        -- uv goes from 0 to 1 from left to right so we need to have the screen center 0
        -- https://www.shadertoy.com/view/fsBGRc#

        --Intersect the ray with the 3d scene
        id = intersect ro rd

        --Draw black by default
        bg_col = vec3(0.0,0.0,0.0)
        white = vec3(1.0,1.0,1.0)

        result = sel (gt 0.0 bg_col) white bg_col
