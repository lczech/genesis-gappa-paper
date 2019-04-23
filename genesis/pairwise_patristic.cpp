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

using namespace genesis;
using namespace genesis::tree;

int main( int argc, char** argv )
{
    using namespace std;

    // Check if the command line contains the right number of arguments.
    if (argc != 2) {
        throw std::runtime_error(
            "Need to provide a newick tree file.\n"
        );
    }

    // Activate logging and threads.
    utils::Logging::log_to_stdout();
    utils::Logging::details.time = true;
    utils::Options::get().number_of_threads( 4 );

    // Read in the Tree.
    auto const newick_path = std::string( argv[1] );
    auto const tree = CommonTreeNewickReader().read( utils::from_file( newick_path ));
    LOG_INFO << "Nodes:  " << tree.node_count();
    LOG_INFO << "Leaves: " << leaf_node_count( tree );

    // Start the clock.
    LOG_TIME << "Start matrix calculation " << utils::current_time();
    clock_t const begin = clock();

    // Calculate the deed.
    auto const mat = node_branch_length_distance_matrix( tree );

    // Stop the clock.
    clock_t const end = clock();
    double const elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
    LOG_TIME << "End matrix calculation " << utils::current_time();

    // User output.
    LOG_BOLD << "Internal time: " << elapsed_secs << "\n";
    LOG_INFO << "Matrix size: " << mat.rows() << " x " << mat.cols() << " = " << (mat.rows() * mat.cols());

    std::ofstream outf;
    utils::file_output_stream( "dist_mat.csv", outf );
    outf << mat;
    outf.close();

    LOG_INFO << "Finished " << utils::current_time();
    return 0;
}
