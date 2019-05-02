extern "C" {
#include "pll.h"
#include "pll_optimize.h"
#include "pllmod_util.h"
#include "pll_msa.h"
#include "pll_binary.h"
#include "pll_tree.h"
}

#include <stdarg.h>
#include <chrono>
#include <vector>
#include <string>

static void fatal(const char * format, ...) __attribute__ ((noreturn));

static void fatal(const char * format, ...)
{
  va_list argptr;
  va_start(argptr, format);
  vfprintf(stderr, format, argptr);
  va_end(argptr);
  fprintf(stderr, "\n");
  exit(EXIT_FAILURE);
}

int main(int argc, char * argv[])
{
  if (argc != 2) {
    fatal("syntax: %s [phylip]", argv[0]);
  }

  auto start = std::chrono::high_resolution_clock::now();

  auto msa = pll_phylip_load(argv[1], false);

  std::chrono::duration<double> elapsed = std::chrono::high_resolution_clock::now() - start;
  printf("Internal time: %f\n", elapsed.count());

  pll_msa_destroy(msa);
  return 0;
}
