//! @file Context.h
#pragma once

#include "../utils/Common.h"

namespace tone {
	namespace renderer {
		class Context
		{
			public:
				Context(const glm::ivec2& size);
				~Context();

				void swapBuffers(void);
				bool isLive(void);
				glm::ivec2 getSize(void);
				GLFWwindow* getWindow(void);

			protected:
				void init(void);

			private:
				GLFWwindow* m_window;
				glm::ivec2 m_size;
				std::string m_title;
		};
	}
}
