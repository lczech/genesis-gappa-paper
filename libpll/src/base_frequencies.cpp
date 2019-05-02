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
#include <iostream>

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
    fatal("syntax: %s [fasta]", argv[0]);
  }

  auto msa = pll_phylip_load(argv[1], false);

  auto start = std::chrono::high_resolution_clock::now();

  auto stats = pllmod_msa_compute_stats(msa,
                                        4,
                                        pll_map_nt,
                                        NULL,
                                        PLLMOD_MSA_STATS_FREQS);

  std::chrono::duration<double> elapsed = std::chrono::high_resolution_clock::now() - start;

  for (size_t i = 0; i < 4; ++i) {
    std::cout << stats->freqs[i] << " ";
  }
  std::cout << std::endl;

  printf("Internal time: %f\n", elapsed.count());
  return 0;
}
