//VERTEX SHADER
#version 400

//*** Uniform block definitions ************************************************

//*** Input ********************************************************************
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 uv;

//*** Output *******************************************************************
out vec3 vsNormal;
out vec2 vsUV;

//*** Uniforms *****************************************************************
uniform mat4 model; // set
uniform mat4 view; // set
uniform mat4 modelview; // set
uniform mat4 projection; // set
uniform mat3 normalmatrix; // set
uniform mat4 mvp; // set

//*** Functions ****************************************************************


//*** Main *********************************************************************
void main(void)
{
//     vsNormal = vec3(normalize(transpose(inverse(model * view)) *
//                    vec4(normal, 0.0)));

//     passing uv coordinates to fragment shader
    vsUV = uv;

    gl_Position = mvp * vec4(position, 1.0);
}