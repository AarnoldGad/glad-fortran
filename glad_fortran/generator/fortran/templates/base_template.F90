! -----------------
! Loader generated by glad {{ gen_info.version }} on {{ gen_info.when }}
!
! SPDX-License-Identifier: (WTFPL OR CC0-1.0) AND Apache-2.0
!
! Generator: {{ gen_info.generator_name }}
! Specification: {{ gen_info.specification }}
! Extensions: {{ gen_info.extensions|length }}
!
! APIs:
{% for info in gen_info.info %}
!  - {{ info }}
{% endfor %}
!
! Options:
{% for name, value in gen_info.options.items() %}
!  - {{ name }} = {{ value }}
{% endfor %}
!
! Commandline:
!    {{ gen_info.commandline }}
!
! Online:
!    {{ gen_info.online }}
!
! -----------------

module gl
    use, intrinsic :: iso_c_binding

    implicit none
    public
    save

    ! -------------
    ! Kinds
    ! -------------

    integer, parameter :: GLbyte = c_signed_char
    integer, parameter :: GLubyte = c_signed_char
    integer, parameter :: GLchar = c_char
    integer, parameter :: GLcharARB = c_char
    integer, parameter :: GLboolean = c_signed_char

    integer, parameter :: GLshort = c_short
    integer, parameter :: GLushort = c_short

    integer, parameter :: GLint = c_int
    integer, parameter :: GLuint = c_int
    integer, parameter :: GLint64 = c_int64_t
    integer, parameter :: GLuint64 = c_int64_t
    integer, parameter :: GLint64EXT = c_int64_t
    integer, parameter :: GLuint64EXT = c_int64_t

    integer, parameter :: GLintptr = c_intptr_t
    integer, parameter :: GLsizeiptr = c_size_t
    integer, parameter :: GLintptrARB = c_intptr_t
    integer, parameter :: GLsizeiptrARB = c_size_t

    integer, parameter :: GLsizei = GLint
    integer, parameter :: GLclampx = c_int
    integer, parameter :: GLfixed = GLint
    integer, parameter :: GLhalf = c_short
    integer, parameter :: GLhalfNV = c_short
    integer, parameter :: GLhalfARB = c_short

    integer, parameter :: GLenum = c_int
    integer, parameter :: GLbitfield = c_int

    integer, parameter :: GLfloat = c_float
    integer, parameter :: GLdouble = c_double
    integer, parameter :: GLclampf = c_float
    integer, parameter :: GLclampd = c_double

    integer, parameter :: GLvdpauSurfaceNV = GLintptr

