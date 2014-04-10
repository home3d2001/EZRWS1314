#version 440

//--- Input --------------------------------------------------------------------
layout(triangles, equal_spacing, cw) in;
in vec3 tcPosition[];

//--- Output -------------------------------------------------------------------
out vec3 tePosition;
out vec3 tePatchDistance;

//--- Uniforms -----------------------------------------------------------------
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
    vec3 p0 = gl_TessCoord.x * tcPosition[0];
    vec3 p1 = gl_TessCoord.y * tcPosition[1];
    vec3 p2 = gl_TessCoord.z * tcPosition[2];
    tePatchDistance = gl_TessCoord;
    tePosition = normalize(p0 + p1 + p2);
    gl_Position = projection * view * model * vec4(tePosition, 1);
}