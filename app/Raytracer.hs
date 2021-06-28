{-# LANGUAGE ScopedTypeVariables #-}
module Raytracer where

--import Hylogen.WithHylide
import Hylogen.Expr

import Hylogen
import SandboxCanvasBoilerplate

uv = (xy_ gl_FragCoord) / (xy_ resolution)
--gl_FragCoord = uniform "gl_FragCoord" :: Vec4
--main = printGLSLSandbox output

output = toProgram color

dot :: forall n. (Veccable n) => Vec n -> Vec n -> Vec1
dot = op2pre' "dot"

-- http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/
-- https://www.youtube.com/watch?v=9g8CdctxmeU
-- http://www.codinglabs.net/article_world_view_projection_matrix.aspx

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
        ro = vec3 (0.0, 0.0, 5.0)
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

        result = sel (gt 0.0 id) white bg_col
