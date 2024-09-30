# glad-fortran

&nbsp;&nbsp; *"I think you underestimated the problem..."*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *"That's what I do... And then I figure out."*

---

## Description

Fortran generator extension for [glad2](https://github.com/Dav1dde/glad).

It can currently only generate interfaces for OpenGL, but support for other specifications is coming soon.
The generated fortran code requires at least Fortran 2018 and a preprocessor to compile.

## Examples

```fortran
program gl_glfw
    ! Fortran bindings for GLFW: https://github.com/AarnoldGad/glf90w
    use glf90w
    ! OpenGL core profile generated using: glad --api gl:core=3.3 --out-path . fortran
    use gl

! Required for a few platform-dependent type definitions
#include "glad/types.h"

    implicit none
    ! ...

    window = glfwCreateWindow(800, 600, 'GLF90W Basic App')
    call glfwMakeContextCurrent(window)

    if (.not. gladLoadGL(glfwGetProcAddress)) stop 'Failed to initialise OpenGL context!'

    ! ...

end program gl_glfw
```

Full example can be found in [gl\_glfw.F90](./examples/gl_glfw.F90).

## Credits

- [Gaétan J.A.M. Jalin](https://github.com/AarnoldGad): Author of [glad-fortran](https://github.com/AarnoldGad/glad-fortran)
- [David Herberth](https://github.com/Dav1dde): Author of [glad](https://github.com/Dav1dde/glad)

## License

See [LICENSE](/LICENSE).
cf. [glad](https://github.com/Dav1dde/glad) for details on the license of the generated code.