#include "glad/types.h"

    abstract interface
        subroutine GLDEBUGPROC(source, type, id, severity, length, message, userParam) bind(C)
            import
            implicit none
            integer(kind=GLenum), value :: source
            integer(kind=GLenum), value :: type
            integer(kind=GLuint), value :: id
            integer(kind=GLenum), value :: severity
            integer(kind=GLsizei), value :: length
            character(len=1,kind=GLchar), dimension(*) :: message
            type(c_ptr), value :: userParam
        end subroutine GLDEBUGPROC

        subroutine GLDEBUGPROCARB(source, type, id, severity, length, message, userParam) bind(C)
            import
            implicit none
            integer(kind=GLenum), value :: source
            integer(kind=GLenum), value :: type
            integer(kind=GLuint), value :: id
            integer(kind=GLenum), value :: severity
            integer(kind=GLsizei), value :: length
            character(len=1,kind=GLchar), dimension(*) :: message
            type(c_ptr), value :: userParam
        end subroutine GLDEBUGPROCARB

        subroutine GLDEBUGPROCKHR(source, type, id, severity, length, message, userParam) bind(C)
            import
            implicit none
            integer(kind=GLenum), value :: source
            integer(kind=GLenum), value :: type
            integer(kind=GLuint), value :: id
            integer(kind=GLenum), value :: severity
            integer(kind=GLsizei), value :: length
            character(len=1,kind=GLchar), dimension(*) :: message
            type(c_ptr), value :: userParam
        end subroutine GLDEBUGPROCKHR

        subroutine GLDEBUGPROCAMD(source, type, id, severity, length, message, userParam) bind(C)
            import
            implicit none
            integer(kind=GLenum), value :: source
            integer(kind=GLenum), value :: type
            integer(kind=GLuint), value :: id
            integer(kind=GLenum), value :: severity
            integer(kind=GLsizei), value :: length
            character(len=1,kind=GLchar), dimension(*) :: message
            type(c_ptr), value :: userParam
        end subroutine GLDEBUGPROCAMD

        subroutine GLVULKANPROCNV() bind(C)
        end subroutine GLVULKANPROCNV
    end interface

    abstract interface
        function GLADloadfunc(name) result(procaddr)
            use, intrinsic :: iso_c_binding
            implicit none
            character(len=*, kind=c_char), intent(in) :: name
            type(c_funptr) :: procaddr
        end function GLADloadfunc
    end interface

    ! -------------
    ! Enumerations
    ! -------------

    {% for enum in feature_set.enums %}
    {{ enum|enum_type }}, parameter :: {{ enum.name }} &
        = {{ enum|enum_value }}
    {% endfor %}

    ! -------------
    ! Functions
    ! -------------

    {% for command in feature_set.commands %}
    procedure({{ command.name|proc_interface }}), pointer, private :: &
        {{ command.name|proc_pointer }}
    {% endfor %}

    ! -------------
    ! Function interfaces
    ! -------------

    abstract interface
        {% for command in feature_set.commands %}
        {% if command is returning %}
        {{ command|return_type_interface }} &
        {% endif %}
        {{ command|proc_type }} {{ command.name|proc_interface }}({{ command|args }}) bind(C)
            {% if command is returning %}
            import
            {% else %}
            {% if command.params|length != 0 %}
            import
            implicit none
            {% endif %}
            {% endif %}
            {% for param in command.params %}
            {{ param.type|type_interface }} :: {{ param.name|identifier }}
            {% endfor %}
        end {{ command|proc_type }} {{ command.name|proc_interface }}
        {% endfor %}
    end interface

    private :: f_c_str, f_c_strarray
    private :: c_strlen, c_ptr_strlen, c_char_strlen

    interface c_strlen
        pure function c_ptr_strlen(cstr) result(length) bind(C, name="strlen")
            import
            implicit none
            type(c_ptr), value, intent(in) :: cstr
            integer(kind=c_size_t) :: length
        end function c_ptr_strlen
        pure function c_char_strlen(cstr) result(length) bind(C, name="strlen")
            import
            implicit none
            character(len=1,kind=c_char), dimension(*), intent(in) :: cstr
            integer(kind=c_size_t) :: length
        end function c_char_strlen
    end interface c_strlen

    contains

        {% for command in feature_set.commands %}
        {{ command|proc_type }} {{ command.name|proc_impl }}({{ command|args }}) {{ 'result(res)' if command is returning }}
            implicit none
            {% for param in command.params %}
            {{ param.type|type_impl }} :: {{ param.name|identifier }}
            {% endfor %}
            {% for param in command.params %}
            {% if param is requiring_int_var %}
            {{ param|int_var }}
            {% endif %}
            {% endfor %}
            {% if command is returning %}
            {{ command|return_type_impl }} :: res
            {% endif %}

            {% for param in command.params %}
            {% if param is requiring_preprocess %}
            {% if param is optional %}
            if (present({{ param.name|identifier }})) then
                {{ param|preprocess }}
            end if
            {% else %}
            {{ param|preprocess }}
            {% endif %}
            {% endif %}
            {% endfor %}
            {% if command is returning %}
            {{ command|format_result }}
            {% else %}
            call {{ command.name|proc_pointer }}({{ command|int_args }})
            {% endif %}
        end {{ command|proc_type }} {{ command.name|proc_impl }}
        {% endfor %}

        {% for api in feature_set.info.apis %}
        function gladLoad{{ api|api }}(loadfn) result(success)
            implicit none
            procedure(GLADloadfunc) :: loadfn
            logical :: success
            success = .false.

            {% for command in feature_set.commands %}
            call c_f_procpointer(loadfn("{{ command.name }}"),&
                                 {{ command.name|proc_pointer }})
            {% endfor %}

            if (associated(glad_glGetString)) success = .true.
        end function gladLoad{{ api|api }}
        {% endfor %}

        subroutine c_f_strpointer(cptr, fptr)
            implicit none
            type(c_ptr), intent(in) :: cptr
            character(len=:,kind=c_char), pointer, intent(out) :: fptr

            character(len=c_strlen(cptr),kind=c_char), pointer :: temp
            call c_f_pointer(cptr, temp)
            fptr => temp
        end subroutine c_f_strpointer

        pure function f_c_str(fstr) result(cstr)
            implicit none
            character(len=*,kind=c_char), intent(in) :: fstr
            character(len=1,kind=c_char), dimension(:), allocatable :: cstr

            integer :: size
            integer :: i

            size = len_trim(fstr) + 1
            allocate(character(len=1,kind=c_char) :: cstr(size))
            do i = 1,size-1
                cstr(i) = fstr(i:i)
            end do
            cstr(size) = c_null_char
        end function f_c_str

        subroutine f_c_strarray(fstrings, cstrings, carray)
            implicit none
            character(len=:,kind=c_char), dimension(:), pointer, intent(in) :: fstrings
            character(len=:,kind=c_char), dimension(:), target, allocatable, intent(out) :: cstrings
            type(c_ptr), dimension(:), allocatable, intent(out) :: carray

            integer :: i

            if(associated(fstrings)) then
                allocate(character(len(fstrings) + 1) :: cstrings(size(fstrings)))
                allocate(carray(size(fstrings)))
                do i = 1, size(fstrings)
                    cstrings(i) = trim(fstrings(i)) // c_null_char
                    carray(i) = c_loc(cstrings(i))
                end do
            end if
        end subroutine f_c_strarray
end module gl

