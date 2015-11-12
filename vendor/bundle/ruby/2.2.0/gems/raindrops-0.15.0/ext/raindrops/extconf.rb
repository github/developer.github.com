require 'mkmf'

dir_config('atomic_ops')
have_func('mmap', 'sys/mman.h') or abort 'mmap() not found'
have_func('munmap', 'sys/mman.h') or abort 'munmap() not found'

$CPPFLAGS += " -D_GNU_SOURCE "
have_func('mremap', 'sys/mman.h')
have_header('linux/tcp.h')

$CPPFLAGS += " -D_BSD_SOURCE "
have_func("getpagesize", "unistd.h")
have_func('rb_thread_blocking_region')
have_func('rb_thread_io_blocking_region')

checking_for "GCC 4+ atomic builtins" do
  # we test CMPXCHG anyways even though we don't need it to filter out
  # ancient i386-only targets without CMPXCHG
  src = <<SRC
int main(int argc, char * const argv[]) {
        unsigned long i = 0;
        __sync_lock_test_and_set(&i, 0);
        __sync_lock_test_and_set(&i, 1);
        __sync_bool_compare_and_swap(&i, 0, 1);
        __sync_add_and_fetch(&i, argc);
        __sync_sub_and_fetch(&i, argc);
        return 0;
}
SRC

  if try_link(src)
    $defs.push(format("-DHAVE_GCC_ATOMIC_BUILTINS"))
    true
  else
    # some compilers still target 386 by default, but we need at least 486
    # to run atomic builtins.
    prev_cflags = $CFLAGS
    $CFLAGS += " -march=i486 "
    if try_link(src)
      $defs.push(format("-DHAVE_GCC_ATOMIC_BUILTINS"))
      true
    else
      prev_cflags = $CFLAGS
      false
    end
  end
end or have_header('atomic_ops.h') or abort <<-SRC

libatomic_ops is required if GCC 4+ is not used.
See http://www.hpl.hp.com/research/linux/atomic_ops/

Users of Debian-based distros may run:

  apt-get install libatomic-ops-dev
SRC
create_makefile('raindrops_ext')
