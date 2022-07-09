// -*- mode: c -*-

// adapted from: https://github.com/yshui/picom/wiki/Shader-Shop
// Changes the behavior of inverting color to preserve the hue
// In other words, the invert flag will now only invert the 
// lightness value. This helps preserve the look of pictures and
// things while keeping the high contrast look.

uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;

// adapted from: https://gist.github.com/mairod/a75e7b44f68110e1576d77419d608786
vec3 hue_shift(vec3 color, float hue) {
    const vec3 k = vec3(0.57735, 0.57735, 0.57735);
    return vec3(color * cos(hue) + cross(k, color) * sin(hue) + k * dot(k, color) * (1.0 - cos(hue)));
}

void main() {
    vec4 c = texture2D(tex, gl_TexCoord[0].xy);
    
    if (invert_color) {
        // min / max values for lightness
        // softens the high contrast look
        float vmax = 0.8;
        float vmin = 0.1;

        c.xyz = (vmin - vmax) * c.xyz + vmax;    // inversion: linear map of lightness
        c.xyz = hue_shift(c.xyz, radians(180.)); // correct for hue shift due to the inversion
    }

    c *= opacity;
    gl_FragColor = vec4(c);
}
