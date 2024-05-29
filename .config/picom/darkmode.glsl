// -*- mode: c -*-

// adapted from: https://github.com/yshui/picom/wiki/Shader-Shop
// Changes the behavior of inverting color to preserve the hue
// In other words, the invert flag will now only invert the
// lightness value. This helps preserve the look of pictures and
// things while keeping the high contrast look.

#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform bool invert_color;
uniform float opacity;

// adapted from: https://gist.github.com/mairod/a75e7b44f68110e1576d77419d608786
vec3 hue_shift(vec3 color, float hue) {
    const vec3 k = vec3(0.57735, 0.57735, 0.57735);
    return vec3(color * cos(hue) + cross(k, color) * sin(hue) + k * dot(k, color) * (1.0 - cos(hue)));
}

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord/texsize, 0);

    if (invert_color) {
        // min / max values for lightness
        // softens the high contrast look
        float rmax = 228.0/255;
        float gmax = 228.0/255;
        float bmax = 228.0/255;

        float rmin = 41.0/255;
        float gmin = 45.0/255;
        float bmin = 62.0/255;

        // correct for hue shift due to the inversion
        // apply first so original colors wont be distorted due to custom map
        c.xyz = hue_shift(c.xyz, radians(180.));

        // inversion: linear color map
        c.r = (rmin - rmax) * c.r + rmax;
        c.g = (gmin - gmax) * c.g + gmax;
        c.b = (bmin - bmax) * c.b + bmax;
    }

    c *= opacity;
    return c;
}
