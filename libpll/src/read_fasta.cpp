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

class MSA
{
public:
  MSA() = default;
  MSA(size_t const size) : labels( size ), sequences( size ) {};
  ~MSA() = default;

  std::vector<std::string> labels;
  std::vector<std::string> sequences;

};

MSA load_fasta(const char * filename)
{
  /* open FASTA file */
  pll_fasta_t * fp = pll_fasta_open(filename, pll_map_fasta);
  if (!fp)
    fatal("Error opening file %s", filename);

  char * seq = NULL;
  char * hdr = NULL;
  long seqlen;
  long hdrlen;
  long seqno;

  /* allocate arrays to store FASTA headers and sequences */
  MSA msa;

  /* read FASTA sequences and make sure they are all of the same length */
  int sites = -1;
  for (int i = 0; pll_fasta_getnext(fp,&hdr,&hdrlen,&seq,&seqlen,&seqno); ++i)
  {
    /* assert that sequence length is not longer than the number unsigned int
       can store */
    assert(!(seqlen & ((unsigned long)(~0) ^ (unsigned int)(~0))));

    // if (sites != -1 && sites != seqlen)
    //   fatal("FASTA file does not contain equal size sequences\n");

    // if (sites == -1) sites = seqlen;

    msa.labels.emplace_back(hdr);
    msa.sequences.emplace_back(seq);
  }

  /* did we stop reading the file because we reached EOF? */
  if (pll_errno != PLL_ERROR_FILE_EOF) {
    fatal("Error while reading file %s", filename);
  }

  /* close FASTA file */
  pll_fasta_close(fp);
  return msa;
}

int main(int argc, char * argv[])
{
  if (argc != 2) {
    fatal("syntax: %s [fasta]", argv[0]);
  }

  auto start = std::chrono::high_resolution_clock::now();

  auto msa = load_fasta(argv[1]);

  std::chrono::duration<double> elapsed = std::chrono::high_resolution_clock::now() - start;
  printf("Internal time: %f\n", elapsed.count());
  return 0;
}
