#define HELP_TEXT "" \
"Usage: sandbox [options] command [arguments]\n" \
"Options:\n" \
"   -h, --help         prints this help text\n" \
"   -v, --verbose      prints configuration and statistics\n" \
"   -s, --secure       secure mode which creates safe sandbox which almost\n" \
"                      all syscalls are distabled in\n" \
"   -t, --time-limit   set time limit to specified value\n" \
"   -m, --memory-limit set memory limit to specified value\n" \
"   -i, --input-file   redirect stdin for child process from specified file\n" \
"   -o, --output-file  redirect stdout for child process to specified file\n" \
"   -e, --error-file   redirect stderr for child process to specified file\n" \
""