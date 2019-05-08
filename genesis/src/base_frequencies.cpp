#include "genesis/genesis.hpp"

#include <chrono>

using namespace genesis;
using namespace genesis::sequence;
using namespace genesis::utils;

int main( int argc, char** argv )
{
    // Get input.
    if( argc != 2 ) {
        throw std::runtime_error( "Need to provide a phylip file." );
    }
	auto const infile = std::string( argv[1] );

    // Read input data
    std::cout << "Reading\n";
    auto seqs = FastaReader().read( from_file( infile ));
    std::cout << "Found " << seqs.size() << " sequences.\n";

    // Start the clock.
    std::cout << "Start " << utils::current_time() << "\n";
    auto const start = std::chrono::steady_clock::now();

    // Run, Forrest, Run!
    // auto const bf = base_frequencies( seqs, "ACGU" );
    auto bf = site_histogram( seqs );

    // Stop the clock
    auto const duration = std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::steady_clock::now() - start
    );
    std::cout << "Finished reading " << utils::current_time() << "\n";
    double const elapsed_secs = double(duration.count()) / 1000.0;
    std::cout << "Internal time: " << elapsed_secs << "\n";

    // Check output
    std::cout << "G " << ( bf['g'] + bf['G'] ) << "\n";
    std::cout << "C " << ( bf['c'] + bf['C'] ) << "\n";
    std::cout << "A " << ( bf['a'] + bf['A'] ) << "\n";
    std::cout << "T " << ( bf['t'] + bf['T'] ) << "\n";
    std::cout << "- " << ( bf['-'] + bf['.'] ) << "\n";

    return 0;
}
