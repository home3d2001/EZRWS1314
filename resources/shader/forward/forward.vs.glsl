//VERTEX SHADER
#version 440 core

//*** Uniform block definitions ************************************************

//*** Input ********************************************************************
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 uv;

//*** Output *******************************************************************
out vec3 wsPosition;
out vec3 vsPosition;
out vec3 wsNormal;
out vec3 vsNormal;
out vec2 vsUV;

//*** Uniforms *****************************************************************
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform sampler2D displace;
uniform bool tesselation;

//*** Main *********************************************************************
void main(void)
{   
	wsPosition = position.xyz;
	vsPosition = vec3( model * vec4(position, 1.0) );
	vsNormal = vec3( normalize(transpose(inverse(model * view)) * vec4(normal, 0.0)) );
	vsUV = uv;

	// Tesseltation
	wsPosition = vec3(model * vec4(position, 1.0));
    vsUV = uv;
    wsNormal = vec3( transpose( inverse(model) ) * vec4(normal, 0.0));

	gl_Position = projection * view * model * vec4(position, 1.0);
}