#include "RadialGlowMaskPass.h"


RadialGlowMaskPass::RadialGlowMaskPass(SlimQuad* pQuad, int pWidth, int pHeight)
: ISlimRenderPass(pQuad)
{
	quad = pQuad;
	width = pWidth;
	height = pHeight;
	renderPassShader = new SlimShader(RESOURCES_PATH "/shader_source/", "post.vert.glsl", "separatedBlur.frag.glsl");

	colorUniform = glGetUniformLocation(renderPassShader->shaderProgram, "color");

	horizontalUniform = glGetUniformLocation(renderPassShader->shaderProgram, "horizontal");
	glowRangeUniform = glGetUniformLocation(renderPassShader->shaderProgram, "range");
	glowBrightnessUniform = glGetUniformLocation(renderPassShader->shaderProgram, "brightness");
	glowThreshholdUniform = glGetUniformLocation(renderPassShader->shaderProgram, "thresh");
	screenSizeUniform = glGetUniformLocation(renderPassShader->shaderProgram, "screenSize");



	//params
	param_glowRange = 5.0;
	param_glowThreshhold = 0.7;
	param_glowHorizontal = 1.0;
	param_glowBrightness = 1.0;
}


RadialGlowMaskPass::~RadialGlowMaskPass() {
	delete renderPassShader;
}

void RadialGlowMaskPass::doExecute() {

	outputFBO->write();
		renderPassShader->enable();

			glActiveTexture(GL_TEXTURE0);
			glBindTexture(GL_TEXTURE_2D, inputFBOs[0]->texPointer[0]);
			glUniform1i(colorUniform, 0);

			glUniform1f(glowBrightnessUniform, param_glowBrightness);
			glUniform1f(glowRangeUniform, param_glowRange);
			glUniform1f(glowThreshholdUniform, param_glowThreshhold);
			glUniform1f(horizontalUniform, param_glowHorizontal);
			glUniform2i(screenSizeUniform, (GLint)width, (GLint)height);

			glViewport(0, 0, width, height);
			quad->draw();

		renderPassShader->disable();
	outputFBO->unbind();
	glViewport(0, 0, width*4, height*4);
}

