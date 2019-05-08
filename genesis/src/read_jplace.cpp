#include "genesis/genesis.hpp"

#include <chrono>

using namespace genesis;
using namespace genesis::placement;

int main( int argc, char** argv )
{
    // Get input.
    if( argc != 2 ) {
        throw std::runtime_error( "Need to provide a jplace file." );
    }
	auto const infile = std::string( argv[1] );

    // Start the clock.
    std::cout << "Start reading" << utils::current_time() << "\n";
    auto const start = std::chrono::steady_clock::now();

    // Run, Forrest, Run!
    auto const sample = JplaceReader().read( utils::from_file( infile ));

    // Stop the clock
    auto const duration = std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::steady_clock::now() - start
    );
    std::cout << "Finished reading " << utils::current_time() << "\n";
    double const elapsed_secs = double(duration.count()) / 1000.0;
    std::cout << "Internal time: " << elapsed_secs << "\n";

    // Check output
    std::cout << "size " << sample.size() << "\n";
    return 0;
}
