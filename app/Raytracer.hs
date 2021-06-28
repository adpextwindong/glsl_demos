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

iPlane :: Vec3 -> Vec3 -> Vec1
iPlane ro rd = (- y_ ro) / (y_ rd)
-- Equation of a plane, y = 0 = ro.y + t*rd.y
--

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

-- The scene contents are handled here
-- TODO we should have some newtyping around id
intersect :: Vec3 -> Vec3 -> (Vec1, Vec1)
intersect ro rd = (tid, trez)
    where
        (t_sphere, id_sphere) = (iSphere ro rd, 1.0)
        (t_plane, id_plane)  = (iPlane ro rd, 2.0) --TODO handle this better

        id_null = -1.0 --No intersection

        rez_sphere = sel (gt t_sphere 0.0) id_sphere id_null --We should really handle this as a maybe if we can
        rez_plane  = sel (gt t_plane 0.0) id_plane id_null

        tid = sel (eq (max_ rez_sphere rez_plane) id_null)
            --no intersection
                id_null
            --find closest between sphere and plane
                (sel (lt t_plane t_sphere)
                    id_plane
                    id_sphere)

        {-
        trez = sel (eq tid id_null) -1.0
                   (sel (eq tid id_plane) t_plane
                                         t_sphere)
        This doesn't type check and is a pain point of Hylogen so far
        -}
        trez = sel (eq (max_ rez_sphere rez_plane) id_null)
            --no intersection
                id_null
            --find closest between sphere and plane
                (sel (lt t_plane t_sphere)
                    t_plane
                    t_sphere)

        --NOTE: Hylogen's sel can't reason about tuples unfortunately
        --sel :: forall a. ToGLSLType a => Booly -> Expr a -> Expr a -> Expr a


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
        (id, t) = intersect ro rd

        --Draw black by default
        bg_col = vec3(0.0,0.0,0.0)
        white = vec3(1.0,1.0,1.0)
        red = vec3(1.0, 0.0, 0.0)

        pixel_color = sel (eq (-1.0) id) bg_col
                        (sel (eq 1.0 id) white
                            red)

        result = sel (gt 0.0 t) white bg_col
