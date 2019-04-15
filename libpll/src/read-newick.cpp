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

pll_utree_t * load_tree_unrooted(const char * filename)
{
  pll_utree_t * utree;
  pll_rtree_t * rtree;

  if (!(rtree = pll_rtree_parse_newick(filename)))
  {
    if (!(utree = pll_utree_parse_newick(filename)))
    {
      fprintf(stderr, "%s\n", pll_errmsg);
      return NULL;
    }
  }
  else
  {
    utree = pll_rtree_unroot(rtree);

    pll_unode_t * root = utree->nodes[utree->tip_count+utree->inner_count-1];

    /* optional step if using default PLL clv/pmatrix index assignments */
    pll_utree_reset_template_indices(root, utree->tip_count);

    pll_rtree_destroy(rtree,NULL);
  }

  return utree;
}

int main(int argc, char * argv[])
{

  auto start = std::chrono::high_resolution_clock::now();

  if (argc != 2) {
    fatal("syntax: %s [newick]", argv[0]);
  }

  pll_utree_t * utree = load_tree_unrooted(argv[1]);

  if (!utree) {
    fatal("Tree must be a rooted or unrooted binary.");
  }

  /* select a random inner node */
  // long int r = random() % utree->inner_count;
  // pll_unode_t * root = utree->nodes[utree->tip_count + r];

  /* export the tree to newick format with the selected inner node as the root
     of the unrooted binary tree */
  // char * newick = pll_utree_export_newick(root,NULL);

  pll_utree_destroy(utree,NULL);

  // free(newick);

  std::chrono::duration<double> elapsed = std::chrono::high_resolution_clock::now() - start;
  printf("Internal time: %f\n", elapsed.count());
  return 0;
}
