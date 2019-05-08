#include "genesis/genesis.hpp"

#include <chrono>

using namespace genesis;
using namespace genesis::tree;

int main( int argc, char** argv )
{
    // Get input.
    if( argc != 2 ) {
        throw std::runtime_error( "Need to provide a phylip file." );
    }
	auto const infile = std::string( argv[1] );

    // Read in the Tree.
    auto const tree = CommonTreeNewickReader().read( utils::from_file( infile ));

    // Start the clock.
    std::cout << "Start reading" << utils::current_time() << "\n";
    auto const start = std::chrono::steady_clock::now();

    // Calculate the deed.
    auto const mat = node_branch_length_distance_matrix( tree );

    // Stop the clock
    auto const duration = std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::steady_clock::now() - start
    );
    std::cout << "Finished reading " << utils::current_time() << "\n";
    double const elapsed_secs = double(duration.count()) / 1000.0;
    std::cout << "Internal time: " << elapsed_secs << "\n";

    // Check output
    std::cout << "Matrix size: " << mat.rows() << " x " << mat.cols() << "\n";
    return 0;
}
