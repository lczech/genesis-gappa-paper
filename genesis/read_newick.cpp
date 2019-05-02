/*
    Genesis - A toolkit for working with phylogenetic data.
    Copyright (C) 2014-2019 Lucas Czech and HITS gGmbH

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Contact:
    Lucas Czech <lucas.czech@h-its.org>
    Exelixis Lab, Heidelberg Institute for Theoretical Studies
    Schloss-Wolfsbrunnenweg 35, D-69118 Heidelberg, Germany
*/

#include "genesis/genesis.hpp"

#include <fstream>
#include <string>
#include <unordered_map>
#include <vector>
#include <ctime>
#include <chrono>

using namespace genesis;
using namespace genesis::tree;

int main( int argc, char** argv )
{
    using namespace std;

    // Activate logging.
    utils::Logging::log_to_stdout();
    utils::Logging::details.time = true;
    utils::Options::get().number_of_threads( 4 );
    LOG_INFO << "Started " << utils::current_time();

    // Get input.
    if (argc != 2) {
        throw std::runtime_error(
            "Need to provide a newick tree file.\n"
        );
    }
    auto newick_path = std::string( argv[1] );

    // Start the clock.
    LOG_TIME << "Start reading";
    auto start = std::chrono::steady_clock::now();

    // Run, Forrest, Run!
    auto tree = CommonTreeNewickReader().read( utils::from_file( newick_path ));

    // Stop the clock
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::steady_clock::now() - start
    );
    LOG_TIME << "Finished Reading " << utils::current_time();
    double elapsed_secs = double(duration.count()) / 1000.0;
    LOG_BOLD << "Internal time: " << elapsed_secs << "\n";

    // Check output
    LOG_INFO << "Leaves: " << leaf_node_count( tree );

    LOG_INFO << "Finished " << utils::current_time();
    return 0;
}
