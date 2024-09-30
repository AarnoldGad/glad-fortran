program gl_glfw
    ! Fortran bindings for GLFW: https://github.com/AarnoldGad/glf90w
    use glf90w
    ! OpenGL core profile generated using: glad --api gl:core=3.3 --out-path . fortran
    use gl

! Required for a few platform-dependent type definitions
#include "glad/types.h"

    implicit none
    type(GLFWwindow) :: window

    if (.not. glfwInit()) stop 'glfwInit()'

    call glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3)
    call glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3)
    call glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)

    window = glfwCreateWindow(800, 600, 'GLF90W Basic App')
    if (.not. associated(window)) stop 'glfwCreateWindow()'

    call glfwMakeContextCurrent(window)

    if (.not. gladLoadGL(glfwGetProcAddress)) stop 'gladLoadGL()'

    do
        call glfwPollEvents()
        call glClearColor(0.28, 0.13, 0.34, 1.0)
        call glClear(GL_COLOR_BUFFER_BIT)
        call glfwSwapBuffers(window)

        if (glfwWindowShouldClose(window)) exit
    end do

    call glfwDestroyWindow(window)
    call glfwTerminate()

end program gl_glfw

