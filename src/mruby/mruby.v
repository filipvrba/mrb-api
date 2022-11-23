// mruby format - https://qiita.com/liveralmask/items/1322a23d4fecb3690be6
// The 'libmruby.a' file created during the compilation of Mruby must be stored in the 'lib' subdirectory.

module mruby

#flag -L @VMODROOT/lib
#flag -I @VMODROOT/include
#flag @VMODROOT/lib/libmruby.a -lm
#include "mruby.h"
#include "mruby/compile.h"
#include "mruby/string.h"
#include "mruby/array.h"

struct C.RClass {
}

struct C.mrb_state {
	object_class &C.RClass
	kernel_module &C.RClass
}

struct C.mrb_value {
}

struct C.mrb_kwargs {
}

type Func_t = fn (&C.mrb_state, C.mrb_value) C.mrb_value
type Aspec  = u32

fn C.MRB_ARGS_NONE() Aspec
// fn C.MRB_ARGS_REQ(n) Aspec
fn C.MRB_ARGS_OPT(n_one Aspec) Aspec
fn C.RSTRING_PTR(obj_str C.mrb_value) charptr
fn C.RARRAY_LEN(C.mrb_value) int

fn C.mrb_open() &C.mrb_state
fn C.mrb_load_string(mrb &C.mrb_state, s &char) C.mrb_value
fn C.mrb_close(mrb &C.mrb_state)
fn C.mrb_define_class(mrb &C.mrb_state, name &char, super &C.RClass) &C.RClass
fn C.mrb_define_class_method(mrb_state &C.mrb_state, cla &C.RClass, name &char, fun Func_t, aspec Aspec) voidptr
fn C.mrb_define_method(mrb_state &C.mrb_state, cla &C.RClass, name &char, fun Func_t, aspec Aspec) voidptr
fn C.mrb_get_args(mrb &C.mrb_state, format &char, value &C.mrb_value) int
fn C.mrb_string_p(C.mrb_value) bool
fn C.mrb_fixnum_p(C.mrb_value) bool
fn C.mrb_fixnum(C.mrb_value) int
fn C.mrb_bool(C.mrb_value) u8
fn C.mrb_float_p(C.mrb_value) bool
fn C.mrb_float(C.mrb_value) f32
fn C.mrb_array_p(C.mrb_value) bool
fn C.mrb_array_p(C.mrb_value) bool
fn C.mrb_ary_ref(C.mrb_state, C.mrb_value, int) C.mrb_value
fn C.mrb_string_cstr(&C.mrb_state, C.mrb_value) &u8

pub fn mrb_code(mrb_code string) string {
	mut mrb := C.mrb_open()
	mut mrb_result := ""
	
	mrb_content := C.mrb_load_string(mrb, mrb_code.str)
	mrb_result = get_value(mrb, mrb_content)
	C.mrb_close(mrb)

	return mrb_result
}

fn get_value(mrb &C.mrb_state, value C.mrb_value) string {
	if C.mrb_string_p(value) {
		return unsafe{ tos_clone( C.mrb_string_cstr(mrb, value) ) }
	}
	else if C.mrb_fixnum_p( value ) {
		return C.mrb_fixnum(value).str()
	}
	else if C.mrb_float_p(value) {
		return C.mrb_float(value).str()
	}
	else if C.mrb_array_p(value) {
		mut result := ""
		len := C.RARRAY_LEN(value)
		for i := 0; i < len; i++ {
			str_value := C.mrb_ary_ref( mrb, value, i )
			result += get_value(mrb, str_value)

			if i != len - 1 {
				result += ";"
			}
		}

		return result
	}
	else {
		bool_v := C.mrb_bool(value)
		return if bool_v == 0 { "false" } else { "true" }
	}

	return ""
}